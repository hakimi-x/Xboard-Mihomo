import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fl_clash/xboard/config/xboard_config.dart';
import 'package:fl_clash/xboard/config/utils/config_file_loader.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
// 已从core/utils导出
import 'package:fl_clash/xboard/core/core.dart';
import 'package:fl_clash/xboard/infrastructure/infrastructure.dart';
import 'package:fl_clash/xboard/infrastructure/http/user_agent_config.dart';
import 'encrypted_subscription_service.dart';

/// 并发竞速订阅获取服务
/// 
/// 实现多源并发请求，先到先用的竞速机制
class ConcurrentSubscriptionService {
  static const Duration requestTimeout = Duration(seconds: 30);
  
  /// 并发竞速获取加密订阅（从登录数据）
  /// 
  /// [preferEncrypt] 是否优先使用加密端点
  /// 
  /// 返回最快成功的订阅结果
  static Future<SubscriptionResult> raceGetEncryptedSubscriptionFromLogin({
    bool preferEncrypt = true,
  }) async {
    try {
      XBoardLogger.info('[竞速订阅] 从登录数据开始并发获取');

      // 1. 获取订阅信息和token
      final subscriptionData = await XBoardSDK.getSubscription();
      if (subscriptionData == null) {
        return SubscriptionResult.failure('未获取到订阅信息');
      }
      
      final token = subscriptionData.token;
      if (token == null || token.isEmpty) {
        return SubscriptionResult.failure('订阅token无效');
      }

      XBoardLogger.info('[竞速订阅] 获取到token: ${token.substring(0, 8)}...');

      // 2. 使用token进行竞速获取
      return await raceGetEncryptedSubscription(token, preferEncrypt: preferEncrypt);

    } catch (e) {
      XBoardLogger.error('[竞速订阅] 从登录数据获取失败', e);
      return SubscriptionResult.failure('从登录数据获取订阅失败: $e');
    }
  }

  /// 并发竞速获取加密订阅（使用token）
  /// 
  /// [token] 用户的订阅token
  /// [preferEncrypt] 是否优先使用加密端点
  /// 
  /// 返回最快成功的订阅结果
  static Future<SubscriptionResult> raceGetEncryptedSubscription(
    String token, {
    bool preferEncrypt = true,
  }) async {
    try {
      XBoardLogger.info('[竞速订阅] 开始并发竞速获取，token: ${token.substring(0, 8)}...');

      // 1. 获取所有可用的订阅URL信息
      final subscriptionUrlInfos = _getAllSubscriptionUrlInfos();
      if (subscriptionUrlInfos.isEmpty) {
        XBoardLogger.warning('[竞速订阅] 没有找到可用的订阅URL配置');
        // 回退到单一订阅获取
        return await EncryptedSubscriptionService.getEncryptedSubscription(
          token, 
          preferEncrypt: preferEncrypt
        );
      }

      XBoardLogger.info('[竞速订阅] 找到 ${subscriptionUrlInfos.length} 个订阅URL，开始并发请求');

      // 2. 为每个URL构建完整的请求URL
      final requestUrls = <String>[];
      for (final urlInfo in subscriptionUrlInfos) {
        final fullUrl = urlInfo.buildSubscriptionUrl(token, preferEncrypt: preferEncrypt);
        if (fullUrl.isNotEmpty) {
          requestUrls.add(fullUrl);
          XBoardLogger.debug('[竞速订阅] 添加请求URL: $fullUrl');
        }
      }

      if (requestUrls.isEmpty) {
        return SubscriptionResult.failure('无法构建有效的订阅请求URL');
      }

      // 3. 执行并发竞速请求
      final result = await _raceMultipleRequests(requestUrls, token);
      
      XBoardLogger.info('[竞速订阅] 竞速请求完成，成功: ${result.success}');
      return result;

    } catch (e) {
      XBoardLogger.error('[竞速订阅] 并发获取异常', e);
      return SubscriptionResult.failure('并发竞速获取失败: $e');
    }
  }

  /// 获取所有订阅URL信息
  static List<SubscriptionUrlInfo> _getAllSubscriptionUrlInfos() {
    try {
      if (!XBoardConfig.isInitialized) {
        XBoardLogger.warning('[竞速订阅] XBoardConfig 未初始化');
        return [];
      }
      
      return XBoardConfig.subscriptionUrlList;
    } catch (e) {
      XBoardLogger.error('[竞速订阅] 获取订阅URL列表失败', e);
      return [];
    }
  }

  /// 执行并发竞速请求
  /// 
  /// [urls] 要请求的URL列表
  /// [originalToken] 原始token（用于日志）
  /// 
  /// 返回最快成功的结果
  static Future<SubscriptionResult> _raceMultipleRequests(
    List<String> urls, 
    String originalToken,
  ) async {
    if (urls.isEmpty) {
      return SubscriptionResult.failure('没有可用的请求URL');
    }

    if (urls.length == 1) {
      // 只有一个URL，直接请求
      XBoardLogger.info('[竞速订阅] 只有一个URL，直接请求');
      return await _fetchSingleSubscription(urls.first, originalToken);
    }

    XBoardLogger.info('[竞速订阅] 开始并发竞速请求 ${urls.length} 个URL');

    // 创建并发请求任务
    final List<Future<SubscriptionResult>> futures = [];
    final List<CancelToken> cancelTokens = [];

    for (int i = 0; i < urls.length; i++) {
      final url = urls[i];
      final cancelToken = CancelToken();
      cancelTokens.add(cancelToken);
      
      futures.add(_fetchSingleSubscriptionWithCancel(url, originalToken, cancelToken, i));
    }

    try {
      // 使用 Future.any 实现竞速，第一个成功的获胜
      SubscriptionResult? winner;
      
      // 创建一个 Completer 来处理竞速逻辑
      final completer = Completer<SubscriptionResult>();
      int completedCount = 0;
      final errors = <String>[];
      
      for (int i = 0; i < futures.length; i++) {
        futures[i].then((result) {
          if (!completer.isCompleted && result.success) {
            // 第一个成功的获胜
            XBoardLogger.info('[竞速订阅] 请求 #$i 获胜！');
            completer.complete(result);
            
            // 取消其他请求
            for (int j = 0; j < cancelTokens.length; j++) {
              if (j != i) cancelTokens[j].cancel();
            }
          } else {
            completedCount++;
            if (result.error != null) {
              errors.add('请求#$i: ${result.error}');
            }
            
            // 如果所有请求都完成且都失败了
            if (completedCount == futures.length && !completer.isCompleted) {
              completer.complete(SubscriptionResult.failure(
                '所有并发请求都失败: ${errors.join('; ')}'
              ));
            }
          }
        }).catchError((e) {
          completedCount++;
          errors.add('请求#$i异常: $e');
          
          if (completedCount == futures.length && !completer.isCompleted) {
            completer.complete(SubscriptionResult.failure(
              '所有并发请求都失败: ${errors.join('; ')}'
            ));
          }
        });
      }
      
      winner = await completer.future;
      return winner;

    } catch (e) {
      // 所有请求都失败了，尝试等待并收集错误信息
      XBoardLogger.warning('[竞速订阅] 所有并发请求可能都失败了，等待收集错误信息');
      
      final results = await Future.wait(
        futures.map((future) => future.catchError((e) => 
          SubscriptionResult.failure('请求失败: $e')
        )),
      );

      // 检查是否有成功的结果
      final successResults = results.where((r) => r.success);
      if (successResults.isNotEmpty) {
        XBoardLogger.info('[竞速订阅] 在错误处理中发现成功结果');
        return successResults.first;
      }

      // 所有都失败了，返回综合错误信息
      final errors = results.map((r) => r.error ?? '未知错误').toList();
      return SubscriptionResult.failure(
        '所有并发请求都失败了: ${errors.join('; ')}'
      );
    }
  }

  /// 获取单个订阅（带取消支持）
  static Future<SubscriptionResult> _fetchSingleSubscriptionWithCancel(
    String url, 
    String originalToken, 
    CancelToken cancelToken, 
    int index,
  ) async {
    try {
      XBoardLogger.debug('[竞速订阅] 请求 #$index 开始: ${url.length > 50 ? '${url.substring(0, 50)}...' : url}');
      
      final result = await _fetchSingleSubscription(url, originalToken)
          .timeout(requestTimeout)
          .catchError((e) {
            if (cancelToken.isCancelled) {
              XBoardLogger.debug('[竞速订阅] 请求 #$index 被取消');
              throw CancellationException('Request cancelled');
            }
            throw e;
          });

      if (cancelToken.isCancelled) {
        XBoardLogger.debug('[竞速订阅] 请求 #$index 完成但已被取消');
        throw CancellationException('Request cancelled after completion');
      }

      if (result.success) {
        XBoardLogger.info('[竞速订阅] 请求 #$index 获胜! 用时: ${result.originalUrl}');
      }

      return result;
    } catch (e) {
      if (e is CancellationException) {
        XBoardLogger.debug('[竞速订阅] 请求 #$index 被正常取消');
        return SubscriptionResult.failure('请求被取消');
      }
      
      XBoardLogger.debug('[竞速订阅] 请求 #$index 失败: $e');
      return SubscriptionResult.failure('请求失败: $e');
    }
  }

  /// 获取单个订阅（复用现有逻辑）
  static Future<SubscriptionResult> _fetchSingleSubscription(
    String url, 
    String originalToken,
  ) async {
    try {
      // 1. 发起HTTP请求
      final dataResult = await _fetchEncryptedData(url);
      if (!dataResult.success) {
        return SubscriptionResult.failure(dataResult.error!);
      }

      XBoardLogger.debug('[竞速订阅] 获取到数据，长度: ${dataResult.data!.length}');

      // 2. 解密数据
      final decryptKey = await ConfigFileLoaderHelper.getDecryptKey();
      final decryptResult = XBoardDecryptHelper.smartDecrypt(
        dataResult.data!,
        configuredKey: decryptKey,
        tryFallback: true,
      );
      if (!decryptResult.success) {
        return SubscriptionResult.failure('解密失败: ${decryptResult.message}');
      }

      return SubscriptionResult.success(
        content: decryptResult.content,
        encryptionUsed: true,
        keyUsed: decryptResult.keyUsed,
        originalUrl: url,
        subscriptionUserInfo: dataResult.subscriptionUserInfo,
      );

    } catch (e) {
      return SubscriptionResult.failure('单个请求失败: $e');
    }
  }

  /// 发起HTTP请求获取数据（复用EncryptedSubscriptionService的逻辑）
  static Future<DataResult> _fetchEncryptedData(String url) async {
    try {
      final client = HttpClient();
      client.connectionTimeout = requestTimeout;
      
      final uri = Uri.parse(url);
      final request = await client.getUrl(uri);
      
      // 设置请求头
      final userAgent = await UserAgentConfig.get(UserAgentScenario.subscriptionRacing);
      request.headers.set(HttpHeaders.userAgentHeader, userAgent);
      request.headers.set(HttpHeaders.acceptHeader, '*/*');
      
      final response = await request.close().timeout(requestTimeout);
      
      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final subscriptionUserInfo = response.headers.value('subscription-userinfo');
        client.close();
        
        // 尝试解析JSON响应
        try {
          final jsonData = jsonDecode(responseBody);
          if (jsonData is Map<String, dynamic> && jsonData.containsKey('data')) {
            return DataResult.success(jsonData['data'] as String, subscriptionUserInfo: subscriptionUserInfo);
          }
        } catch (e) {
          // 如果不是JSON，直接返回响应体
        }
        
        return DataResult.success(responseBody, subscriptionUserInfo: subscriptionUserInfo);
        
      } else {
        client.close();
        return DataResult.failure('HTTP请求失败: ${response.statusCode}');
      }
      
    } on TimeoutException {
      return DataResult.failure('请求超时');
    } catch (e) {
      return DataResult.failure('请求异常: $e');
    }
  }
}

/// 取消令牌
class CancelToken {
  bool _isCancelled = false;
  
  bool get isCancelled => _isCancelled;
  
  void cancel() {
    _isCancelled = true;
  }
}

/// 取消异常
class CancellationException implements Exception {
  final String message;
  
  const CancellationException(this.message);
  
  @override
  String toString() => 'CancellationException: $message';
}