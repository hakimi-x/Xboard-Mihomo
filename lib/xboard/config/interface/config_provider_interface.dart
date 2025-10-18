/// 配置提供者接口
///
/// 定义配置模块的公共API，允许SDK层依赖接口而不依赖具体实现
///
/// 使用示例：
/// ```dart
/// class MyConfigProvider implements ConfigProviderInterface {
///   @override
///   String? getPanelUrl() {
///     // 自定义实现
///   }
/// }
/// ```
library;

import '../models/subscription_info.dart';

/// 配置提供者接口
abstract interface class ConfigProviderInterface {
  // ===== 基础配置获取 =====

  /// 获取第一个面板 URL
  String? getPanelUrl();

  /// 获取第一个代理 URL
  String? getProxyUrl();

  /// 获取第一个 WebSocket URL
  String? getWebSocketUrl();

  /// 获取第一个更新 URL
  String? getUpdateUrl();

  // ===== 订阅配置 =====

  /// 获取订阅信息
  SubscriptionInfo? getSubscriptionInfo();

  /// 获取第一个订阅 URL
  String? getSubscriptionUrl();

  /// 构建订阅 URL（带 token）
  ///
  /// [token] 用户订阅 token
  /// [preferEncrypt] 是否优先使用加密链接
  String? buildSubscriptionUrl(String token, {bool preferEncrypt = true});

  // ===== 高级功能 =====

  /// 并发竞速获取最快的面板 URL
  Future<String?> getFastestPanelUrl();

  /// 获取所有面板 URL 列表
  List<String> getAllPanelUrls();

  /// 获取所有代理 URL 列表
  List<String> getAllProxyUrls();

  /// 获取所有 WebSocket URL 列表
  List<String> getAllWebSocketUrls();

  // ===== 配置管理 =====

  /// 刷新配置
  Future<void> refresh();

  /// 从指定源刷新配置
  ///
  /// [source] 配置源名称，如 'redirect', 'gitee'
  Future<void> refreshFromSource(String source);

  /// 监听配置变化
  ///
  /// 返回配置变化的流，外部可以监听配置更新
  Stream<void> get configChangeStream;
}

