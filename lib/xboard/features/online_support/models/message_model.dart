/// 消息发送者类型枚举
enum SenderType {
  user, // 用户发送的消息
  agent // 客服发送的消息
}

/// 消息类型枚举
enum MessageType {
  text, // 文本消息
  image, // 图片消息
  file // 文件消息
}

/// 附件模型
class MessageAttachment {
  final int id;
  final String filename;
  final int fileSize;
  final String mimeType;
  final String? thumbnailUrl;
  final String fileUrl;

  MessageAttachment({
    required this.id,
    required this.filename,
    required this.fileSize,
    required this.mimeType,
    this.thumbnailUrl,
    required this.fileUrl,
  });

  factory MessageAttachment.fromJson(Map<String, dynamic> json) {
    return MessageAttachment(
      id: json['id'] as int,
      filename: json['filename'] as String,
      fileSize: json['file_size'] as int,
      mimeType: json['mime_type'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      fileUrl: json['file_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filename': filename,
      'file_size': fileSize,
      'mime_type': mimeType,
      'thumbnail_url': thumbnailUrl,
      'file_url': fileUrl,
    };
  }

  /// 判断是否为图片类型
  bool get isImage => mimeType.startsWith('image/');
}

/// 聊天消息模型
class ChatMessage {
  final int id;
  final String content;
  final SenderType senderType;
  final MessageType messageType;
  final String createdAt;
  final bool read;
  final List<MessageAttachment> attachments;

  ChatMessage({
    required this.id,
    required this.content,
    required this.senderType,
    this.messageType = MessageType.text,
    required this.createdAt,
    this.read = false,
    this.attachments = const [],
  });

  /// 从JSON构造消息对象
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    // 解析消息类型
    MessageType msgType = MessageType.text;
    if (json['message_type'] != null) {
      switch (json['message_type'] as String) {
        case 'image':
          msgType = MessageType.image;
          break;
        case 'file':
          msgType = MessageType.file;
          break;
        default:
          msgType = MessageType.text;
      }
    }

    // 解析附件列表
    List<MessageAttachment> attachmentList = [];
    if (json['attachments'] != null && json['attachments'] is List) {
      attachmentList = (json['attachments'] as List)
          .map((item) => MessageAttachment.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return ChatMessage(
      id: json['id'] as int,
      content: json['content'] as String? ?? '',
      senderType:
          json['sender_type'] == 'agent' ? SenderType.agent : SenderType.user,
      messageType: msgType,
      createdAt: json['created_at'] as String,
      read: json['read'] as bool? ?? false,
      attachments: attachmentList,
    );
  }

  /// 将消息对象转换为JSON
  Map<String, dynamic> toJson() {
    String messageTypeStr = 'text';
    switch (messageType) {
      case MessageType.image:
        messageTypeStr = 'image';
        break;
      case MessageType.file:
        messageTypeStr = 'file';
        break;
      case MessageType.text:
        messageTypeStr = 'text';
        break;
    }

    return {
      'id': id,
      'content': content,
      'sender_type': senderType == SenderType.agent ? 'agent' : 'user',
      'message_type': messageTypeStr,
      'created_at': createdAt,
      'read': read,
      'attachments': attachments.map((a) => a.toJson()).toList(),
    };
  }

  /// 创建用于发送新文本消息的JSON
  static Map<String, dynamic> createTextMessageJson(String content) {
    return {
      'content': content,
    };
  }

  /// 创建用于发送带附件消息的JSON
  static Map<String, dynamic> createAttachmentMessageJson(
    String content,
    List<int> attachmentIds,
  ) {
    return {
      'content': content,
      'attachment_ids': attachmentIds,
    };
  }

  /// 判断是否有附件
  bool get hasAttachments => attachments.isNotEmpty;

  /// 判断是否为图片消息
  bool get isImageMessage => 
      messageType == MessageType.image || 
      attachments.any((attachment) => attachment.isImage);
}

/// 消息列表响应模型
class MessageListResponse {
  final List<ChatMessage> items;
  final int total;

  MessageListResponse({
    required this.items,
    required this.total,
  });

  factory MessageListResponse.fromJson(Map<String, dynamic> json) {
    return MessageListResponse(
      items: (json['items'] as List)
          .map((item) => ChatMessage.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
    );
  }
}
