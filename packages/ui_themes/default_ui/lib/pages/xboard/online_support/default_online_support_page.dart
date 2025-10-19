// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 在线客服页面
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class DefaultOnlineSupportPage extends OnlineSupportPageContract {
  const DefaultOnlineSupportPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('在线客服'),
            Text(
              _getConnectionStatusText(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          if (data.connectionStatus != ConnectionStatus.connected)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: callbacks.onReconnect,
            ),
        ],
      ),
      body: Column(
        children: [
          // 连接状态提示
          if (data.connectionStatus != ConnectionStatus.connected)
            Container(
              padding: const EdgeInsets.all(8),
              color: _getConnectionStatusColor(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (data.connectionStatus == ConnectionStatus.connecting || 
                      data.connectionStatus == ConnectionStatus.reconnecting)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  const SizedBox(width: 8),
                  Text(_getConnectionStatusText()),
                  if (data.connectionStatus == ConnectionStatus.failed) ...[
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: callbacks.onReconnect,
                      child: const Text('重试'),
                    ),
                  ],
                ],
              ),
            ),
          
          // 消息列表
          Expanded(
            child: data.messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text('暂无消息', style: Theme.of(context).textTheme.bodyLarge),
                        if (data.isSupportOnline && data.averageResponseTime != null)
                          Text('平均响应时间：${data.averageResponseTime}秒'),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    reverse: true,
                    itemCount: data.messages.length,
                    itemBuilder: (context, index) {
                      final msg = data.messages[data.messages.length - 1 - index];
                      return _buildMessageBubble(context, msg);
                    },
                  ),
          ),
          
          // 输入栏
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: callbacks.onUploadImage,
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: callbacks.onTakePhoto,
                ),
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: data.inputText),
                    decoration: InputDecoration(
                      hintText: '输入消息...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    maxLines: null,
                    enabled: data.canSendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: data.canSendMessage ? () => callbacks.onSendMessage(data.inputText) : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getConnectionStatusText() {
    switch (data.connectionStatus) {
      case ConnectionStatus.connecting:
        return '连接中...';
      case ConnectionStatus.connected:
        return data.isSupportOnline ? '客服在线' : '客服离线';
      case ConnectionStatus.reconnecting:
        return '重新连接中...';
      case ConnectionStatus.failed:
        return '连接失败';
      default:
        return '未连接';
    }
  }

  Color _getConnectionStatusColor(BuildContext context) {
    switch (data.connectionStatus) {
      case ConnectionStatus.connected:
        return Colors.green.shade100;
      case ConnectionStatus.failed:
        return Colors.red.shade100;
      default:
        return Colors.orange.shade100;
    }
  }

  Widget _buildMessageBubble(BuildContext context, ChatMessage msg) {
    final isUser = msg.sender == MessageSender.user;
    final isSystem = msg.sender == MessageSender.system;
    
    if (isSystem) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(msg.content, style: Theme.of(context).textTheme.bodySmall),
        ),
      );
    }
    
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (msg.type == MessageType.image && msg.attachment != null)
              Image.network(msg.attachment!.url, width: 200)
            else
              Text(msg.content),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  msg.timestamp.toString().substring(11, 16),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (isUser) ...[
                  const SizedBox(width: 4),
                  if (msg.isSending)
                    const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 1))
                  else if (msg.sendFailed)
                    InkWell(
                      onTap: () => callbacks.onResendMessage(msg),
                      child: const Icon(Icons.error, size: 16, color: Colors.red),
                    )
                  else
                    Icon(msg.isRead ? Icons.done_all : Icons.done, size: 16),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

