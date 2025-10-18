import 'config_entry.dart';

/// 代理信息
/// 
/// 扩展ConfigEntry，添加代理特有的属性
class ProxyInfo extends ConfigEntry {
  final String protocol; // http, socks5, etc.
  final String? username;
  final String? password;
  final String? host;
  final int? port;
  final String? region;

  const ProxyInfo({
    required String url,
    required String description,
    required this.protocol,
    this.username,
    this.password,
    this.host,
    this.port,
    this.region,
    Map<String, dynamic>? metadata,
  }) : super(url: url, description: description, metadata: metadata);

  /// 从JSON创建代理信息
  factory ProxyInfo.fromJson(Map<String, dynamic> json) {
    return ProxyInfo(
      url: json['url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      protocol: json['protocol'] as String? ?? 'http',
      username: json['username'] as String?,
      password: json['password'] as String?,
      host: json['host'] as String?,
      port: json['port'] as int?,
      region: json['region'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  /// 从代理URL解析创建（格式：username:password@host:port）
  factory ProxyInfo.fromUrl(String url, String description) {
    try {
      // 解析代理URL格式：protocol://username:password@host:port
      final uri = Uri.parse(url.contains('://') ? url : 'http://$url');
      
      return ProxyInfo(
        url: url,
        description: description,
        protocol: uri.scheme.isNotEmpty ? uri.scheme : 'http',
        username: uri.userInfo.isNotEmpty ? uri.userInfo.split(':').first : null,
        password: uri.userInfo.contains(':') ? uri.userInfo.split(':').last : null,
        host: uri.host,
        port: uri.port != 0 ? uri.port : null,
      );
    } catch (e) {
      // 如果解析失败，返回基本信息
      return ProxyInfo(
        url: url,
        description: description,
        protocol: 'http',
      );
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'protocol': protocol,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (host != null) 'host': host,
      if (port != null) 'port': port,
      if (region != null) 'region': region,
    });
    return json;
  }

  @override
  String toString() {
    return 'ProxyInfo(url: $url, protocol: $protocol, host: $host, port: $port)';
  }
}