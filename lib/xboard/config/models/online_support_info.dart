import 'config_entry.dart';

/// 在线客服信息
/// 
/// 扩展ConfigEntry，添加在线客服特有的属性
class OnlineSupportInfo extends ConfigEntry {
  final String apiBaseUrl;
  final String wsBaseUrl;

  const OnlineSupportInfo({
    required String url,
    required String description,
    required this.apiBaseUrl,
    required this.wsBaseUrl,
    Map<String, dynamic>? metadata,
  }) : super(url: url, description: description, metadata: metadata);

  /// 从JSON创建在线客服信息
  factory OnlineSupportInfo.fromJson(Map<String, dynamic> json) {
    return OnlineSupportInfo(
      url: json['url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      apiBaseUrl: json['apiBaseUrl'] as String? ?? '',
      wsBaseUrl: json['wsBaseUrl'] as String? ?? '',
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'apiBaseUrl': apiBaseUrl,
      'wsBaseUrl': wsBaseUrl,
    });
    return json;
  }

  /// 验证URL格式
  bool validate() {
    return _isValidUrl(apiBaseUrl) && _isValidUrl(wsBaseUrl) && 
           _isValidHttpUrl(apiBaseUrl) && _isValidWebSocketUrl(wsBaseUrl);
  }

  /// 获取验证错误信息
  List<String> getValidationErrors() {
    final errors = <String>[];

    if (apiBaseUrl.isEmpty) {
      errors.add('API base URL cannot be empty');
    } else if (!_isValidUrl(apiBaseUrl)) {
      errors.add('Invalid API base URL format: $apiBaseUrl');
    } else if (!_isValidHttpUrl(apiBaseUrl)) {
      errors.add('API base URL must use http or https protocol: $apiBaseUrl');
    }

    if (wsBaseUrl.isEmpty) {
      errors.add('WebSocket base URL cannot be empty');
    } else if (!_isValidUrl(wsBaseUrl)) {
      errors.add('Invalid WebSocket base URL format: $wsBaseUrl');
    } else if (!_isValidWebSocketUrl(wsBaseUrl)) {
      errors.add('WebSocket base URL must use ws or wss protocol: $wsBaseUrl');
    }

    return errors;
  }

  /// 检查是否为有效URL
  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// 检查是否为有效的HTTP URL
  bool _isValidHttpUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.scheme == 'http' || uri.scheme == 'https';
    } catch (e) {
      return false;
    }
  }

  /// 检查是否为有效的WebSocket URL
  bool _isValidWebSocketUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.scheme == 'ws' || uri.scheme == 'wss';
    } catch (e) {
      return false;
    }
  }

  @override
  String toString() {
    return 'OnlineSupportInfo(apiBaseUrl: $apiBaseUrl, wsBaseUrl: $wsBaseUrl)';
  }
}