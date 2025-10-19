// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 在线客服页面
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class ModernOnlineSupportPage extends OnlineSupportPageContract {
  const ModernOnlineSupportPage({super.key, required super.data, required super.callbacks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, title: const Text('在线客服'), actions: [if (data.connectionStatus != ConnectionStatus.connected) IconButton(icon: const Icon(Icons.refresh), onPressed: callbacks.onReconnect)]),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Theme.of(context).colorScheme.primary.withOpacity(0.1), Colors.transparent])),
        child: Column(
          children: [
            const SizedBox(height: 100),
            if (data.connectionStatus != ConnectionStatus.connected)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: _getStatusColor().withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [if (data.connectionStatus == ConnectionStatus.connecting) const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)), const SizedBox(width: 8), Text(_getStatusText())]),
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                reverse: true,
                itemCount: data.messages.length,
                itemBuilder: (context, i) {
                  final msg = data.messages[data.messages.length - 1 - i];
                  final isUser = msg.sender == MessageSender.user;
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                      decoration: BoxDecoration(
                        gradient: isUser ? LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]) : null,
                        color: isUser ? null : Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(msg.content, style: TextStyle(color: isUser ? Colors.white : null)),
                    ),
                  );
                },
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface.withOpacity(0.9), border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)))),
                  child: Row(
                    children: [
                      IconButton(icon: const Icon(Icons.image_outlined), onPressed: callbacks.onUploadImage),
                      Expanded(child: TextField(decoration: InputDecoration(hintText: '输入消息...', filled: true, fillColor: Colors.white.withOpacity(0.1), border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)))),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(gradient: LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]), shape: BoxShape.circle),
                        child: IconButton(icon: const Icon(Icons.send, color: Colors.white), onPressed: data.canSendMessage ? () => callbacks.onSendMessage(data.inputText) : null),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText() {
    switch (data.connectionStatus) {
      case ConnectionStatus.connecting: return '连接中...';
      case ConnectionStatus.connected: return '已连接';
      case ConnectionStatus.reconnecting: return '重连中...';
      case ConnectionStatus.failed: return '连接失败';
      default: return '未连接';
    }
  }

  Color _getStatusColor() {
    switch (data.connectionStatus) {
      case ConnectionStatus.connected: return Colors.green;
      case ConnectionStatus.failed: return Colors.red;
      default: return Colors.orange;
    }
  }
}

