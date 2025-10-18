import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fl_clash/xboard/features/notice/notice.dart';
class NoticeBanner extends ConsumerStatefulWidget {
  const NoticeBanner({super.key});
  @override
  ConsumerState<NoticeBanner> createState() => _NoticeBannerState();
}
class _NoticeBannerState extends ConsumerState<NoticeBanner>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  Timer? _autoScrollTimer;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(noticeProvider.notifier).fetchNotices();
    });
  }
  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _slideController.dispose();
    super.dispose();
  }
  void _startAutoScroll(List<String> notices) {
    if (notices.isEmpty) return;
    _autoScrollTimer?.cancel();
    if (notices.length == 1) {
      _slideController.forward();
      return;
    }
    _slideController.forward();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        _slideToNext(notices.length);
      }
    });
  }
  void _slideToNext(int totalCount) {
    _slideController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % totalCount;
        });
        _slideController.forward();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final noticeState = ref.watch(noticeProvider);
    if (noticeState.isLoading || noticeState.visibleNotices.isEmpty) {
      return const SizedBox.shrink();
    }
    final notices = noticeState.visibleNotices
        .map((notice) => notice.title)
        .toList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll(notices);
    });
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.8),
            Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.8),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.campaign,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _showNoticeDialog(),
              child: ClipRect(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: notices.isEmpty
                        ? const SizedBox.shrink()
                        : Html(
                            data: notices[_currentIndex % notices.length],
                            style: {
                              "body": Style(
                                margin: Margins.zero,
                                padding: HtmlPaddings.zero,
                                fontSize: FontSize(
                                  Theme.of(context).textTheme.bodySmall?.fontSize ?? 14,
                                ),
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w500,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              "*": Style(
                                margin: Margins.zero,
                                padding: HtmlPaddings.zero,
                              ),
                            },
                          ),
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                ref.read(noticeProvider.notifier).dismissBanner(_currentIndex);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _showNoticeDialog() {
    final noticeState = ref.read(noticeProvider);
    if (noticeState.visibleNotices.isEmpty) return;
    showDialog(
      context: context,
      builder: (context) => NoticeDetailDialog(
        notices: noticeState.visibleNotices,
        initialIndex: _currentIndex,
      ),
    );
  }
}
class NoticeDetailDialog extends StatefulWidget {
  final List<dynamic> notices; // 使用 Notice 类型的列表
  final int initialIndex;
  const NoticeDetailDialog({
    super.key,
    required this.notices,
    this.initialIndex = 0,
  });
  @override
  State<NoticeDetailDialog> createState() => _NoticeDetailDialogState();
}
class _NoticeDetailDialogState extends State<NoticeDetailDialog> {
  late PageController _pageController;
  late int _currentIndex;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.notices.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: 600,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.campaign,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '通知详情',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  if (widget.notices.length > 1) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_currentIndex + 1}/${widget.notices.length}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ],
              ),
            ),
            Flexible(
              child: widget.notices.length == 1
                  ? _buildSingleNotice()
                  : _buildMultipleNotices(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSingleNotice() {
    final notice = widget.notices[0];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: _buildNoticeContent(notice),
    );
  }
  Widget _buildMultipleNotices() {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.notices.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildNoticeContent(widget.notices[index]),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: _currentIndex > 0
                    ? () => _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        )
                    : null,
                icon: const Icon(Icons.chevron_left),
                label: const Text('上一条'),
              ),
              Row(
                children: List.generate(
                  widget.notices.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == _currentIndex
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: _currentIndex < widget.notices.length - 1
                    ? () => _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        )
                    : null,
                icon: const Icon(Icons.chevron_right),
                label: const Text('下一条'),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildNoticeContent(dynamic notice) {
    String formatTime(dynamic timeValue) {
      if (timeValue == null) return '未知时间';
      try {
        DateTime dateTime;
        if (timeValue is int) {
          final timestamp = timeValue > 1000000000000 ? timeValue : timeValue * 1000;
          dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        } else if (timeValue is String) {
          dateTime = DateTime.parse(timeValue);
        } else {
          return timeValue.toString();
        }
        return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } catch (e) {
        return timeValue.toString();
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Html(
            data: notice.title ?? '无标题',
            style: {
              "body": Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                fontSize: FontSize(
                  Theme.of(context).textTheme.titleMedium?.fontSize ?? 16,
                ),
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              "*": Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
              ),
            },
          ),
        ),
        const SizedBox(height: 16),
        if (notice.createdAt != null || notice.updatedAt != null) ...[
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 4),
              Text(
                '发布时间：${formatTime(notice.createdAt)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        if (notice.tags != null && notice.tags.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            children: (notice.tags as List).map((tag) => Chip(
              label: Text(
                tag.toString(),
                style: const TextStyle(fontSize: 12),
              ),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              side: BorderSide.none,
            )).toList(),
          ),
          const SizedBox(height: 16),
        ],
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Html(
            data: _processHtmlForDialog(notice.content ?? '暂无内容'),
            style: {
              "body": Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                fontSize: FontSize(
                  Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
                ),
                color: Theme.of(context).colorScheme.onSurface,
                lineHeight: const LineHeight(1.6),
              ),
              "p": Style(
                margin: Margins.only(bottom: 8),
              ),
              "h1, h2, h3, h4, h5, h6": Style(
                fontWeight: FontWeight.bold,
                margin: Margins.only(top: 8, bottom: 8),
              ),
              "strong, b": Style(
                fontWeight: FontWeight.bold,
              ),
              "em, i": Style(
                fontStyle: FontStyle.italic,
              ),
              "a": Style(
                color: Theme.of(context).colorScheme.primary,
                textDecoration: TextDecoration.underline,
              ),
              "ul, ol": Style(
                margin: Margins.only(left: 16, bottom: 8),
              ),
              "li": Style(
                margin: Margins.only(bottom: 4),
              ),
            },
          ),
        ),
      ],
    );
  }
  String _processHtmlForDialog(String htmlText) {
    return htmlText.trim();
  }
}