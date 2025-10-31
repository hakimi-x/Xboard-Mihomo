import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/ticket/providers/ticket_provider.dart';
import 'package:fl_clash/xboard/features/shared/shared.dart';
import 'package:flutter_xboard_sdk/flutter_xboard_sdk.dart';

class TicketDetailPage extends ConsumerStatefulWidget {
  final int ticketId;

  const TicketDetailPage({
    super.key,
    required this.ticketId,
  });

  @override
  ConsumerState<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends ConsumerState<TicketDetailPage> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ticketProvider.notifier).fetchTicketDetail(widget.ticketId);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendReply() async {
    if (_messageController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      _isSending = true;
    });

    final success = await ref.read(ticketProvider.notifier).replyTicket(
          ticketId: widget.ticketId,
          message: _messageController.text.trim(),
        );

    if (!mounted) return;

    setState(() {
      _isSending = false;
    });

    if (success) {
      _messageController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('回复成功')),
      );
      // 滚动到底部显示新消息
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } else {
      final errorMessage = ref.read(ticketProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage ?? '回复失败'),
          backgroundColor: context.colorScheme.error,
        ),
      );
    }
  }

  Future<void> _closeTicket() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('关闭工单'),
        content: const Text('确定要关闭这个工单吗？关闭后将无法继续回复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('关闭'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final success = await ref.read(ticketProvider.notifier).closeTicket(widget.ticketId);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('工单已关闭')),
      );
      Navigator.pop(context);
    } else {
      final errorMessage = ref.read(ticketProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage ?? '关闭失败'),
          backgroundColor: context.colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticketState = ref.watch(ticketProvider);
    final ticketDetail = ticketState.currentTicketDetail;

    return Scaffold(
      appBar: AppBar(
        title: const Text('工单详情'),
        actions: [
          if (ticketDetail != null && ticketDetail.status == 0)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _closeTicket,
              tooltip: '关闭工单',
            ),
        ],
      ),
      body: ticketState.isLoadingDetail
          ? const Center(child: CircularProgressIndicator())
          : ticketDetail == null
              ? _buildErrorState()
              : Column(
                  children: [
                    // 工单信息头部
                    _buildTicketHeader(ticketDetail),
                    const Divider(height: 1),
                    // 消息列表
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16.0),
                        itemCount: ticketDetail.messages.length,
                        itemBuilder: (context, index) {
                          final message = ticketDetail.messages[index];
                          return _buildMessageBubble(message);
                        },
                      ),
                    ),
                    // 输入框（仅在工单未关闭时显示）
                    if (ticketDetail.status == 0) _buildInputArea(ticketDetail),
                  ],
                ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: context.colorScheme.error,
          ),
          const SizedBox(height: 16),
          const Text('加载工单详情失败'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              ref.read(ticketProvider.notifier).fetchTicketDetail(widget.ticketId);
            },
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketHeader(TicketDetail ticket) {
    final isOpen = ticket.status == 0;
    
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: context.colorScheme.surfaceVariant.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  ticket.subject,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildStatusChip(isOpen),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildLevelChip(ticket.level),
              const SizedBox(width: 8),
              Text(
                '创建于 ${_formatDate(ticket.createdAt)}',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(TicketMessage message) {
    final isMe = message.isMe;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 18,
              backgroundColor: context.colorScheme.primaryContainer,
              child: Icon(
                Icons.support_agent,
                size: 20,
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isMe
                        ? context.colorScheme.primaryContainer
                        : context.colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isMe ? 16 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 16),
                    ),
                  ),
                  child: Text(
                    message.message,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: isMe
                          ? context.colorScheme.onPrimaryContainer
                          : context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(message.createdAt),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 18,
              backgroundColor: context.colorScheme.secondaryContainer,
              child: Icon(
                Icons.person,
                size: 20,
                color: context.colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputArea(TicketDetail ticket) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: '输入回复内容...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendReply(),
            ),
          ),
          const SizedBox(width: 12),
          FilledButton(
            onPressed: _isSending ? null : _sendReply,
            style: FilledButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(14),
            ),
            child: _isSending
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(bool isOpen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isOpen
            ? context.colorScheme.tertiaryContainer
            : context.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        isOpen ? '处理中' : '已关闭',
        style: context.textTheme.labelMedium?.copyWith(
          color: isOpen
              ? context.colorScheme.onTertiaryContainer
              : context.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLevelChip(int level) {
    final levelText = level == 2 ? '高优先级' : (level == 1 ? '中优先级' : '低优先级');
    final color = level == 2
        ? Colors.red
        : (level == 1 ? Colors.orange : Colors.grey);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.flag,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            levelText,
            style: context.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
}

