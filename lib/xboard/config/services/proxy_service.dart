import '../models/proxy_info.dart';

/// 代理服务
/// 
/// 负责代理相关的基础操作，暂不实现连通性测试等内部方法
class ProxyService {
  final List<ProxyInfo> _proxies;

  ProxyService(this._proxies);

  /// 获取所有代理列表
  List<ProxyInfo> getAllProxies() {
    return List.unmodifiable(_proxies);
  }

  /// 获取第一个可用的代理
  ProxyInfo? getFirstProxy() {
    return _proxies.isNotEmpty ? _proxies.first : null;
  }

  /// 获取第一个可用的代理URL
  String? getFirstProxyUrl() {
    final proxy = getFirstProxy();
    return proxy?.url;
  }

  /// 根据协议筛选代理
  List<ProxyInfo> getProxiesByProtocol(String protocol) {
    return _proxies.where((proxy) => proxy.protocol == protocol).toList();
  }

  /// 根据地区筛选代理
  List<ProxyInfo> getProxiesByRegion(String region) {
    return _proxies.where((proxy) => proxy.region == region).toList();
  }

  /// 获取所有可用的协议类型
  List<String> getAvailableProtocols() {
    return _proxies.map((proxy) => proxy.protocol).toSet().toList();
  }

  /// 获取所有可用的地区
  List<String> getAvailableRegions() {
    return _proxies
        .where((proxy) => proxy.region != null)
        .map((proxy) => proxy.region!)
        .toSet()
        .toList();
  }

  /// 检查是否有指定协议的代理
  bool hasProtocol(String protocol) {
    return _proxies.any((proxy) => proxy.protocol == protocol);
  }

  /// 检查是否有指定地区的代理
  bool hasRegion(String region) {
    return _proxies.any((proxy) => proxy.region == region);
  }

  /// 获取代理统计信息
  Map<String, dynamic> getProxyStats() {
    final stats = <String, dynamic>{
      'totalProxies': _proxies.length,
      'protocols': getAvailableProtocols(),
      'regions': getAvailableRegions(),
    };

    // 按协议统计数量
    final protocolCounts = <String, int>{};
    for (final protocol in getAvailableProtocols()) {
      protocolCounts[protocol] = getProxiesByProtocol(protocol).length;
    }
    stats['protocolCounts'] = protocolCounts;

    // 按地区统计数量
    final regionCounts = <String, int>{};
    for (final region in getAvailableRegions()) {
      regionCounts[region] = getProxiesByRegion(region).length;
    }
    stats['regionCounts'] = regionCounts;

    return stats;
  }

  @override
  String toString() {
    return 'ProxyService(proxies: ${_proxies.length}, '
           'protocols: ${getAvailableProtocols().join(', ')})';
  }
}