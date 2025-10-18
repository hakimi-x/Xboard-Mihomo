import 'package:fl_clash/xboard/core/core.dart';
import 'package:fl_clash/xboard/config/core/service_locator.dart';
import 'package:fl_clash/xboard/config/services/online_support_service.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';

/// 客服系统服务配置
class CustomerSupportServiceConfig {
  static OnlineSupportService? _service;

  /// 初始化配置服务
  static void _initializeService() {
    if (_service == null) {
      try {
        _service = ServiceLocator.get<OnlineSupportService>();
      } catch (e) {
        XBoardLogger.error('Failed to get OnlineSupportService', e);
        // 服务不可用时，_service 保持为 null，将使用默认值
      }
    }
  }

  /// HTTP API 基础URL
  static String? get apiBaseUrl {
    _initializeService();
    return _service?.getApiBaseUrl();
  }

  /// WebSocket 基础URL
  static String? get wsBaseUrl {
    _initializeService();
    return _service?.getWebSocketBaseUrl();
  }

  /// 获取当前用户的认证Token
  static Future<String?> getUserToken() async {
    try {
      
      final token = await XBoardSDK.getAuthToken();
      XBoardLogger.debug('getUserToken() 获取到的token: $token');
      return token;
    } catch (e) {
      XBoardLogger.error('getUserToken() 获取token失败', e);
      // 如果获取失败，返回null
      return null;
    }
  }

  /// 检查配置服务是否可用
  static bool get isConfigServiceAvailable {
    _initializeService();
    return _service != null && _service!.hasAvailableConfig();
  }

  /// 获取配置统计信息（用于调试）
  static Map<String, dynamic> getConfigStats() {
    _initializeService();
    return _service?.getConfigStats() ?? {
      'totalConfigs': 0,
      'hasApiConfig': false,
      'hasWebSocketConfig': false,
      'usingFallback': true,
    };
  }
}
