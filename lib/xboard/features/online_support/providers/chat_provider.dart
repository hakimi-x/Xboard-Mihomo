import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/xboard/core/core.dart';
import 'package:fl_clash/xboard/features/online_support/models/message_model.dart';
import 'package:fl_clash/core/controllers/xboard/online_support_page_controller.dart';
import 'package:fl_clash/xboard/features/online_support/services/api_service.dart';
import 'package:fl_clash/xboard/features/online_support/services/service_config.dart';
import 'package:fl_clash/xboard/features/online_support/services/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 客服聊天状态类
class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final bool isLoadingMore;
  final bool hasMoreMessages;
  final int unreadCount;
  final bool isSending;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
    this.isLoadingMore = false,
    this.hasMoreMessages = true,
    this.unreadCount = 0,
    this.isSending = false,
  });

  /// 创建一个新状态副本
  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    bool? isLoadingMore,
    bool? hasMoreMessages,
    int? unreadCount,
    bool? isSending,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreMessages: hasMoreMessages ?? this.hasMoreMessages,
      unreadCount: unreadCount ?? this.unreadCount,
      isSending: isSending ?? this.isSending,
    );
  }
}

/// 全局标志：用户是否在在线客服页面
bool _isUserOnSupportPage = false;

/// 设置用户是否在在线客服页面
void setUserOnSupportPage(bool isOnPage) {
  _isUserOnSupportPage = isOnPage;
  XBoardLogger.debug('在线客服页面可见性: $isOnPage');
}

/// 客服聊天Notifier
class ChatNotifier extends StateNotifier<ChatState> {
  final CustomerSupportApiService _apiService;
  final CustomerSupportWebSocketService _wsService;
  StreamSubscription? _wsMessageSubscription;
  int _currentOffset = 0;
  static const int _pageSize = 20;

  ChatNotifier({
    required CustomerSupportApiService apiService,
    required CustomerSupportWebSocketService wsService,
  })  : _apiService = apiService,
        _wsService = wsService,
        super(const ChatState()) {
    _init();
  }

  /// 初始化
  Future<void> _init() async {
    // 初始状态设置为加载中
    state = state.copyWith(isLoading: true);

    // 尝试加载消息历史
    try {
      await loadMessages();

      // 获取未读消息数
      await refreshUnreadCount();

      // 监听WebSocket消息
      _listenToWebSocketMessages();

      // WebSocket 连接已由 webSocketAutoConnectorProvider 自动管理
      // 连接状态由 wsConnectionStatusProvider 直接提供给 UI
      // 不再需要在这里监听状态或手动连接
    } catch (e) {
      XBoardLogger.error('初始化异常', e);
      state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: '初始化失败: $e',
      );
    }
  }

  /// 发送文本消息
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty || state.isSending) return;

    // 设置发送状态
    state = state.copyWith(isSending: true);

    // 立即添加用户消息到本地状态，提升用户体验
    final localMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch,
      content: content.trim(),
      senderType: SenderType.user,
      messageType: MessageType.text,
      read: true,
      createdAt: DateTime.now().toIso8601String(),
    );
    
    // 清除错误状态并立即显示用户消息
    state = state.copyWith(
      messages: [localMessage, ...state.messages],
      isError: false, 
      errorMessage: '',
    );

    // 异步发送消息到服务器
    try {
      await _apiService.sendMessage(content.trim());
      // 发送成功，清除发送状态
      state = state.copyWith(isSending: false);
    } catch (e) {
      XBoardLogger.error('发送消息异常', e);
      // 发送失败时不移除本地消息，但显示错误提示
      state = state.copyWith(
        isSending: false,
        isError: true,
        errorMessage: '发送消息失败: $e',
      );
    }
  }

  /// 发送带附件的消息
  Future<void> sendMessageWithAttachments({
    String content = '',
    required List<MessageAttachment> attachments,
  }) async {
    if (attachments.isEmpty || state.isSending) return;

    // 设置发送状态
    state = state.copyWith(isSending: true);

    // 立即添加用户消息到本地状态，提升用户体验
    final localMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch,
      content: content.trim(),
      senderType: SenderType.user,
      messageType: attachments.any((a) => a.isImage) ? MessageType.image : MessageType.file,
      attachments: attachments,
      read: true,
      createdAt: DateTime.now().toIso8601String(),
    );
    
    // 清除错误状态并立即显示用户消息
    state = state.copyWith(
      messages: [localMessage, ...state.messages],
      isError: false, 
      errorMessage: '',
    );

    // 异步发送消息到服务器
    try {
      final attachmentIds = attachments.map((a) => a.id).toList();
      
      // 优先使用WebSocket发送
      if (_wsService.isConnected) {
        _wsService.sendMessageWithAttachments(content.trim(), attachmentIds);
      } else {
        // 后备使用HTTP API
        await _apiService.sendMessageWithAttachments(
          content: content.trim(),
          attachmentIds: attachmentIds,
        );
      }
      
      // 发送成功，清除发送状态
      state = state.copyWith(isSending: false);
    } catch (e) {
      XBoardLogger.error('发送带附件消息异常', e);
      // 发送失败时不移除本地消息，但显示错误提示
      state = state.copyWith(
        isSending: false,
        isError: true,
        errorMessage: '发送消息失败: $e',
      );
    }
  }

  /// 加载消息历史
  Future<void> loadMessages() async {
    try {
      final response = await _apiService.getMessageHistory(
        offset: 0,
        limit: _pageSize,
      );
      
      final messages = response.items;
      _currentOffset = messages.length;

      state = state.copyWith(
        messages: messages,
        isLoading: false,
        hasMoreMessages: messages.length == _pageSize,
      );
    } catch (e) {
      XBoardLogger.error('加载消息历史异常', e);
      state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: '加载消息失败: $e',
      );
    }
  }

  /// 加载更多消息
  Future<void> loadMoreMessages() async {
    if (state.isLoadingMore || !state.hasMoreMessages) return;

    try {
      state = state.copyWith(isLoadingMore: true);

      final response = await _apiService.getMessageHistory(
        offset: _currentOffset,
        limit: _pageSize,
      );
      
      final moreMessages = response.items;
      _currentOffset += moreMessages.length;

      state = state.copyWith(
        messages: [...state.messages, ...moreMessages],
        isLoadingMore: false,
        hasMoreMessages: moreMessages.length == _pageSize,
      );
    } catch (e) {
      XBoardLogger.error('加载更多消息异常', e);
      state = state.copyWith(
        isLoadingMore: false,
        isError: true,
        errorMessage: '加载更多消息失败: $e',
      );
    }
  }

  /// 刷新未读消息数
  Future<void> refreshUnreadCount() async {
    try {
      final unreadCount = await _apiService.getUnreadCount();
      state = state.copyWith(unreadCount: unreadCount);
    } catch (e) {
      XBoardLogger.error('获取未读消息数异常', e);
    }
  }

  /// 标记消息为已读
  Future<void> markMessagesAsRead(List<String> messageIds) async {
    if (messageIds.isEmpty) return;

    // 更新本地状态（立即更新，提升用户体验）
    final updatedMessages = state.messages.map((message) {
      if (messageIds.contains(message.id.toString())) {
        return ChatMessage(
          id: message.id,
          content: message.content,
          senderType: message.senderType,
          read: true,
          createdAt: message.createdAt,
        );
      }
      return message;
    }).toList();

    final newUnreadCount = updatedMessages
        .where((m) => !m.read && m.senderType == SenderType.agent)
        .length;

    state = state.copyWith(
      messages: updatedMessages,
      unreadCount: newUnreadCount,
    );

    // 尝试通过WebSocket标记已读（根据后端源码，这是主要实现方式）
    try {
      if (_wsService.isConnected) {
        final messageIntIds = messageIds
            .map((id) => int.tryParse(id))
            .where((id) => id != null)
            .cast<int>()
            .toList();
        
        if (messageIntIds.isNotEmpty) {
          XBoardLogger.debug('通过WebSocket标记消息已读: $messageIntIds');
          _wsService.markMessagesAsRead(messageIntIds);
        }
      } else {
        XBoardLogger.debug('WebSocket未连接，尝试HTTP API标记已读');
        // 如果WebSocket未连接，尝试HTTP API
        await _apiService.markMessagesAsRead(messageIds);
      }
    } catch (e) {
      XBoardLogger.error('标记消息已读失败', e);
      // 即使服务端标记失败，本地状态已经更新，用户体验不受影响
    }
  }

  /// 显示应用内通知
  void _showInAppNotification(ChatMessage message) {
    try {
      // 检查当前是否在对话页面
      if (_isUserOnSupportPage) {
        XBoardLogger.debug('用户已在对话页面，跳过通知');
        return;
      }

      // 截取消息内容，最多显示50个字符
      final content = message.content.length > 50
          ? '${message.content.substring(0, 50)}...'
          : message.content;

      // 使用全局通知系统显示消息，带点击跳转功能
      globalState.showNotifier(
        '${appLocalizations.newMessageFromSupport}: $content',
        onTap: () {
          _navigateToSupportPage();
        },
      );

      XBoardLogger.debug('已显示应用内通知');
    } catch (e) {
      XBoardLogger.error('显示应用内通知失败', e);
    }
  }

  /// 导航到在线客服页面
  void _navigateToSupportPage() {
    try {
      final context = globalState.navigatorKey.currentContext;
      if (context != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const OnlineSupportPageController(),
          ),
        );
        XBoardLogger.debug('已跳转到在线客服页面');
      } else {
        XBoardLogger.warning('无法获取context，跳转失败');
      }
    } catch (e) {
      XBoardLogger.error('跳转到在线客服页面失败', e);
    }
  }

  /// 监听WebSocket消息
  void _listenToWebSocketMessages() {
    _wsMessageSubscription?.cancel();
    _wsMessageSubscription = _wsService.messageStream.listen(
      (wsMessage) {
        // 只处理新消息类型
        if (wsMessage.type == WebSocketMessageType.newMessage && wsMessage.data != null) {
          final wsData = wsMessage.data as Map<String, dynamic>;
          
          // 从正确的路径获取消息数据
          final messageData = wsData['message'] as Map<String, dynamic>?;
          if (messageData != null) {
            final messageId = messageData['id'] as int? ?? DateTime.now().millisecondsSinceEpoch;
            
            XBoardLogger.debug('收到新消息: ID=$messageId, 内容=${messageData['content']}', null);
            
            // 检查是否已存在相同ID的消息，避免重复
            final existingMessage = state.messages.any((msg) => msg.id == messageId);
            if (!existingMessage) {
              // 添加新消息到状态中
              final newMessage = ChatMessage(
                id: messageId,
                content: messageData['content']?.toString() ?? '',
                senderType: SenderType.agent,
                read: false,
                createdAt: messageData['created_at']?.toString() ?? DateTime.now().toIso8601String(),
              );

              state = state.copyWith(
                messages: [newMessage, ...state.messages],
                unreadCount: state.unreadCount + 1,
              );

              XBoardLogger.debug('新消息已添加到状态');

              // 显示应用内通知
              _showInAppNotification(newMessage);
            } else {
              XBoardLogger.warning('消息ID=$messageId 已存在，跳过');
            }
          } else {
            XBoardLogger.error('WebSocket消息格式错误，缺少message字段');
          }
        }
      },
      onError: (error) {
        XBoardLogger.error('WebSocket消息监听异常', error);
        state = state.copyWith(
          isError: true,
          errorMessage: 'WebSocket消息异常: $error',
        );
      },
    );
  }

  @override
  void dispose() {
    _wsMessageSubscription?.cancel();
    super.dispose();
  }
}

// Provider定义
final apiServiceProvider = Provider<CustomerSupportApiService>((ref) {
  final apiBaseUrl = CustomerSupportServiceConfig.apiBaseUrl;
  if (apiBaseUrl == null) {
    throw Exception(appLocalizations.onlineSupportApiConfigNotFound);
  }
  return CustomerSupportApiService(
    baseUrl: apiBaseUrl,
  );
});

final wsServiceProvider = Provider<CustomerSupportWebSocketService>((ref) {
  final wsBaseUrl = CustomerSupportServiceConfig.wsBaseUrl;
  if (wsBaseUrl == null) {
    throw Exception(appLocalizations.onlineSupportWebSocketConfigNotFound);
  }

  final service = CustomerSupportWebSocketService(
    baseWsUrl: wsBaseUrl,
  );

  // 确保 dispose 时清理资源
  ref.onDispose(() {
    XBoardLogger.info('wsServiceProvider 被销毁,清理 WebSocket 资源', null);
    service.dispose();
  });

  return service;
}); // ⭐ 保持单例,不随页面销毁而重建
// keepAlive 在 Riverpod 2.0+ 中默认启用,Provider 会一直保持活跃直到整个应用关闭

/// WebSocket 连接状态 Provider
/// 提供实时的 WebSocket 连接状态,供 UI 层订阅
/// 先发送当前状态,然后监听后续变化,确保订阅时能立即获取状态
final wsConnectionStatusProvider = StreamProvider<WebSocketStatus>((ref) async* {
  final wsService = ref.watch(wsServiceProvider);

  // 先 yield 当前状态
  yield wsService.currentStatus;

  // 然后监听后续状态变化
  await for (final status in wsService.statusStream) {
    yield status;
  }
});

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final wsService = ref.watch(wsServiceProvider);
  
  return ChatNotifier(
    apiService: apiService,
    wsService: wsService,
  );
});