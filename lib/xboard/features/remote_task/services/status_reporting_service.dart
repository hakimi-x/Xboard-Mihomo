import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fl_clash/xboard/core/core.dart';

import '../utils/node_id_manager.dart';
import 'package:web_socket_channel/io.dart';
class StatusReportingService {
  final String _wsUrl;
  final String? authToken;
  IOWebSocketChannel? _channel;
  StreamSubscription? _subscription;
  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;
  bool _isConnected = false;
  bool _isDisposed = false;
  Function(bool isConnected)? onStatusChange;
  Function(String message)? onMessageReceivedCallback;
  StatusReportingService(this._wsUrl, {this.onStatusChange, this.onMessageReceivedCallback, this.authToken});
  void connect() async {
    if (_isConnected || _isDisposed) return;
    _reconnectTimer?.cancel();
    
    // 获取node_id并构建完整的WebSocket URL
    final nodeId = await NodeIdManager.getNodeId();
    XBoardLogger.debug('原始WebSocket URL: $_wsUrl');
    XBoardLogger.debug('Node ID: $nodeId');
    final fullWsUrl = _wsUrl.endsWith('/') ? '${_wsUrl}$nodeId' : '$_wsUrl/$nodeId';
    XBoardLogger.debug('完整WebSocket URL: $fullWsUrl');
    
    XBoardLogger.info('尝试连接 WebSocket: $fullWsUrl (Node ID: $nodeId)');
    try {
      Map<String, String> headers = {};
      if (authToken != null) {
        headers['Authorization'] = 'Bearer $authToken';
      }
      
      // Use IOWebSocketChannel.connect with headers and custom HTTP client for SSL bypass
      _channel = IOWebSocketChannel.connect(
        fullWsUrl,
        headers: headers,
        customClient: () {
          final client = HttpClient();
          // 忽略SSL证书验证错误（仅用于WebSocket连接）
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
          return client;
        }(),
      );

      _subscription = _channel!.stream.listen(
        _onMessageReceived,
        onDone: _onDisconnected,
        onError: _onError,
        cancelOnError: true,
      );
      _sendIdentification();
      _startHeartbeat(); // 立即开始心跳
    } catch (e) {
      XBoardLogger.error('WebSocket 初始连接时发生同步错误', e);
      _scheduleReconnect();
    }
  }
  void _sendIdentification() async {
    final nodeId = await NodeIdManager.getNodeId();
    final identityPayload = {
      'event': 'identify',
      'payload': {
        'nodeId': nodeId,
      }
    };
    if (_channel != null) {
      try {
        final message = jsonEncode(identityPayload);
        _channel!.sink.add(message);
        XBoardLogger.debug('WebSocket 发送身份识别消息: $message');
      } catch (e) {
        XBoardLogger.error('WebSocket 发送身份识别消息失败', e);
      }
    }
  }
  void _onMessageReceived(dynamic message) {
    if (!_isConnected) {
      _isConnected = true;
      onStatusChange?.call(true);
      XBoardLogger.info('WebSocket 已成功连接到: $_wsUrl');
    }
    XBoardLogger.debug('WebSocket 接收到消息: $message');
    if (message is String) {
      onMessageReceivedCallback?.call(message);
    }
  }
  void _onError(dynamic error) {
    XBoardLogger.error('WebSocket 连接错误', error);
    _handleDisconnect(isError: true);
  }
  void _onDisconnected() {
    XBoardLogger.info('WebSocket 连接已由对端关闭');
    _handleDisconnect(isError: false);
  }
  void _handleDisconnect({required bool isError}) {
    if (_subscription == null && !_isConnected) {
      return;
    }
    if (_isConnected) {
      XBoardLogger.info('WebSocket 已断开连接');
    } else if (isError) {
      XBoardLogger.warning('WebSocket 连接失败');
    }
    _isConnected = false;
    onStatusChange?.call(false);
    _subscription?.cancel();
    _subscription = null; // Mark as cleaned up.
    _stopHeartbeat();
    if (!_isDisposed) {
      _scheduleReconnect();
    }
  }
  void _scheduleReconnect() {
    if (_isDisposed) return;
    _reconnectTimer?.cancel();
    XBoardLogger.info('计划在 5 秒后重新连接');
    _reconnectTimer = Timer(const Duration(seconds: 5), connect);
  }
  void dispose() {
    _isDisposed = true;
    _reconnectTimer?.cancel();
    _stopHeartbeat();
    _subscription?.cancel();
    _channel?.sink.close();
    if (_isConnected) {
      _isConnected = false;
      onStatusChange?.call(false);
    }
    XBoardLogger.info('StatusReportingService 已释放');
  }
  void sendMessage(String message) {
    if (_isConnected && _channel != null) {
      try {
        _channel!.sink.add(message);
        XBoardLogger.debug('WebSocket 发送消息: $message');
      } catch (e) {
        XBoardLogger.error('WebSocket 发送消息失败', e);
      }
    } else {
      XBoardLogger.warning('WebSocket 未连接，无法发送消息: $message');
    }
  }
  void _sendPing() {
    if (_channel != null) {
      try {
        final pingPayload = {'event': 'ping'};
        final message = jsonEncode(pingPayload);
        _channel!.sink.add(message);
        XBoardLogger.debug('WebSocket 发送心跳: $message');
      } catch (e) {
        XBoardLogger.error('WebSocket 发送心跳失败', e);
      }
    }
  }
  void _startHeartbeat() {
    _stopHeartbeat();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_isDisposed) {
        timer.cancel();
        return;
      }
      _sendPing();
    });
  }
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
  }
}