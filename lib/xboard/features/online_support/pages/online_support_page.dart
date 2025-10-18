import 'package:flutter/material.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/online_support/models/message_model.dart';
import 'package:fl_clash/xboard/features/online_support/providers/chat_provider.dart';
import 'package:fl_clash/xboard/features/online_support/services/websocket_service.dart';
import 'package:fl_clash/xboard/features/online_support/widgets/chat_message_widget.dart';
import 'package:fl_clash/xboard/features/online_support/widgets/image_picker_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnlineSupportPage extends ConsumerStatefulWidget {
  const OnlineSupportPage({super.key});

  @override
  ConsumerState<OnlineSupportPage> createState() => _OnlineSupportPageState();
}

class _OnlineSupportPageState extends ConsumerState<OnlineSupportPage> {
  late final TextEditingController textController;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    scrollController = ScrollController();

    // 添加滚动监听器用于加载更多消息
    scrollController.addListener(_onScroll);

    // 标记用户进入对话页面
    setUserOnSupportPage(true);

    // WebSocket 连接已由 webSocketAutoConnectorProvider 自动管理
    // 页面只负责显示消息,不再管理连接生命周期
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.9) {
      final chatState = ref.read(chatProvider);
      final chatNotifier = ref.read(chatProvider.notifier);
      if (!chatState.isLoadingMore && chatState.hasMoreMessages) {
        chatNotifier.loadMoreMessages();
      }
    }
  }

  @override
  void dispose() {
    // 标记用户离开对话页面
    setUserOnSupportPage(false);

    scrollController.removeListener(_onScroll);
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final chatNotifier = ref.watch(chatProvider.notifier);

    // 直接从全局 WebSocket 服务获取实时连接状态
    final wsConnectionStatusAsync = ref.watch(wsConnectionStatusProvider);
    final wsConnectionStatus = wsConnectionStatusAsync.when(
      data: (status) => status,
      loading: () => WebSocketStatus.connecting,
      error: (_, __) => WebSocketStatus.error,
    );

    // 收到新消息时滚动到底部
    void scrollToBottom() {
      if (scrollController.hasClients) {
        // 使用 Future.delayed 确保UI已经更新后再滚动
        Future.delayed(const Duration(milliseconds: 100), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    }

    // 发送文本消息
    void sendMessage() {
      final message = textController.text.trim();
      if (message.isNotEmpty) {
        // 立即清空输入框，提升用户体验
        textController.clear();
        // 发送消息
        chatNotifier.sendMessage(message);
        // 滚动到底部
        scrollToBottom();
      }
    }

    // 发送带附件的消息
    void sendMessageWithAttachments(List<MessageAttachment> attachments) {
      final message = textController.text.trim();
      // 清空输入框
      textController.clear();
      // 发送消息
      chatNotifier.sendMessageWithAttachments(
        content: message,
        attachments: attachments,
      );
      // 滚动到底部
      scrollToBottom();
      // 关闭底部弹窗
      Navigator.of(context).pop();
    }

    // 显示图片选择器
    void showImagePicker() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => ImagePickerWidget(
          onAttachmentsSelected: sendMessageWithAttachments,
          onCancel: () => Navigator.of(context).pop(),
        ),
      );
    }


    // 标记消息为已读
    void markMessagesAsRead() {
      final unreadMessageIds = chatState.messages
          .where((m) => !m.read && m.senderType == SenderType.agent)
          .map((m) => m.id.toString())
          .toList();

      if (unreadMessageIds.isNotEmpty) {
        chatNotifier.markMessagesAsRead(unreadMessageIds);
      }
    }

    // 获取连接状态文本和颜色(使用全局 WebSocket 服务的实时状态)
    String getConnectionStatusText() {
      switch (wsConnectionStatus) {
        case WebSocketStatus.connected:
          return appLocalizations.onlineSupportConnected;
        case WebSocketStatus.connecting:
          return appLocalizations.onlineSupportConnecting;
        case WebSocketStatus.disconnected:
          return appLocalizations.onlineSupportDisconnected;
        case WebSocketStatus.error:
          return appLocalizations.onlineSupportConnectionError;
      }
    }

    Color getConnectionStatusColor() {
      switch (wsConnectionStatus) {
        case WebSocketStatus.connected:
          return Colors.green;
        case WebSocketStatus.connecting:
          return Colors.orange;
        case WebSocketStatus.disconnected:
          return Colors.grey;
        case WebSocketStatus.error:
          return Colors.red;
      }
    }

    // 页面构建
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(appLocalizations.onlineSupportTitle),
            // 连接状态显示在标题下方
            Text(
              getConnectionStatusText(),
              style: TextStyle(
                fontSize: 12,
                color: getConnectionStatusColor(),
              ),
            ),
          ],
        ),
        centerTitle: true,
        // actions: [
        //   // 添加清除历史按钮
        //   IconButton(
        //     icon: const Icon(Icons.delete_outline),
        //     tooltip: '清除历史记录',
        //     onPressed: showClearHistoryDialog,
        //   ),
        //   const SizedBox(width: 8),
        // ],
      ),
      body: Column(
        children: [
          // 消息列表
          Expanded(
            child: chatState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : chatState.messages.isEmpty
                    ? Center(child: Text(appLocalizations.onlineSupportNoMessages))
                    : CustomScrollView(
                        controller: scrollController,
                        // 反转滚动视图，使最新消息在底部
                        reverse: true,
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                // 获取消息
                                final message = chatState.messages[index];

                                // 标记客服消息为已读
                                if (message.senderType == SenderType.agent &&
                                    !message.read) {
                                  // 使用Future.microtask避免在构建过程中修改状态
                                  Future.microtask(() => markMessagesAsRead());
                                }

                                // 返回消息组件
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  child: ChatMessageWidget(
                                    message: message.content,
                                    isFromUser:
                                        message.senderType == SenderType.user,
                                    timestamp: message.createdAt,
                                    attachments: message.attachments,
                                  ),
                                );
                              },
                              childCount: chatState.messages.length,
                            ),
                          ),
                          // 加载更多指示器
                          if (chatState.isLoadingMore)
                            const SliverToBoxAdapter(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                        ],
                      ),
          ),

          // 错误提示
          if (chatState.isError)
            Container(
              color: Colors.red.withValues(alpha: 0.1),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: Text(
                chatState.errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          // 输入区域
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                // 图片选择按钮
                IconButton(
                  onPressed: chatState.isSending ? null : showImagePicker,
                  icon: Icon(
                    Icons.image,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  tooltip: appLocalizations.onlineSupportSendImage,
                ),
                const SizedBox(width: 4),

                // 文本输入框
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: appLocalizations.onlineSupportInputHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),

                // 发送按钮
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: chatState.isSending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: chatState.isSending ? null : sendMessage,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
