import 'config_entry.dart';
import '../../infrastructure/infrastructure.dart';

/// 面板配置
/// 
/// 管理不同厂家的面板配置，支持构建时选择提供商
class PanelConfiguration {
  final Map<String, List<ConfigEntry>> _panels;
  final String _currentProvider;
  
  const PanelConfiguration({
    required Map<String, List<ConfigEntry>> panels,
    required String currentProvider,
  }) : _panels = panels, _currentProvider = currentProvider;

  /// 从JSON创建面板配置
  factory PanelConfiguration.fromJson(
    Map<String, dynamic> json, 
    String currentProvider,
  ) {
    final panels = <String, List<ConfigEntry>>{};
    
    json.forEach((provider, panelList) {
      if (panelList is List) {
        panels[provider] = panelList
            .map((item) => ConfigEntry.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    });
    
    return PanelConfiguration(
      panels: panels,
      currentProvider: currentProvider,
    );
  }
  
  /// 获取当前构建时选择的提供商面板
  List<ConfigEntry> get currentProviderPanels => _panels[_currentProvider] ?? [];
  
  /// 获取指定提供商的面板
  List<ConfigEntry> getByProvider(String provider) => _panels[provider] ?? [];
  
  /// 获取所有面板
  List<ConfigEntry> getAll() => _panels.values.expand((list) => list).toList();
  
  /// 获取第一个可用的面板URL
  String? get firstUrl {
    final panels = currentProviderPanels;
    return panels.isNotEmpty ? panels.first.url : null;
  }

  /// 并发竞速选择最快的面板URL
  /// 
  /// 对当前提供商的所有面板URL进行并发测试，返回响应最快的URL
  /// 如果所有URL都失败，则返回第一个URL作为回退
  /// 注意：返回的URL会强制转换为HTTPS格式，以适配SDK的私有证书配置
  Future<String?> getFastestUrl() async {
    final panels = currentProviderPanels;
    if (panels.isEmpty) return null;
    if (panels.length == 1) return panels.first.url;

    final domains = panels.map((panel) => panel.url).toList();
    final fastestDomain = await DomainRacingService.raceSelectFastestDomain(
      domains,
      forceHttpsResult: true, // 强制返回HTTPS格式，适配SDK私有证书
    );
    
    // 如果竞速失败，回退到第一个URL
    return fastestDomain ?? domains.first;
  }

  /// 获取当前提供商所有面板的URL列表
  List<String> get currentProviderUrls {
    return currentProviderPanels.map((panel) => panel.url).toList();
  }
  
  /// 当前提供商
  String get currentProvider => _currentProvider;
  
  /// 可用的提供商列表
  List<String> get availableProviders => _panels.keys.toList();

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    _panels.forEach((provider, panels) {
      result[provider] = panels.map((panel) => panel.toJson()).toList();
    });
    return result;
  }

  @override
  String toString() {
    return 'PanelConfiguration(currentProvider: $_currentProvider, '
           'providers: ${availableProviders.join(', ')})';
  }
}