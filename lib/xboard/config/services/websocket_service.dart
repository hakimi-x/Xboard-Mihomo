import '../models/websocket_info.dart';

/// WebSocket服务
/// 
/// 负责WebSocket相关的基础操作，暂不实现连接测试等内部方法
class WebSocketService {
  final List<WebSocketInfo> _webSockets;

  WebSocketService(this._webSockets);

  /// 获取所有WebSocket列表
  List<WebSocketInfo> getAllWebSockets() {
    return List.unmodifiable(_webSockets);
  }

  /// 获取第一个可用的WebSocket
  WebSocketInfo? getFirstWebSocket() {
    return _webSockets.isNotEmpty ? _webSockets.first : null;
  }

  /// 获取第一个可用的WebSocket URL
  String? getFirstWebSocketUrl() {
    final ws = getFirstWebSocket();
    return ws?.url;
  }

  /// 根据协议筛选WebSocket（ws/wss）
  List<WebSocketInfo> getWebSocketsByProtocol(String protocol) {
    return _webSockets.where((ws) => ws.protocol == protocol).toList();
  }

  /// 获取安全WebSocket连接（wss）
  List<WebSocketInfo> getSecureWebSockets() {
    return _webSockets.where((ws) => ws.isSecure).toList();
  }

  /// 获取非安全WebSocket连接（ws）
  List<WebSocketInfo> getInsecureWebSockets() {
    return _webSockets.where((ws) => !ws.isSecure).toList();
  }

  /// 根据地区筛选WebSocket
  List<WebSocketInfo> getWebSocketsByRegion(String region) {
    return _webSockets.where((ws) => ws.region == region).toList();
  }

  /// 获取支持ping的WebSocket
  List<WebSocketInfo> getPingEnabledWebSockets() {
    return _webSockets.where((ws) => ws.supportsPing).toList();
  }

  /// 获取所有可用的地区
  List<String> getAvailableRegions() {
    return _webSockets
        .where((ws) => ws.region != null)
        .map((ws) => ws.region!)
        .toSet()
        .toList();
  }

  /// 检查是否有安全连接
  bool hasSecureConnections() {
    return _webSockets.any((ws) => ws.isSecure);
  }

  /// 检查是否有指定地区的WebSocket
  bool hasRegion(String region) {
    return _webSockets.any((ws) => ws.region == region);
  }

  /// 获取WebSocket统计信息
  Map<String, dynamic> getWebSocketStats() {
    final stats = <String, dynamic>{
      'totalWebSockets': _webSockets.length,
      'secureConnections': getSecureWebSockets().length,
      'insecureConnections': getInsecureWebSockets().length,
      'pingEnabledConnections': getPingEnabledWebSockets().length,
      'regions': getAvailableRegions(),
    };

    // 按地区统计数量
    final regionCounts = <String, int>{};
    for (final region in getAvailableRegions()) {
      regionCounts[region] = getWebSocketsByRegion(region).length;
    }
    stats['regionCounts'] = regionCounts;

    // 协议分布
    stats['protocolDistribution'] = {
      'wss': getSecureWebSockets().length,
      'ws': getInsecureWebSockets().length,
    };

    return stats;
  }

  @override
  String toString() {
    return 'WebSocketService(webSockets: ${_webSockets.length}, '
           'secure: ${getSecureWebSockets().length}, '
           'insecure: ${getInsecureWebSockets().length})';
  }
}