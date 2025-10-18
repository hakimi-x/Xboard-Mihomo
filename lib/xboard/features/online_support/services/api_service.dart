import 'dart:convert';

import 'package:fl_clash/xboard/core/core.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/online_support/models/message_model.dart';
import 'package:fl_clash/xboard/features/online_support/services/service_config.dart';
import 'package:http/http.dart' as http;

/// 客服系统API服务类
class CustomerSupportApiService {
  final String baseUrl;
  final http.Client _httpClient;

  CustomerSupportApiService({
    required this.baseUrl,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? _createHttpClient();

  /// 创建一个禁用自动重定向的HTTP客户端
  static http.Client _createHttpClient() {
    // 使用标准HTTP客户端，但添加更多调试信息
    return http.Client();
  }

  /// 创建带有持久化头信息的请求
  Future<http.Response> _makeRequest(String method, String url, {
    required Map<String, String> headers,
    String? body,
  }) async {
    XBoardLogger.debug('发起${method.toUpperCase()}请求: $url');
    XBoardLogger.debug('请求头: $headers');
    
    final uri = Uri.parse(url);
    
    switch (method.toLowerCase()) {
      case 'get':
        return await _httpClient.get(uri, headers: headers);
      case 'post':
        return await _httpClient.post(uri, headers: headers, body: body);
      default:
        throw UnsupportedError(appLocalizations.onlineSupportUnsupportedHttpMethod(method));
    }
  }
  
  /// 发送文本消息到服务器
  Future<ChatMessage?> sendMessage(
    String content,
  ) async {
    try {
      // 获取token
      final token = await CustomerSupportServiceConfig.getUserToken();
      if (token == null) {
        XBoardLogger.error(appLocalizations.onlineSupportSendMessageFailed);
        return null;
      }

      final url = '$baseUrl/messages/';
      final requestBody = {'content': content};

      XBoardLogger.debug('OnlineSupportApiService', '发送消息请求详情: URL: $url, Headers: {Content-Type: application/json, Authorization: $token}, Body: ${jsonEncode(requestBody)}');

      final response = await _httpClient.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode(requestBody),
      );

      XBoardLogger.debug('发送消息响应详情: Status: ${response.statusCode}, Body: ${response.body}', null);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        XBoardLogger.info('发送消息成功');
        return ChatMessage.fromJson(data);
      } else {
        XBoardLogger.error('发送消息失败: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      XBoardLogger.error('发送消息异常', e);
      return null;
    }
  }

  /// 获取消息历史
  Future<MessageListResponse> getMessageHistory({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      // 获取token
      final token = await CustomerSupportServiceConfig.getUserToken();
      if (token == null) {
        throw Exception(appLocalizations.onlineSupportTokenNotFound);
      }

      final url = '$baseUrl/messages/?limit=$limit&offset=$offset';
      
      XBoardLogger.debug('获取消息历史请求详情: URL: $url, Token: $token, Headers: {Authorization: $token, Content-Type: application/json}', null);

      final headers = {
        'Authorization': token,
        'Content-Type': 'application/json',
      };

      final response = await _makeRequest('get', url, headers: headers);

      XBoardLogger.debug('获取消息历史响应详情: Status: ${response.statusCode}, Body: ${response.body}', null);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        // 修复编码问题
        if (data['items'] is List) {
          final items = data['items'] as List;
          for (var i = 0; i < items.length; i++) {
            if (items[i] is Map && items[i]['content'] is String) {
              // 尝试修复编码
              final content = items[i]['content'] as String;
              // 这个编码修复方法尝试将Latin-1编码的UTF-8字符转回UTF-8
              try {
                final bytes = latin1.encode(content); // 先按Latin-1编码成字节
                items[i]['content'] = utf8.decode(bytes); // 再按UTF-8解码
              } catch (e) {
                XBoardLogger.error('编码修复失败', e);
              }
            }
          }
        }

        XBoardLogger.info('获取消息历史成功，共 ${data['items']?.length ?? 0} 条消息');
        return MessageListResponse.fromJson(data);
      } else {
        XBoardLogger.error('获取消息历史失败: ${response.statusCode} ${response.body}');
        throw Exception(appLocalizations.onlineSupportGetMessagesFailed(response.statusCode));
      }
    } catch (e) {
      XBoardLogger.error('获取消息历史异常', e);
      rethrow;
    }
  }

  /// 获取未读消息数量
  Future<int> getUnreadCount() async {
    try {
      // 获取token
      final token = await CustomerSupportServiceConfig.getUserToken();
      if (token == null) {
        XBoardLogger.error(appLocalizations.onlineSupportSendMessageFailed);
        return 0;
      }

      final url = '$baseUrl/messages/unread';
      
      XBoardLogger.debug('获取未读消息数请求详情: URL: $url, Headers: {Authorization: $token}', null);

      final headers = {
        'Authorization': token,
        'Content-Type': 'application/json',
      };

      final response = await _makeRequest('get', url, headers: headers);

      XBoardLogger.debug('获取未读消息数响应详情: Status: ${response.statusCode}, Body: ${response.body}', null);

      if (response.statusCode == 200) {
        final count = int.tryParse(response.body) ?? 0;
        XBoardLogger.info('获取未读消息数成功: $count');
        return count;
      } else {
        XBoardLogger.error('获取未读消息数失败: ${response.statusCode} ${response.body}');
        return 0;
      }
    } catch (e) {
      XBoardLogger.error('获取未读消息数异常', e);
      return 0;
    }
  }

  /// 标记消息为已读
  Future<void> markMessagesAsRead(List<String> messageIds) async {
    try {
      // 获取token
      final token = await CustomerSupportServiceConfig.getUserToken();
      if (token == null) {
        throw Exception(appLocalizations.onlineSupportTokenNotFound);
      }

      // 打印详细的请求信息用于调试
      final url = '$baseUrl/messages/mark-read';
      final requestBody = {
        'message_ids': messageIds,
      };
      
      XBoardLogger.debug('OnlineSupportApiService', '标记消息已读请求详情: URL: $url, Headers: {Content-Type: application/json, Authorization: $token}, Body: ${jsonEncode(requestBody)}');

      final response = await _httpClient.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode(requestBody),
      );

      XBoardLogger.debug('标记消息已读响应详情: Status: ${response.statusCode}, Body: ${response.body}', null);

      if (response.statusCode != 200) {
        XBoardLogger.error('标记消息已读失败: ${response.statusCode} ${response.body}');
        
        // 尝试其他可能的API路径
        await _tryAlternativeMarkReadApis(messageIds, token);
        return;
      }
      
      XBoardLogger.info('标记消息已读成功');
    } catch (e) {
      XBoardLogger.error('标记消息已读异常', e);
      rethrow;
    }
  }

  /// 尝试其他可能的标记已读API路径
  Future<void> _tryAlternativeMarkReadApis(List<String> messageIds, String token) async {
    // 后端源码显示WebSocket也支持标记已读，但我们专注于HTTP API
    XBoardLogger.debug('尝试WebSocket标记已读...');
    XBoardLogger.info('注意：后端标记已读功能主要在WebSocket中实现');
    
    final alternativeEndpoints = [
      '/messages/read/',           // 可能的路径1
      '/messages/mark_read/',      // 可能的路径2 
      '/messages/read-status/',    // 可能的路径3
      '/mark-read/',              // 可能的路径4
    ];

    for (final endpoint in alternativeEndpoints) {
      try {
        final url = '$baseUrl$endpoint';
        XBoardLogger.debug('尝试备用API路径: $url');
        
        final response = await _httpClient.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
          body: jsonEncode({
            'message_ids': messageIds,
          }),
        );

        XBoardLogger.debug('备用API响应: ${response.statusCode} ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          XBoardLogger.info('备用API路径成功: $endpoint');
          return;
        }
      } catch (e) {
        XBoardLogger.error('备用API路径失败 $endpoint', e);
      }
    }

    XBoardLogger.error('所有标记已读API路径都失败了');
    // 不抛出异常，让调用者处理失败情况
  }

  /// 发送带附件的消息
  Future<ChatMessage?> sendMessageWithAttachments({
    String content = '',
    required List<int> attachmentIds,
  }) async {
    try {
      // 获取token
      final token = await CustomerSupportServiceConfig.getUserToken();
      if (token == null) {
        XBoardLogger.error(appLocalizations.onlineSupportSendMessageFailed);
        return null;
      }

      final url = '$baseUrl/files/send-with-attachment';
      final requestBody = {
        'content': content,
        'attachment_ids': attachmentIds,
      };

      XBoardLogger.debug('OnlineSupportApiService', '发送带附件消息请求详情: URL: $url, Headers: {Content-Type: application/json, Authorization: $token}, Body: ${jsonEncode(requestBody)}');

      final response = await _httpClient.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode(requestBody),
      );

      XBoardLogger.debug('发送带附件消息响应详情: Status: ${response.statusCode}, Body: ${response.body}', null);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        XBoardLogger.info('发送带附件消息成功');
        return ChatMessage.fromJson(data);
      } else {
        XBoardLogger.error('发送带附件消息失败: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      XBoardLogger.error('发送带附件消息异常', e);
      return null;
    }
  }
}
