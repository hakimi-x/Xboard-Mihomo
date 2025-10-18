import 'package:fl_clash/xboard/core/core.dart';
import 'package:fl_clash/xboard/infrastructure/infrastructure.dart';
import 'package:flutter/material.dart';
import 'package:fl_clash/xboard/features/online_support/models/message_model.dart';

import 'package:fl_clash/xboard/features/online_support/services/service_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

/// 消息附件显示组件
class MessageAttachmentWidget extends StatefulWidget {
  final MessageAttachment attachment;
  final bool isFromUser;

  const MessageAttachmentWidget({
    super.key,
    required this.attachment,
    required this.isFromUser,
  });

  @override
  State<MessageAttachmentWidget> createState() => _MessageAttachmentWidgetState();
}

class _MessageAttachmentWidgetState extends State<MessageAttachmentWidget> {

  /// 构建带认证的网络图片组件
  Widget _buildNetworkImageWithAuth(String imageUrl) {
    return FutureBuilder<Uint8List?>(
      future: _loadImageWithAuth(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Container(
            color: Theme.of(context).colorScheme.errorContainer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.broken_image,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  '图片加载失败',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.contain, // 改为contain，保持图片比例完整显示
          );
        }
      },
    );
  }

  /// 使用认证Token加载图片
  Future<Uint8List?> _loadImageWithAuth(String imageUrl) async {
    try {
      final token = await CustomerSupportServiceConfig.getUserToken();
      if (token == null) {
        XBoardLogger.warning('无法获取认证token，跳过图片加载');
        return null;
      }

      XBoardLogger.debug('开始加载图片: $imageUrl');

      final client = http.Client();
      try {
        final userAgent = await UserAgentConfig.get(UserAgentScenario.attachment);
        final response = await client.get(
          Uri.parse(imageUrl),
          headers: {
            'Authorization': token,
            'User-Agent': userAgent,
          },
        ).timeout(
          const Duration(seconds: 15), // 增加超时时间
          onTimeout: () {
            throw Exception('图片加载超时');
          },
        );

        if (response.statusCode == 200) {
          XBoardLogger.info('图片加载成功: ${response.bodyBytes.length} bytes');
          return response.bodyBytes;
        } else {
          XBoardLogger.error('图片加载失败: HTTP ${response.statusCode}');
          return null;
        }
      } finally {
        client.close();
      }
    } catch (e) {
      XBoardLogger.error('加载带认证图片失败', e);
      
      // 根据错误类型提供更友好的提示
      if (e.toString().contains('Connection timed out')) {
        XBoardLogger.warning('提示: 网络连接超时，可能是网络问题或VPN设置问题');
      } else if (e.toString().contains('SocketException')) {
        XBoardLogger.warning('提示: 网络连接异常，请检查网络设置');
      }
      
      return null;
    }
  }

  /// 格式化文件大小
  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '${bytes}B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)}KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
  }

  /// 获取完整的文件URL
  String _getFullFileUrl(String relativeUrl) {
    final baseUrl = CustomerSupportServiceConfig.apiBaseUrl;
    if (relativeUrl.startsWith('http')) {
      return relativeUrl;
    }
    return '$baseUrl$relativeUrl';
  }

  /// 打开图片预览
  void _openImagePreview() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black87,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                panEnabled: true,
                boundaryMargin: const EdgeInsets.all(20),
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.network(
                  _getFullFileUrl(widget.attachment.fileUrl),
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            color: Colors.white54,
                            size: 64,
                          ),
                          SizedBox(height: 16),
                          Text(
                            '图片加载失败',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 下载/打开文件
  Future<void> _openFile() async {
    try {
      final url = _getFullFileUrl(widget.attachment.fileUrl);
      final uri = Uri.parse(url);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('无法打开文件')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('打开文件失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.attachment.isImage) {
      // 图片附件
      return _buildImageAttachment();
    } else {
      // 其他类型文件附件
      return _buildFileAttachment();
    }
  }

  /// 构建图片附件组件
  Widget _buildImageAttachment() {
    final thumbnailUrl = widget.attachment.thumbnailUrl ?? widget.attachment.fileUrl;
    
    return GestureDetector(
      onTap: _openImagePreview,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 250,   // 聊天气泡内图片最大宽度
          maxHeight: 250,  // 聊天气泡内图片最大高度
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _buildNetworkImageWithAuth(_getFullFileUrl(thumbnailUrl)),
        ),
      ),
    );
  }

  /// 构建文件附件组件
  Widget _buildFileAttachment() {
    return GestureDetector(
      onTap: _openFile,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.isFromUser
              ? Theme.of(context).colorScheme.primary.withAlpha(26)
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withAlpha(128),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 文件图标
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(51),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getFileIcon(),
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            
            // 文件信息
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.attachment.filename,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${_formatFileSize(widget.attachment.fileSize)} • ${_getFileTypeDescription()}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            
            // 下载图标
            const SizedBox(width: 8),
            Icon(
              Icons.download,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  /// 获取文件类型图标
  IconData _getFileIcon() {
    final mimeType = widget.attachment.mimeType.toLowerCase();
    if (mimeType.startsWith('image/')) {
      return Icons.image;
    } else if (mimeType.startsWith('video/')) {
      return Icons.videocam;
    } else if (mimeType.startsWith('audio/')) {
      return Icons.audiotrack;
    } else if (mimeType.contains('pdf')) {
      return Icons.picture_as_pdf;
    } else if (mimeType.contains('word') || mimeType.contains('document')) {
      return Icons.description;
    } else if (mimeType.contains('sheet') || mimeType.contains('excel')) {
      return Icons.grid_on;
    } else if (mimeType.contains('presentation') || mimeType.contains('powerpoint')) {
      return Icons.slideshow;
    } else {
      return Icons.insert_drive_file;
    }
  }

  /// 获取文件类型描述
  String _getFileTypeDescription() {
    final mimeType = widget.attachment.mimeType.toLowerCase();
    if (mimeType.startsWith('image/')) {
      return '图片';
    } else if (mimeType.startsWith('video/')) {
      return '视频';
    } else if (mimeType.startsWith('audio/')) {
      return '音频';
    } else if (mimeType.contains('pdf')) {
      return 'PDF文档';
    } else if (mimeType.contains('word') || mimeType.contains('document')) {
      return 'Word文档';
    } else if (mimeType.contains('sheet') || mimeType.contains('excel')) {
      return 'Excel表格';
    } else if (mimeType.contains('presentation') || mimeType.contains('powerpoint')) {
      return 'PPT演示';
    } else {
      return '文件';
    }
  }
}

/// 附件网格显示组件（用于多个附件）
class AttachmentsGridWidget extends StatelessWidget {
  final List<MessageAttachment> attachments;
  final bool isFromUser;

  const AttachmentsGridWidget({
    super.key,
    required this.attachments,
    required this.isFromUser,
  });

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) return const SizedBox.shrink();

    // 如果只有一个附件，直接显示
    if (attachments.length == 1) {
      return MessageAttachmentWidget(
        attachment: attachments[0],
        isFromUser: isFromUser,
      );
    }

    // 多个附件使用网格布局
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: attachments.map((attachment) {
        return MessageAttachmentWidget(
          attachment: attachment,
          isFromUser: isFromUser,
        );
      }).toList(),
    );
  }
}