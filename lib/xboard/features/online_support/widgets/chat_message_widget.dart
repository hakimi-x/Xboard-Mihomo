import 'package:flutter/material.dart';
import 'package:fl_clash/xboard/features/online_support/models/message_model.dart';
import 'package:fl_clash/xboard/features/online_support/widgets/message_attachment_widget.dart';
import 'package:intl/intl.dart';

class ChatMessageWidget extends StatefulWidget {
  final String message;
  final bool isFromUser;
  final String timestamp;
  final List<MessageAttachment> attachments;

  const ChatMessageWidget({
    super.key,
    required this.message,
    required this.isFromUser,
    required this.timestamp,
    this.attachments = const [],
  });

  @override
  State<ChatMessageWidget> createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: widget.isFromUser ? const Offset(0.3, 0) : const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 解析时间戳
    final DateTime dateTime = DateTime.tryParse(widget.timestamp) ?? DateTime.now();
    DateFormat('HH:mm').format(dateTime);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Row(
            mainAxisAlignment: widget.isFromUser 
                ? MainAxisAlignment.end 
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.isFromUser) _buildAvatar(context),
              const SizedBox(width: 8),
              Flexible(
                child: _buildMessageContent(),
              ),
              const SizedBox(width: 8),
              if (widget.isFromUser) _buildAvatar(context, isUser: true),
            ],
          ),
        ),
      );
  }

  /// 构建消息内容（根据类型决定是否显示气泡）
  Widget _buildMessageContent() {
    final bool isPureImageMessage = widget.attachments.isNotEmpty && widget.message.isEmpty;
    
    if (isPureImageMessage) {
      // 纯图片消息：无气泡边框
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: AttachmentsGridWidget(
          attachments: widget.attachments,
          isFromUser: widget.isFromUser,
        ),
      );
    } else {
      // 文本消息或图文混合：显示气泡
      return Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: widget.isFromUser
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 附件显示
            if (widget.attachments.isNotEmpty) ...[
              AttachmentsGridWidget(
                attachments: widget.attachments,
                isFromUser: widget.isFromUser,
              ),
              if (widget.message.isNotEmpty) const SizedBox(height: 8),
            ],

            // 文本内容
            if (widget.message.isNotEmpty)
              Text(
                widget.message,
                style: TextStyle(
                  color: widget.isFromUser
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      );
    }
  }

  Widget _buildAvatar(BuildContext context, {bool isUser = false}) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: isUser
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.secondaryContainer,
      child: Icon(
        isUser ? Icons.person : Icons.support_agent,
        size: 20,
        color: isUser
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSecondaryContainer,
      ),
    );
  }
}
