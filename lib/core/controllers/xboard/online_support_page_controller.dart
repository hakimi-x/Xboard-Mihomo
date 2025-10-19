/// 在线客服页面控制器
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnlineSupportPageController extends ConsumerStatefulWidget {
  const OnlineSupportPageController({super.key});

  @override
  ConsumerState<OnlineSupportPageController> createState() => _OnlineSupportPageControllerState();
}

class _OnlineSupportPageControllerState extends ConsumerState<OnlineSupportPageController> {
  final List<ChatMessage> _messages = [];
  ConnectionStatus _connectionStatus = ConnectionStatus.disconnected;
  String _inputText = '';
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _connect();
  }

  Future<void> _connect() async {
    setState(() { _connectionStatus = ConnectionStatus.connecting; });
    try {
      // TODO: 建立WebSocket连接
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() { _connectionStatus = ConnectionStatus.connected; });
        _addSystemMessage('已连接到客服');
      }
    } catch (e) {
      if (mounted) {
        setState(() { _connectionStatus = ConnectionStatus.failed; });
      }
    }
  }

  void _addSystemMessage(String content) {
    _messages.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: MessageSender.system,
      type: MessageType.text,
      content: content,
      timestamp: DateTime.now(),
    ));
  }

  Future<void> _handleSendMessage(String message) async {
    if (message.trim().isEmpty) return;
    
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: MessageSender.user,
      type: MessageType.text,
      content: message,
      timestamp: DateTime.now(),
      isSending: true,
    );
    
    setState(() {
      _messages.add(userMessage);
      _inputText = '';
    });
    
    // TODO: 发送到服务器
    await Future.delayed(const Duration(seconds: 1));
    
    // 更新发送状态
    final index = _messages.indexWhere((m) => m.id == userMessage.id);
    if (index != -1 && mounted) {
      setState(() {
        _messages[index] = ChatMessage(
          id: userMessage.id,
          sender: userMessage.sender,
          type: userMessage.type,
          content: userMessage.content,
          timestamp: userMessage.timestamp,
          isSending: false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = OnlineSupportPageData(
      messages: _messages,
      connectionStatus: _connectionStatus,
      inputText: _inputText,
      isUploading: _isUploading,
      isSupportOnline: true,
      averageResponseTime: 30,
    );
    
    final callbacks = OnlineSupportPageCallbacks(
      onSendMessage: _handleSendMessage,
      onResendMessage: (msg) async { /* TODO: 重发消息 */ },
      onUploadImage: () async { /* TODO: 上传图片 */ },
      onTakePhoto: () async { /* TODO: 拍照 */ },
      onReconnect: _connect,
      onMarkAsRead: (msg) { /* TODO: 标记已读 */ },
      onCopyMessage: (msg) { /* TODO: 复制消息 */ },
      onViewImage: (msg) { /* TODO: 查看图片 */ },
    );
    
    return UIRegistry().buildPage<OnlineSupportPageContract>(data: data, callbacks: callbacks);
  }
}

