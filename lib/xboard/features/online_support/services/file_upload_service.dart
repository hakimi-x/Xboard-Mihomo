import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fl_clash/xboard/core/core.dart';
import 'package:fl_clash/xboard/features/online_support/models/message_model.dart';
import 'package:fl_clash/xboard/features/online_support/services/service_config.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

/// 上传结果模型
class UploadResult {
  final bool success;
  final String? error;
  final MessageAttachment? attachment;
  final List<MessageAttachment>? attachments;

  UploadResult.success({this.attachment, this.attachments}) 
      : success = true, error = null;
  
  UploadResult.failure(this.error) 
      : success = false, attachment = null, attachments = null;
}

/// 文件上传服务类
class FileUploadService {
  final String baseUrl;
  final http.Client _httpClient;

  // 配置常量
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedMimeTypes = [
    'image/jpeg',
    'image/png', 
    'image/gif',
    'image/webp',
    'image/bmp'
  ];
  static const List<String> allowedExtensions = [
    '.jpg',
    '.jpeg', 
    '.png',
    '.gif',
    '.webp',
    '.bmp'
  ];

  FileUploadService({
    required this.baseUrl,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// 单文件上传
  Future<UploadResult> uploadFile({
    required Uint8List fileBytes,
    required String fileName,
    String? mimeType,
  }) async {
    try {
      // 验证文件
      final validationError = _validateFile(fileBytes, fileName, mimeType);
      if (validationError != null) {
        return UploadResult.failure(validationError);
      }

      // 获取认证token
      final token = await CustomerSupportServiceConfig.getUserToken();
      if (token == null) {
        return UploadResult.failure('无法获取认证token');
      }

      // 构建multipart请求
      final uri = Uri.parse('$baseUrl/files/upload');
      final request = http.MultipartRequest('POST', uri);

      // 添加认证头
      request.headers['Authorization'] = token;

      // 添加文件
      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      );
      request.files.add(multipartFile);

      XBoardLogger.debug('上传文件请求详情: URL: $uri, 文件名: $fileName, 文件大小: ${fileBytes.length} bytes, MIME类型: $mimeType', null);

      // 发送请求
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      XBoardLogger.debug('上传文件响应详情: Status: ${response.statusCode}, Body: ${response.body}', null);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final attachment = MessageAttachment.fromJson(data);
        XBoardLogger.info('文件上传成功: ${attachment.filename}');
        return UploadResult.success(attachment: attachment);
      } else {
        XBoardLogger.error('文件上传失败: ${response.statusCode} ${response.body}');
        return UploadResult.failure('文件上传失败: ${response.statusCode}');
      }
    } catch (e) {
      XBoardLogger.error('文件上传异常', e);
      return UploadResult.failure('文件上传异常: $e');
    }
  }

  /// 批量文件上传
  Future<UploadResult> uploadMultipleFiles({
    required List<({Uint8List bytes, String fileName, String? mimeType})> files,
  }) async {
    try {
      // 验证所有文件
      for (final file in files) {
        final validationError = _validateFile(file.bytes, file.fileName, file.mimeType);
        if (validationError != null) {
          return UploadResult.failure(validationError);
        }
      }

      // 获取认证token
      final token = await CustomerSupportServiceConfig.getUserToken();
      if (token == null) {
        return UploadResult.failure('无法获取认证token');
      }

      // 构建multipart请求
      final uri = Uri.parse('$baseUrl/files/upload-multiple');
      final request = http.MultipartRequest('POST', uri);

      // 添加认证头
      request.headers['Authorization'] = token;

      // 添加所有文件
      for (final file in files) {
        final multipartFile = http.MultipartFile.fromBytes(
          'files',
          file.bytes,
          filename: file.fileName,
          contentType: file.mimeType != null ? MediaType.parse(file.mimeType!) : null,
        );
        request.files.add(multipartFile);
      }

      XBoardLogger.debug('批量上传文件请求详情: URL: $uri, 文件数量: ${files.length}', null);

      // 发送请求
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      XBoardLogger.debug('批量上传文件响应详情: Status: ${response.statusCode}, Body: ${response.body}', null);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final attachmentList = (data['attachments'] as List)
            .map((item) => MessageAttachment.fromJson(item as Map<String, dynamic>))
            .toList();
        XBoardLogger.info('批量上传成功，共 ${attachmentList.length} 个文件');
        return UploadResult.success(attachments: attachmentList);
      } else {
        XBoardLogger.error('批量上传失败: ${response.statusCode} ${response.body}');
        return UploadResult.failure('批量上传失败: ${response.statusCode}');
      }
    } catch (e) {
      XBoardLogger.error('批量上传异常', e);
      return UploadResult.failure('批量上传异常: $e');
    }
  }

  /// 从平台文件系统上传文件
  Future<UploadResult> uploadFileFromPath({
    required String filePath,
    String? customFileName,
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return UploadResult.failure('文件不存在');
      }

      final bytes = await file.readAsBytes();
      final fileName = customFileName ?? file.path.split('/').last;
      
      // 根据文件扩展名推断MIME类型
      String? mimeType;
      final extension = fileName.toLowerCase();
      if (extension.endsWith('.jpg') || extension.endsWith('.jpeg')) {
        mimeType = 'image/jpeg';
      } else if (extension.endsWith('.png')) {
        mimeType = 'image/png';
      } else if (extension.endsWith('.gif')) {
        mimeType = 'image/gif';
      } else if (extension.endsWith('.webp')) {
        mimeType = 'image/webp';
      } else if (extension.endsWith('.bmp')) {
        mimeType = 'image/bmp';
      }

      return uploadFile(
        fileBytes: bytes,
        fileName: fileName,
        mimeType: mimeType,
      );
    } catch (e) {
      XBoardLogger.error('从路径上传文件异常', e);
      return UploadResult.failure('从路径上传文件异常: $e');
    }
  }

  /// 文件验证
  String? _validateFile(Uint8List fileBytes, String fileName, String? mimeType) {
    // 检查文件大小
    if (fileBytes.length > maxFileSize) {
      return '文件大小超过限制（最大10MB）';
    }

    // 检查文件扩展名
    final hasValidExtension = allowedExtensions.any((ext) => 
        fileName.toLowerCase().endsWith(ext));
    if (!hasValidExtension) {
      return '不支持的文件格式，仅支持: ${allowedExtensions.join(', ')}';
    }

    // 检查MIME类型（如果提供）
    if (mimeType != null && !allowedMimeTypes.contains(mimeType)) {
      return '不支持的文件类型: $mimeType';
    }

    return null; // 验证通过
  }

  /// 获取文件信息
  Future<MessageAttachment?> getFileInfo(int attachmentId) async {
    try {
      final token = await CustomerSupportServiceConfig.getUserToken();
      if (token == null) {
        XBoardLogger.error('获取文件信息失败: 无法获取认证token');
        return null;
      }

      final url = '$baseUrl/files/$attachmentId/info';
      final response = await _httpClient.get(
        Uri.parse(url),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      XBoardLogger.debug('获取文件信息响应: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return MessageAttachment.fromJson(data);
      } else {
        XBoardLogger.error('获取文件信息失败: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      XBoardLogger.error('获取文件信息异常', e);
      return null;
    }
  }

  /// 删除文件
  Future<bool> deleteFile(int attachmentId) async {
    try {
      final token = await CustomerSupportServiceConfig.getUserToken();
      if (token == null) {
        XBoardLogger.error('删除文件失败: 无法获取认证token');
        return false;
      }

      final url = '$baseUrl/files/$attachmentId';
      final response = await _httpClient.delete(
        Uri.parse(url),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      XBoardLogger.debug('删除文件响应: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        XBoardLogger.info('文件删除成功');
        return true;
      } else {
        XBoardLogger.error('文件删除失败: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      XBoardLogger.error('文件删除异常', e);
      return false;
    }
  }

  /// 获取文件URL（用于预览和下载）
  String getFileUrl(int attachmentId, {String? size}) {
    String url = '$baseUrl/files/$attachmentId';
    if (size != null) {
      url += '?size=$size';
    }
    return url;
  }

  /// 获取缩略图URL
  String getThumbnailUrl(int attachmentId, {String size = '150x150'}) {
    return getFileUrl(attachmentId, size: size);
  }

  /// 释放资源
  void dispose() {
    _httpClient.close();
  }
}