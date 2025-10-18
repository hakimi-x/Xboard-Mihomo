import 'dart:async';
import 'dart:convert';
import 'package:fl_clash/xboard/core/core.dart';
import 'package:fl_clash/xboard/features/online_support/services/service_config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// WebSocket连接状态枚举
enum WebSocketStatus {
  connecting,
  connected,
  disconnected,
  error,
}

/// WebSocket消息类型枚举
enum WebSocketMessageType {
  connectionEstablished,
  newMessage,
  messageSent,
  messageRead,
  pong,
  error,
  unknown,
}

/// WebSocket消息模型
class WebSocketMessage {
  final WebSocketMessageType type;
  final dynamic data;

  WebSocketMessage({
    required this.type,
    this.data,
  });

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) {
    WebSocketMessageType type;
    switch (json['type']) {
      case 'connection_established':
        type = WebSocketMessageType.connectionEstablished;
      case 'new_message':
        type = WebSocketMessageType.newMessage;
      case 'message_sent':
        type = WebSocketMessageType.messageSent;
      case 'marked_read':
        type = WebSocketMessageType.messageRead;
      case 'pong':
        type = WebSocketMessageType.pong;
      case 'error':
        type = WebSocketMessageType.error;
      default:
        type = WebSocketMessageType.unknown;
    }

    return WebSocketMessage(
      type: type,
      data: json,
    );
  }
}

/// 客服系统WebSocket服务类
class CustomerSupportWebSocketService {
  final String baseWsUrl;
  WebSocketChannel? _channel;
  final StreamController<WebSocketMessage> _messageController =
      StreamController<WebSocketMessage>.broadcast();
  final StreamController<WebSocketStatus> _statusController =
      StreamController<WebSocketStatus>.broadcast();
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  bool _isConnected = false;
  bool _isDisposed = false;
  int _reconnectAttempts = 0;
  WebSocketStatus _currentStatus = WebSocketStatus.disconnected; // 当前状态

  // 消息流
  Stream<WebSocketMessage> get messageStream => _messageController.stream;

  // 连接状态流
  Stream<WebSocketStatus> get statusStream => _statusController.stream;

  // 当前连接状态(布尔值)
  bool get isConnected => _isConnected;

  // 当前连接状态(枚举值)
  WebSocketStatus get currentStatus => _currentStatus;

  CustomerSupportWebSocketService({
    required this.baseWsUrl,
  });

  /// 更新连接状态(内部辅助方法)
  void _updateStatus(WebSocketStatus status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  /// 连接到WebSocket服务器
  Future<void> connect({
    bool forceReconnect = false,
    bool isReconnect = false,
  }) async {
    if (_isDisposed) return;
    if (_isConnected && !forceReconnect) {
      XBoardLogger.warning('WebSocket已连接，请先断开');
      return;
    }

    // 如果是强制重连，先断开现有连接
    if (forceReconnect && _isConnected) {
      XBoardLogger.info('强制重连：断开现有WebSocket连接');
      await _disconnect(shouldReconnect: isReconnect);
    }

    try {
      _updateStatus(WebSocketStatus.connecting);

      // 获取用户token
      final token = await CustomerSupportServiceConfig.getUserToken();

      if (token == null) {
        _updateStatus(WebSocketStatus.error);
        XBoardLogger.error(
            'WebSocket连接失败: 无法获取用户token');
        _reconnect();
        return;
      }

      // 构建带有token的WebSocket URL
      // 不在URL中包含token，而是建立基本连接
      final wsUrl = '$baseWsUrl/ws';
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      // 连接建立后，通过消息发送token进行认证
      _channel!.sink.add(jsonEncode({'type': 'auth', 'token': token}));

      // 监听消息
      _channel!.stream.listen(
        (message) {
          _handleMessage(message);
        },
        onError: (error) {
          XBoardLogger.error(
              'WebSocket错误，准备重连', error);
          _updateStatus(WebSocketStatus.error);
          _disconnect(shouldReconnect: true);
        },
        onDone: () {
          XBoardLogger.info(
              'WebSocket连接已关闭，准备重连');
          _updateStatus(WebSocketStatus.disconnected);
          _disconnect(shouldReconnect: true);
        },
      );

      // 启动心跳检测
      _startHeartbeat();
    } catch (e) {
      XBoardLogger.error('WebSocket连接异常，准备重连', e);
      _updateStatus(WebSocketStatus.error);
      _reconnect();
    }
  }

  /// 断开WebSocket连接(内部使用)
  Future<void> _disconnect({bool shouldReconnect = false}) async {
    if (_isDisposed) return;
    _stopHeartbeat();
    await _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    if (shouldReconnect) {
      _reconnect();
    }
  }

  void _reconnect() {
    if (_isDisposed || (_reconnectTimer?.isActive ?? false)) return;

    final duration = Duration(seconds: 5 * (_reconnectAttempts + 1));
    _reconnectTimer = Timer(duration, () {
      XBoardLogger.info(
          '$_reconnectAttempts次尝试重连WebSocket...');
      connect(forceReconnect: true, isReconnect: true);
      _reconnectAttempts++;
    });
  }

  /// 发送文本消息
  void sendMessage(String content) {
    if (!_isConnected || _channel == null) {
      XBoardLogger.warning('WebSocket未连接，无法发送消息');
      return;
    }

    final message = {
      'type': 'message',
      'content': content,
    };

    _channel!.sink.add(jsonEncode(message));
  }

  /// 发送带附件的消息
  void sendMessageWithAttachments(String content, List<int> attachmentIds) {
    if (!_isConnected || _channel == null) {
      XBoardLogger.warning('WebSocket未连接，无法发送带附件消息');
      return;
    }

    final message = {
      'type': 'message_with_attachments',
      'content': content,
      'attachment_ids': attachmentIds,
    };

    XBoardLogger.debug(
        'WebSocket发送带附件消息: ${jsonEncode(message)}');
    _channel!.sink.add(jsonEncode(message));
  }

  /// 标记消息为已读
  void markMessagesAsRead(List<int> messageIds) {
    if (!_isConnected || _channel == null) {
      XBoardLogger.warning('WebSocket未连接，无法标记消息');
      return;
    }

    final message = {
      'type': 'mark_read',
      'message_ids': messageIds,
    };

    final messageJson = jsonEncode(message);
    XBoardLogger.debug(
        'WebSocket发送标记已读消息: $messageJson');
    _channel!.sink.add(messageJson);
  }

  /// 处理收到的WebSocket消息
  void _handleMessage(dynamic message) {
    try {
      // 确保消息是字符串类型
      final String messageStr = message.toString();
      XBoardLogger.debug(
          'WebSocket原始消息: $messageStr');

      // 解析JSON
      final data = jsonDecode(messageStr) as Map<String, dynamic>;
      final wsMessage = WebSocketMessage.fromJson(data);

      XBoardLogger.debug(
          'WebSocket消息类型: ${wsMessage.type}');
      XBoardLogger.debug(
          'WebSocket消息数据: ${wsMessage.data}');

      // 处理连接建立消息
      if (wsMessage.type == WebSocketMessageType.connectionEstablished) {
        _isConnected = true;
        _reconnectAttempts = 0;
        _updateStatus(WebSocketStatus.connected);
        XBoardLogger.info('WebSocket连接已建立');
      }

      // 处理标记已读确认
      if (wsMessage.type == WebSocketMessageType.messageRead) {
        XBoardLogger.info(
            '收到标记已读确认: ${wsMessage.data}');
      }

      // 将消息传递给监听器
      _messageController.add(wsMessage);
    } catch (e) {
      XBoardLogger.error('处理WebSocket消息异常', e);
      XBoardLogger.debug('原始消息: $message');
    }
  }

  /// 启动心跳检测
  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) => _sendHeartbeat(),
    );
  }

  /// 停止心跳检测
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  /// 发送心跳消息
  void _sendHeartbeat() {
    if (_channel != null) {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final message = {
        'type': 'ping',
        'timestamp': timestamp,
      };
      _channel!.sink.add(jsonEncode(message));
    }
  }

  /// 关闭服务，释放资源
  void dispose() {
    _isDisposed = true;
    _reconnectTimer?.cancel();
    _disconnect();
    _messageController.close();
    _statusController.close();
  }
}
