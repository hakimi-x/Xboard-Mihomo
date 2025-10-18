import 'dart:async';
import '../models/parsed_configuration.dart';
import '../models/config_entry.dart';
import '../models/proxy_info.dart';
import '../models/websocket_info.dart';
import '../models/update_info.dart';
import '../models/online_support_info.dart';
import '../models/subscription_info.dart';
import '../fetchers/remote_config_manager.dart';
import '../../core/core.dart';


import '../parsers/configuration_parser.dart';
import '../services/panel_service.dart';
import '../services/proxy_service.dart';
import '../services/websocket_service.dart';
import '../services/update_service.dart';
import '../services/online_support_service.dart';

/// 配置访问器状态
enum ConfigAccessorState {
  uninitialized,
  loading,
  ready,
  error,
}

/// XBoard配置访问器
/// 
/// 统一接口层，整合所有配置获取、解析和服务模块
/// 注意：这个类不应该被外部直接实例化，请使用XBoardConfig
class XBoardConfigAccessor {
  final RemoteConfigManager _remoteManager;
  final ConfigurationParser _parser;
  final String _currentProvider;

  // 状态管理
  ConfigAccessorState _state = ConfigAccessorState.uninitialized;
  ParsedConfiguration? _currentConfig;
  String? _lastError;
  DateTime? _lastUpdateTime;

  // 服务实例
  PanelService? _panelService;
  ProxyService? _proxyService;
  WebSocketService? _webSocketService;
  UpdateService? _updateService;
  OnlineSupportService? _onlineSupportService;

  // 事件流
  final StreamController<ParsedConfiguration> _configStreamController = 
      StreamController<ParsedConfiguration>.broadcast();
  final StreamController<ConfigAccessorState> _stateStreamController = 
      StreamController<ConfigAccessorState>.broadcast();

  XBoardConfigAccessor({
    required RemoteConfigManager remoteManager,
    required ConfigurationParser parser,
    required String currentProvider,
  }) : _remoteManager = remoteManager,
       _parser = parser,
       _currentProvider = currentProvider;

  // ========== 状态属性 ==========

  /// 当前状态
  ConfigAccessorState get state => _state;

  /// 是否正在加载
  bool get isLoading => _state == ConfigAccessorState.loading;

  /// 是否已准备就绪
  bool get isReady => _state == ConfigAccessorState.ready;

  /// 最后的错误信息
  String? get lastError => _lastError;

  /// 最后更新时间
  DateTime? get lastUpdateTime => _lastUpdateTime;

  /// 当前配置
  ParsedConfiguration? get currentConfig => _currentConfig;

  /// 当前提供商
  String get currentProvider => _currentProvider;

  // ========== 事件流 ==========

  /// 配置变化流
  Stream<ParsedConfiguration> get configStream => _configStreamController.stream;

  /// 状态变化流
  Stream<ConfigAccessorState> get stateStream => _stateStreamController.stream;

  // ========== 配置管理 ==========

  /// 获取完整配置
  Future<ParsedConfiguration?> getConfiguration() async {
    if (_currentConfig != null && _state == ConfigAccessorState.ready) {
      return _currentConfig;
    }

    await refreshConfiguration();
    return _currentConfig;
  }

  /// 刷新配置（纯远程实时获取）
  Future<void> refreshConfiguration() async {
    await _updateState(ConfigAccessorState.loading);
    _lastError = null;

    try {
      // 直接从远程获取最新配置
      final multiResult = await _remoteManager.fetchAllConfigs();
      if (multiResult.hasSuccess && multiResult.firstSuccessfulData != null) {
        final configData = _parser.extractConfigFromRemoteResult(multiResult.firstSuccessfulData!);
        if (configData != null) {
          await _processConfigData(configData, multiResult.firstSuccessfulSource ?? 'remote');
          return;
        }
      }

      // 远程获取失败
      throw Exception('Remote config fetch failed');

    } catch (e) {
      _lastError = 'Configuration refresh failed: $e';
      await _updateState(ConfigAccessorState.error);
      ConfigLogger.error('Configuration refresh failed', e);
    }
  }



  /// 从指定源刷新配置
  Future<void> refreshFromSource(String sourceName) async {
    await _updateState(ConfigAccessorState.loading);
    _lastError = null;

    try {
      ConfigResult<Map<String, dynamic>> result;

      switch (sourceName.toLowerCase()) {
        case 'remote':
          final multiResult = await _remoteManager.fetchAllConfigs();
          result = multiResult.firstSuccessful ?? ConfigResult.failure('No successful remote source', 'remote');
          break;
        case 'redirect':
          result = await _remoteManager.getRedirectConfig();
          break;
        case 'gitee':
          result = await _remoteManager.getGiteeConfig();
          break;
        default:
          result = ConfigResult.failure('Unknown source: $sourceName. Only remote sources (redirect, gitee) are supported.', sourceName);
      }

      if (result.isSuccess && result.data != null) {
        // 提取配置数据（所有源都是远程源）
        final configData = _parser.extractConfigFromRemoteResult(result.data!);

        if (configData != null) {
          await _processConfigData(configData, result.source);
        } else {
          throw Exception('Invalid config data from $sourceName');
        }
      } else {
        throw Exception('Failed to get config from $sourceName: ${result.error}');
      }

    } catch (e) {
      _lastError = 'Refresh from $sourceName failed: $e';
      await _updateState(ConfigAccessorState.error);
      ConfigLogger.error('Refresh from $sourceName failed', e);
    }
  }

  /// 清除缓存（已移除缓存功能）
  Future<void> clearCache() async {
    ConfigLogger.info('Cache functionality removed, using real-time data');
  }

  // ========== 服务数据分发方法 ==========

  /// 获取面板配置列表
  List<ConfigEntry> getPanelConfigList() {
    return _panelService?.getCurrentProviderPanels() ?? [];
  }

  /// 获取代理配置列表
  List<ProxyInfo> getProxyConfigList() {
    return _proxyService?.getAllProxies() ?? [];
  }

  /// 获取WebSocket配置列表
  List<WebSocketInfo> getWebSocketConfigList() {
    return _webSocketService?.getAllWebSockets() ?? [];
  }

  /// 获取更新配置列表
  List<UpdateInfo> getUpdateConfigList() {
    return _updateService?.getAllUpdateSources() ?? [];
  }

  /// 获取在线客服配置列表
  List<OnlineSupportInfo> getOnlineSupportConfigs() {
    return _onlineSupportService?.getAllConfigs() ?? [];
  }

  /// 获取订阅配置信息
  SubscriptionInfo? getSubscriptionInfo() {
    return _currentConfig?.subscription;
  }

  // ========== 便捷访问方法 ==========

  /// 获取第一个面板URL
  String? getFirstPanelUrl() {
    return _panelService?.getFirstPanelUrl();
  }

  /// 获取第一个代理URL
  String? getFirstProxyUrl() {
    return _proxyService?.getFirstProxyUrl();
  }

  /// 获取第一个WebSocket URL
  String? getFirstWebSocketUrl() {
    return _webSocketService?.getFirstWebSocketUrl();
  }

  /// 获取第一个更新URL
  String? getFirstUpdateUrl() {
    return _updateService?.getFirstUpdateUrl();
  }

  /// 获取第一个在线客服API URL
  String? getFirstOnlineSupportApiUrl() {
    return _onlineSupportService?.getApiBaseUrl();
  }

  /// 获取第一个在线客服WebSocket URL
  String? getFirstOnlineSupportWsUrl() {
    return _onlineSupportService?.getWebSocketBaseUrl();
  }

  /// 获取第一个订阅URL
  String? getFirstSubscriptionUrl() {
    return _currentConfig?.firstSubscriptionUrl;
  }

  /// 获取第一个支持加密的订阅URL
  String? getFirstEncryptSubscriptionUrl() {
    return _currentConfig?.firstEncryptSubscriptionUrl;
  }

  /// 构建订阅URL
  String? buildSubscriptionUrl(String token, {bool preferEncrypt = true}) {
    return _currentConfig?.buildSubscriptionUrl(token, preferEncrypt: preferEncrypt);
  }

  // ========== 统计信息 ==========

  /// 获取配置统计信息
  Map<String, dynamic> getConfigStats() {
    if (_currentConfig == null) {
      return {
        'panels': 0,
        'proxies': 0,
        'webSockets': 0,
        'updates': 0,
        'onlineSupport': 0,
        'subscriptionUrls': 0,
      };
    }

    return {
      'panels': _currentConfig!.panels.getAll().length,
      'proxies': _currentConfig!.proxies.length,
      'webSockets': _currentConfig!.webSockets.length,
      'updates': _currentConfig!.updates.length,
      'onlineSupport': _currentConfig!.onlineSupport.length,
      'subscriptionUrls': _currentConfig!.subscription?.urls.length ?? 0,
      'subscriptionEncryptUrls': _currentConfig!.subscription?.encryptUrls.length ?? 0,
      'currentProvider': _currentProvider,
      'lastUpdateTime': _lastUpdateTime?.toIso8601String(),
      'sourceHash': _currentConfig!.sourceHash,
    };
  }

  /// 获取服务统计信息
  Map<String, dynamic> getServiceStats() {
    return {
      'panel': _panelService?.getPanelStats() ?? {},
      'proxy': _proxyService?.getProxyStats() ?? {},
      'webSocket': _webSocketService?.getWebSocketStats() ?? {},
      'update': _updateService?.getUpdateStats() ?? {},
      'onlineSupport': _onlineSupportService?.getConfigStats() ?? {},
    };
  }

  // ========== 内部方法 ==========

  /// 处理配置数据
  Future<void> _processConfigData(Map<String, dynamic> configData, String source) async {
    try {
      // 解析配置
      _currentConfig = _parser.parseFromJson(configData, _currentProvider);
      _lastUpdateTime = DateTime.now();

      // 创建服务实例
      _panelService = PanelService(_currentConfig!.panels);
      _proxyService = ProxyService(_currentConfig!.proxies);
      _webSocketService = WebSocketService(_currentConfig!.webSockets);
      _updateService = UpdateService(_currentConfig!.updates);
      _onlineSupportService = OnlineSupportService(_currentConfig!.onlineSupport);

      await _updateState(ConfigAccessorState.ready);

      // 发送配置更新事件
      _configStreamController.add(_currentConfig!);

      ConfigLogger.info('Configuration loaded from $source');
    } catch (e) {
      throw Exception('Failed to process config data: $e');
    }
  }

  /// 更新状态
  Future<void> _updateState(ConfigAccessorState newState) async {
    if (_state != newState) {
      _state = newState;
      _stateStreamController.add(_state);
    }
  }

  /// 释放资源
  void dispose() {
    _configStreamController.close();
    _stateStreamController.close();
  }

  @override
  String toString() {
    return 'XBoardConfigAccessor(state: $_state, provider: $_currentProvider, '
           'hasConfig: ${_currentConfig != null})';
  }
}