import 'dart:math' as math;

import 'package:fl_clash/xboard/core/core.dart';
import 'package:flutter/material.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/online_support/models/message_model.dart';
import 'package:fl_clash/xboard/features/online_support/services/file_upload_service.dart';
import 'package:fl_clash/xboard/features/online_support/services/service_config.dart';
import 'package:file_picker/file_picker.dart';

/// 图片选择和预览组件
class ImagePickerWidget extends StatefulWidget {
  final Function(List<MessageAttachment>) onAttachmentsSelected;
  final VoidCallback? onCancel;

  const ImagePickerWidget({
    super.key,
    required this.onAttachmentsSelected,
    this.onCancel,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  List<PlatformFile> _selectedFiles = [];
  bool _isUploading = false;
  String? _errorMessage;
  late final FileUploadService _uploadService;

  @override
  void initState() {
    super.initState();
    // 使用正确的配置获取baseUrl
    final apiBaseUrl = CustomerSupportServiceConfig.apiBaseUrl;
    if (apiBaseUrl == null) {
      throw Exception(appLocalizations.onlineSupportApiConfigNotFound);
    }
    _uploadService = FileUploadService(
      baseUrl: apiBaseUrl,
    );
    XBoardLogger.debug('文件上传服务初始化，baseUrl: ${CustomerSupportServiceConfig.apiBaseUrl}');
  }

  @override
  void dispose() {
    _uploadService.dispose();
    super.dispose();
  }

  /// 选择图片文件
  Future<void> _pickImages() async {
    try {
      XBoardLogger.debug('开始选择图片文件...');
      
      // 方式1: 使用FileType.image（推荐，系统会自动过滤图片文件）
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        withData: true,
      );
      
      // 方式2: 如果需要精确控制扩展名，可以使用FileType.custom
      // final result = await FilePicker.platform.pickFiles(
      //   type: FileType.custom,
      //   allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'],
      //   allowMultiple: true,
      //   withData: true,
      // );

      if (result != null && result.files.isNotEmpty) {
        XBoardLogger.info('成功选择 ${result.files.length} 个文件');
        for (int i = 0; i < result.files.length; i++) {
          final file = result.files[i];
          XBoardLogger.debug('文件${i + 1}: ${file.name} (${file.size} bytes)');
        }
        
        setState(() {
          _selectedFiles = result.files;
          _errorMessage = null;
        });
      } else {
        XBoardLogger.info('用户取消选择图片或未选择任何文件');
      }
    } catch (e) {
      XBoardLogger.error('选择图片失败: $e, 错误详情: ${e.runtimeType}', e);
      if (e is Error) {
        XBoardLogger.error('堆栈信息: ${e.stackTrace}');
      }
      
      setState(() {
        _errorMessage = appLocalizations.onlineSupportSelectImagesFailed(e.toString());
      });
    }
  }

  /// 上传选中的文件
  Future<void> _uploadFiles() async {
    if (_selectedFiles.isEmpty) return;

    setState(() {
      _isUploading = true;
      _errorMessage = null;
    });

    try {
      List<MessageAttachment> uploadedAttachments = [];

      for (final file in _selectedFiles) {
        if (file.bytes != null) {
          final result = await _uploadService.uploadFile(
            fileBytes: file.bytes!,
            fileName: file.name,
            mimeType: _getMimeTypeFromExtension(file.extension),
          );

          if (result.success && result.attachment != null) {
            uploadedAttachments.add(result.attachment!);
          } else {
            throw Exception(result.error ?? appLocalizations.onlineSupportUploadFailed('Unknown error'));
          }
        }
      }

      setState(() {
        _isUploading = false;
      });

      // 通知父组件
      widget.onAttachmentsSelected(uploadedAttachments);
    } catch (e) {
      setState(() {
        _isUploading = false;
        _errorMessage = appLocalizations.onlineSupportUploadFailed(e.toString());
      });
    }
  }

  /// 根据文件扩展名获取MIME类型
  String? _getMimeTypeFromExtension(String? extension) {
    if (extension == null) return null;
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'bmp':
        return 'image/bmp';
      default:
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

  /// 移除选中的文件
  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final maxHeight = screenHeight * 0.8; // 限制最大高度为屏幕的80%
    
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 标题栏 - 固定高度
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    appLocalizations.onlineSupportSelectImages,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: widget.onCancel,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          
          // 可滚动内容区域
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, math.max(24, bottomPadding + 8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 选择文件按钮
                  if (_selectedFiles.isEmpty) ...[
                    InkWell(
                      onTap: _isUploading ? null : _pickImages,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 48,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              appLocalizations.onlineSupportClickToSelect,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // 已选文件列表
                  if (_selectedFiles.isNotEmpty) ...[
                    // 文件列表容器 - 限制最大高度并可滚动
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: math.min(280, (maxHeight - 160 - bottomPadding) * 0.55), // 为三行文字预留更多空间
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _selectedFiles.length,
                        itemBuilder: (context, index) {
                          final file = _selectedFiles[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: file.bytes != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.memory(
                                        file.bytes!,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(Icons.image_not_supported);
                                        },
                                      ),
                                    )
                                  : const Icon(Icons.image),
                              title: Text(
                                file.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                _formatFileSize(file.size),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: _isUploading ? null : () => _removeFile(index),
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 操作按钮 - 使用Wrap防止溢出
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: _isUploading ? null : _pickImages,
                          icon: const Icon(Icons.add),
                          label: Text(appLocalizations.onlineSupportAddMore),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: _isUploading ? null : widget.onCancel,
                              child: Text(appLocalizations.onlineSupportCancel),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: _isUploading ? null : _uploadFiles,
                              child: _isUploading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : Text(appLocalizations.onlineSupportSend),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],

                  // 错误信息
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Theme.of(context).colorScheme.onErrorContainer,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}