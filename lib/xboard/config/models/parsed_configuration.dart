import 'panel_configuration.dart';
import 'proxy_info.dart';
import 'websocket_info.dart';
import 'update_info.dart';
import 'online_support_info.dart';
import 'subscription_info.dart';

/// 解析后的配置数据
/// 
/// 包含所有类型的配置信息
class ParsedConfiguration {
  final PanelConfiguration panels;
  final List<ProxyInfo> proxies;
  final List<WebSocketInfo> webSockets;
  final List<UpdateInfo> updates;
  final List<OnlineSupportInfo> onlineSupport;
  final SubscriptionInfo? subscription;
  final DateTime parsedAt;
  final String sourceHash;
  final ConfigMetadata metadata;

  const ParsedConfiguration({
    required this.panels,
    required this.proxies,
    required this.webSockets,
    required this.updates,
    required this.onlineSupport,
    this.subscription,
    required this.parsedAt,
    required this.sourceHash,
    required this.metadata,
  });

  /// 从JSON创建配置
  factory ParsedConfiguration.fromJson(
    Map<String, dynamic> json,
    String currentProvider,
  ) {
    final panelsData = json['panels'] as Map<String, dynamic>? ?? {};
    final proxyList = json['proxy'] as List<dynamic>? ?? [];
    final wsList = json['ws'] as List<dynamic>? ?? [];
    final updateList = json['update'] as List<dynamic>? ?? [];
    final onlineSupportList = json['onlineSupport'] as List<dynamic>? ?? [];
    final subscriptionData = json['subscription'] as Map<String, dynamic>?;

    return ParsedConfiguration(
      panels: PanelConfiguration.fromJson(panelsData, currentProvider),
      proxies: proxyList
          .map((item) => ProxyInfo.fromJson(item as Map<String, dynamic>))
          .toList(),
      webSockets: wsList
          .map((item) => WebSocketInfo.fromJson(item as Map<String, dynamic>))
          .toList(),
      updates: updateList
          .map((item) => UpdateInfo.fromJson(item as Map<String, dynamic>))
          .toList(),
      onlineSupport: onlineSupportList
          .map((item) => OnlineSupportInfo.fromJson(item as Map<String, dynamic>))
          .toList(),
      subscription: subscriptionData != null ? SubscriptionInfo.fromJson(subscriptionData) : null,
      parsedAt: DateTime.now(),
      sourceHash: json.hashCode.toString(),
      metadata: ConfigMetadata.fromJson(json['metadata'] as Map<String, dynamic>? ?? {}),
    );
  }

  /// 获取第一个可用的WebSocket URL
  String? get firstWsUrl {
    return webSockets.isNotEmpty ? webSockets.first.url : null;
  }

  /// 获取第一个可用的代理URL
  String? get firstProxyUrl {
    return proxies.isNotEmpty ? proxies.first.url : null;
  }

  /// 获取第一个可用的面板URL
  String? get firstPanelUrl {
    return panels.firstUrl;
  }

  /// 获取第一个可用的更新URL
  String? get firstUpdateUrl {
    return updates.isNotEmpty ? updates.first.url : null;
  }

  /// 获取第一个可用的在线客服API URL
  String? get firstOnlineSupportApiUrl {
    return onlineSupport.isNotEmpty ? onlineSupport.first.apiBaseUrl : null;
  }

  /// 获取第一个可用的在线客服WebSocket URL
  String? get firstOnlineSupportWsUrl {
    return onlineSupport.isNotEmpty ? onlineSupport.first.wsBaseUrl : null;
  }

  /// 获取第一个可用的订阅URL
  String? get firstSubscriptionUrl {
    return subscription?.firstUrl;
  }

  /// 获取第一个支持加密的订阅URL
  String? get firstEncryptSubscriptionUrl {
    return subscription?.firstEncryptUrl?.url;
  }

  /// 构建订阅URL
  String? buildSubscriptionUrl(String token, {bool preferEncrypt = true}) {
    return subscription?.buildSubscriptionUrl(token, forceEncrypt: preferEncrypt);
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'panels': panels.toJson(),
      'proxy': proxies.map((e) => e.toJson()).toList(),
      'ws': webSockets.map((e) => e.toJson()).toList(),
      'update': updates.map((e) => e.toJson()).toList(),
      'onlineSupport': onlineSupport.map((e) => e.toJson()).toList(),
      if (subscription != null) 'subscription': subscription!.toJson(),
      'parsedAt': parsedAt.toIso8601String(),
      'sourceHash': sourceHash,
      'metadata': metadata.toJson(),
    };
  }

  @override
  String toString() {
    return 'ParsedConfiguration(panels: $panels, proxies: ${proxies.length}, '
           'ws: ${webSockets.length}, updates: ${updates.length}, '
           'onlineSupport: ${onlineSupport.length}, '
           'subscription: ${subscription != null ? subscription!.urls.length : 0})';
  }
}

/// 配置元数据
class ConfigMetadata {
  final List<String> sources;
  final DateTime lastUpdated;
  final String version;
  final Map<String, dynamic> statistics;

  const ConfigMetadata({
    required this.sources,
    required this.lastUpdated,
    required this.version,
    required this.statistics,
  });

  factory ConfigMetadata.fromJson(Map<String, dynamic> json) {
    return ConfigMetadata(
      sources: (json['sources'] as List<dynamic>?)?.cast<String>() ?? [],
      lastUpdated: DateTime.tryParse(json['lastUpdated'] as String? ?? '') ?? DateTime.now(),
      version: json['version'] as String? ?? '1.0.0',
      statistics: json['statistics'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sources': sources,
      'lastUpdated': lastUpdated.toIso8601String(),
      'version': version,
      'statistics': statistics,
    };
  }
}