/// 在线客服页面契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

/// 在线客服页面契约
abstract class OnlineSupportPageContract extends PageContract<OnlineSupportPageData, OnlineSupportPageCallbacks> {
  const OnlineSupportPageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 消息类型
enum MessageType {
  text,     // 文本
  image,    // 图片
  file,     // 文件
  system,   // 系统消息
}

/// 消息发送者
enum MessageSender {
  user,     // 用户
  support,  // 客服
  system,   // 系统
}

/// 消息附件
class MessageAttachment {
  final String url;
  final String? thumbnailUrl;
  final String? fileName;
  final int? fileSize;
  final String mimeType;

  const MessageAttachment({
    required this.url,
    this.thumbnailUrl,
    this.fileName,
    this.fileSize,
    required this.mimeType,
  });
}

/// 消息
class ChatMessage {
  final String id;
  final MessageSender sender;
  final MessageType type;
  final String content;
  final MessageAttachment? attachment;
  final DateTime timestamp;
  final bool isRead;
  final bool isSending;  // 是否正在发送
  final bool sendFailed; // 发送失败

  const ChatMessage({
    required this.id,
    required this.sender,
    required this.type,
    required this.content,
    this.attachment,
    required this.timestamp,
    this.isRead = false,
    this.isSending = false,
    this.sendFailed = false,
  });
}

/// WebSocket 连接状态
enum ConnectionStatus {
  disconnected, // 未连接
  connecting,   // 连接中
  connected,    // 已连接
  reconnecting, // 重连中
  failed,       // 连接失败
}

/// 在线客服页面数据
class OnlineSupportPageData implements DataModel {
  /// 消息列表
  final List<ChatMessage> messages;
  
  /// 连接状态
  final ConnectionStatus connectionStatus;
  
  /// 输入内容
  final String inputText;
  
  /// 是否正在上传
  final bool isUploading;
  
  /// 上传进度（0-100）
  final double uploadProgress;
  
  /// 客服是否在线
  final bool isSupportOnline;
  
  /// 客服平均响应时间（秒）
  final int? averageResponseTime;
  
  /// 错误信息
  final String? errorMessage;

  const OnlineSupportPageData({
    this.messages = const [],
    this.connectionStatus = ConnectionStatus.disconnected,
    this.inputText = '',
    this.isUploading = false,
    this.uploadProgress = 0,
    this.isSupportOnline = false,
    this.averageResponseTime,
    this.errorMessage,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'messages': messages.map((m) => {
        'id': m.id,
        'sender': m.sender.toString(),
        'type': m.type.toString(),
        'content': m.content,
        'timestamp': m.timestamp.toIso8601String(),
        'isRead': m.isRead,
        'isSending': m.isSending,
        'sendFailed': m.sendFailed,
      }).toList(),
      'connectionStatus': connectionStatus.toString(),
      'inputText': inputText,
      'isUploading': isUploading,
      'uploadProgress': uploadProgress,
      'isSupportOnline': isSupportOnline,
      'averageResponseTime': averageResponseTime,
      'errorMessage': errorMessage,
    };
  }
  
  /// 是否可以发送消息
  bool get canSendMessage =>
      connectionStatus == ConnectionStatus.connected &&
      inputText.trim().isNotEmpty &&
      !isUploading;
  
  /// 未读消息数
  int get unreadCount => messages.where((m) => 
      !m.isRead && m.sender == MessageSender.support
  ).length;
}

/// 在线客服页面回调
class OnlineSupportPageCallbacks implements CallbacksModel {
  /// 发送消息
  final ValueCallback<String> onSendMessage;
  
  /// 重发失败消息
  final ValueCallback<ChatMessage> onResendMessage;
  
  /// 上传图片
  final AsyncCallback onUploadImage;
  
  /// 从相机拍照
  final AsyncCallback onTakePhoto;
  
  /// 重新连接
  final AsyncCallback onReconnect;
  
  /// 标记消息已读
  final ValueCallback<ChatMessage> onMarkAsRead;
  
  /// 复制消息内容
  final ValueCallback<ChatMessage> onCopyMessage;
  
  /// 查看图片
  final ValueCallback<ChatMessage> onViewImage;

  const OnlineSupportPageCallbacks({
    required this.onSendMessage,
    required this.onResendMessage,
    required this.onUploadImage,
    required this.onTakePhoto,
    required this.onReconnect,
    required this.onMarkAsRead,
    required this.onCopyMessage,
    required this.onViewImage,
  });
}

