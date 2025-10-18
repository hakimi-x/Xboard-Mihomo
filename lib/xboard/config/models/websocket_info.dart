import 'config_entry.dart';

/// WebSocket信息
/// 
/// 扩展ConfigEntry，添加WebSocket特有的属性
class WebSocketInfo extends ConfigEntry {
  final Map<String, String>? headers;
  final Duration? timeout;
  final String? region;
  final bool supportsPing;

  const WebSocketInfo({
    required String url,
    required String description,
    this.headers,
    this.timeout,
    this.region,
    this.supportsPing = true,
    Map<String, dynamic>? metadata,
  }) : super(url: url, description: description, metadata: metadata);

  /// 从JSON创建WebSocket信息
  factory WebSocketInfo.fromJson(Map<String, dynamic> json) {
    final headersData = json['headers'] as Map<String, dynamic>?;
    final timeoutMs = json['timeout'] as int?;
    
    return WebSocketInfo(
      url: json['url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      headers: headersData?.cast<String, String>(),
      timeout: timeoutMs != null ? Duration(milliseconds: timeoutMs) : null,
      region: json['region'] as String?,
      supportsPing: json['supportsPing'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      if (headers != null) 'headers': headers,
      if (timeout != null) 'timeout': timeout!.inMilliseconds,
      if (region != null) 'region': region,
      'supportsPing': supportsPing,
    });
    return json;
  }

  /// 检查是否为安全WebSocket连接
  bool get isSecure => url.startsWith('wss://');

  /// 获取WebSocket协议版本
  String get protocol => isSecure ? 'wss' : 'ws';

  @override
  String toString() {
    return 'WebSocketInfo(url: $url, protocol: $protocol, region: $region)';
  }
}