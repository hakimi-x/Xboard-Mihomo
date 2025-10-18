import 'dart:async';
import 'package:flutter_xboard_sdk/flutter_xboard_sdk.dart';
import 'package:fl_clash/xboard/core/core.dart';
import 'package:fl_clash/xboard/config/interface/config_provider_interface.dart';
import 'package:fl_clash/xboard/config/utils/config_file_loader.dart';
import 'package:fl_clash/xboard/infrastructure/http/user_agent_config.dart';

/// 简化的 XBoard 客户端
///
/// 这是一个轻量级的 SDK 封装类，负责：
/// 1. SDK 初始化和配置
/// 2. 统一的实例管理
/// 3. 直接暴露 SDK 的所有 API
///
/// 使用示例:
/// ```dart
/// // 初始化（通过依赖注入配置提供者）
/// await XBoardClient.instance.initialize(configProvider: myConfigProvider);
///
/// // 或使用默认配置（需要先初始化XBoardConfig）
/// await XBoardClient.instance.initialize();
///
/// // 使用 SDK API
/// final userInfo = await XBoardClient.instance.sdk.userInfo.getUserInfo();
/// await XBoardClient.instance.sdk.login.login(email, password);
/// final plans = await XBoardClient.instance.sdk.plan.fetchPlans();
/// ```
class XBoardClient {
  static XBoardClient? _instance;
  static XBoardClient get instance => _instance ??= XBoardClient._internal();

  XBoardClient._internal();

  XBoardSDK? _sdk;
  String? _currentPanelUrl;
  bool _isInitialized = false;
  Completer<void>? _initCompleter;
  ConfigProviderInterface? _configProvider;

  /// 初始化客户端
  ///
  /// [configProvider] 配置提供者（可选，如果不提供则需要确保XBoardConfig已初始化）
  /// [baseUrl] 可选的直接指定基础URL（优先级最高）
  /// [strategy] 初始化策略:
  ///   - 'race_fastest': 竞速模式，选择最快的面板URL (默认)
  ///   - 'first': 使用第一个面板URL
  /// [config] 额外配置参数
  Future<void> initialize({
    ConfigProviderInterface? configProvider,
    String? baseUrl,
    String strategy = 'race_fastest',
    Map<String, dynamic>? config,
  }) async {
    if (_isInitialized) return;
    if (_initCompleter != null) {
      return _initCompleter!.future;
    }

    _initCompleter = Completer<void>();

    try {
      XBoardLogger.info('[SDK] 开始初始化 XBoardClient，策略: $strategy');

      // 保存配置提供者
      _configProvider = configProvider;

      // 获取面板URL
      String? panelUrl = baseUrl;
      
      if (panelUrl == null) {
        // 没有直接指定baseUrl，从配置提供者获取
        if (_configProvider == null) {
          throw XBoardConfigException(
            message: '未提供配置提供者且未指定baseUrl',
            code: 'CONFIG_PROVIDER_MISSING',
          );
        }

        // 根据策略选择面板URL
        if (strategy == 'race_fastest') {
          panelUrl = await _configProvider!.getFastestPanelUrl();
          XBoardLogger.info('[SDK] 使用竞速模式选择面板地址: $panelUrl');
        } else {
          panelUrl = _configProvider!.getPanelUrl();
          XBoardLogger.info('[SDK] 使用默认模式选择面板地址: $panelUrl');
        }
      }

      if (panelUrl == null) {
        throw XBoardConfigException(
          message: '无法获取面板地址',
          code: 'PANEL_URL_NOT_FOUND',
        );
      }

      // 从配置文件加载 HTTP 配置
      XBoardLogger.info('[SDK] 正在从配置文件加载 HTTP 配置...');
      final httpConfig = await _loadHttpConfigFromFile();
      XBoardLogger.info('[SDK] HTTP 配置加载完成: UA=${httpConfig.userAgent != null ? "已设置" : "默认"}, '
          '混淆前缀=${httpConfig.obfuscationPrefix != null ? "已设置" : "未设置"}');

      // 初始化 SDK（传递 httpConfig）
      _sdk = XBoardSDK.instance;
      await _sdk!.initialize(panelUrl, httpConfig: httpConfig);
      _currentPanelUrl = panelUrl;

      _isInitialized = true;
      _initCompleter!.complete();
      XBoardLogger.info('[SDK] XBoardClient 初始化完成');
    } catch (e) {
      XBoardLogger.error('[SDK] XBoardClient 初始化失败', e);
      _initCompleter!.completeError(e);
      _isInitialized = false;
      rethrow;
    }
  }

  /// 获取 SDK 实例
  ///
  /// 直接暴露 SDK，让上层可以访问所有 API:
  /// - sdk.login.login()
  /// - sdk.register.register()
  /// - sdk.userInfo.getUserInfo()
  /// - sdk.plan.fetchPlans()
  /// - sdk.subscription.getSubscriptionLink()
  /// - sdk.payment.*
  /// - sdk.order.*
  /// - sdk.ticket.*
  /// - sdk.invite.*
  XBoardSDK get sdk {
    if (_sdk == null) {
      throw XBoardConfigException(
        message: 'SDK 未初始化，请先调用 initialize()',
        code: 'SDK_NOT_INITIALIZED',
      );
    }
    return _sdk!;
  }

  /// 检查是否已初始化
  bool get isInitialized => _isInitialized;

  /// 获取当前面板URL
  Future<String?> getCurrentDomain() async {
    return _currentPanelUrl;
  }

  /// 切换到最快的面板URL（重新竞速）
  Future<void> switchToFastestDomain() async {
    if (_configProvider == null) {
      XBoardLogger.warning('[SDK] 没有配置提供者，无法切换域名');
      return;
    }

    XBoardLogger.info('[SDK] 开始切换到最快的面板URL');
    
    final fastestUrl = await _configProvider!.getFastestPanelUrl();
    if (fastestUrl == null) {
      XBoardLogger.warning('[SDK] 无法获取最快的面板URL');
      return;
    }

    if (fastestUrl == _currentPanelUrl) {
      XBoardLogger.info('[SDK] 当前URL已经是最快的: $fastestUrl');
      return;
    }

    XBoardLogger.info('[SDK] 切换面板URL: $_currentPanelUrl -> $fastestUrl');
    
    // 重新初始化SDK
    _isInitialized = false;
    _initCompleter = null;
    await initialize(
      configProvider: _configProvider,
      baseUrl: fastestUrl,
      strategy: 'first',
    );
  }

  /// 从配置文件加载 HTTP 配置
  /// 
  /// 从 xboard.config.yaml 读取：
  /// - User-Agent (security.user_agents.api_encrypted)
  /// - 混淆前缀 (security.obfuscation_prefix)
  Future<HttpConfig> _loadHttpConfigFromFile() async {
    try {
      // 从配置文件获取加密 UA（用于 API 请求和 Caddy 认证）
      final userAgent = await UserAgentConfig.get(UserAgentScenario.apiEncrypted);
      
      // 从配置文件获取混淆前缀
      final obfuscationPrefix = await ConfigFileLoaderHelper.getObfuscationPrefix();
      
      // 构建 HttpConfig
      return HttpConfig(
        userAgent: userAgent,
        obfuscationPrefix: obfuscationPrefix,
        enableAutoDeobfuscation: obfuscationPrefix != null,
        enableCertificatePinning: false,
      );
    } catch (e) {
      XBoardLogger.error('[SDK] 加载 HTTP 配置失败，使用默认配置', e);
      // 如果加载失败，返回默认配置
      return HttpConfig.defaultConfig();
    }
  }

  /// 释放资源
  void dispose() {
    XBoardLogger.info('[SDK] 释放 XBoardClient 资源');
    _sdk = null;
    _currentPanelUrl = null;
    _isInitialized = false;
    _initCompleter = null;
    _configProvider = null;
  }

  /// 重置单例（主要用于测试）
  static void resetInstance() {
    _instance?.dispose();
    _instance = null;
  }
}
