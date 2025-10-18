import '../models/config_entry.dart';
import '../models/panel_configuration.dart';

/// 面板服务
/// 
/// 负责面板相关的基础操作，暂不实现连通性测试等内部方法
class PanelService {
  final PanelConfiguration _panelConfig;

  PanelService(this._panelConfig);

  /// 获取当前提供商的面板列表
  List<ConfigEntry> getCurrentProviderPanels() {
    return _panelConfig.currentProviderPanels;
  }

  /// 获取指定提供商的面板列表
  List<ConfigEntry> getPanelsByProvider(String provider) {
    return _panelConfig.getByProvider(provider);
  }

  /// 获取所有面板列表
  List<ConfigEntry> getAllPanels() {
    return _panelConfig.getAll();
  }

  /// 获取第一个可用的面板URL
  String? getFirstPanelUrl() {
    return _panelConfig.firstUrl;
  }

  /// 并发竞速获取最快的面板URL
  /// 
  /// 使用并发竞速机制选择当前提供商最快响应的面板URL
  /// 这是推荐的获取面板URL方法，可以提供更好的用户体验
  Future<String?> getFastestPanelUrl() async {
    return await _panelConfig.getFastestUrl();
  }

  /// 获取当前提供商的所有面板URL
  List<String> getCurrentProviderPanelUrls() {
    return _panelConfig.currentProviderUrls;
  }

  /// 获取当前提供商
  String getCurrentProvider() {
    return _panelConfig.currentProvider;
  }

  /// 获取可用的提供商列表
  List<String> getAvailableProviders() {
    return _panelConfig.availableProviders;
  }

  /// 检查指定提供商是否有面板
  bool hasProvider(String provider) {
    return _panelConfig.availableProviders.contains(provider);
  }

  /// 获取面板统计信息
  Map<String, dynamic> getPanelStats() {
    final stats = <String, dynamic>{
      'currentProvider': getCurrentProvider(),
      'totalProviders': getAvailableProviders().length,
      'totalPanels': getAllPanels().length,
      'currentProviderPanels': getCurrentProviderPanels().length,
    };

    // 每个提供商的面板数量
    final providerCounts = <String, int>{};
    for (final provider in getAvailableProviders()) {
      providerCounts[provider] = getPanelsByProvider(provider).length;
    }
    stats['providerCounts'] = providerCounts;

    return stats;
  }

  @override
  String toString() {
    return 'PanelService(provider: ${getCurrentProvider()}, '
           'panels: ${getCurrentProviderPanels().length})';
  }
}