import 'config_entry.dart';

/// 订阅端点信息
class SubscriptionEndpoint {
  final String path;
  final bool requiresToken;
  final String method;
  final String description;
  final bool isEncrypt; // 是否为加密接口

  const SubscriptionEndpoint({
    required this.path,
    required this.requiresToken,
    required this.method,
    required this.description,
    this.isEncrypt = false,
  });

  /// 从JSON创建端点信息
  factory SubscriptionEndpoint.fromJson(Map<String, dynamic> json) {
    return SubscriptionEndpoint(
      path: json['path'] as String? ?? '',
      requiresToken: json['requiresToken'] as bool? ?? false,
      method: json['method'] as String? ?? 'GET',
      description: json['description'] as String? ?? '',
      isEncrypt: json['isEncrypt'] as bool? ?? false,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'requiresToken': requiresToken,
      'method': method,
      'description': description,
      'isEncrypt': isEncrypt,
    };
  }

  @override
  String toString() {
    return 'SubscriptionEndpoint(path: $path, method: $method, encrypt: $isEncrypt)';
  }
}

/// 订阅URL信息
class SubscriptionUrlInfo extends ConfigEntry {
  final Map<String, SubscriptionEndpoint> endpoints;
  final bool supportEncrypt; // 是否支持加密订阅

  const SubscriptionUrlInfo({
    required super.url,
    required super.description,
    required this.endpoints,
    this.supportEncrypt = false,
  });

  /// 从JSON创建订阅URL信息
  factory SubscriptionUrlInfo.fromJson(Map<String, dynamic> json) {
    final endpointsMap = <String, SubscriptionEndpoint>{};
    final endpointsJson = json['endpoints'] as Map<String, dynamic>? ?? {};
    
    endpointsJson.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        endpointsMap[key] = SubscriptionEndpoint.fromJson(value);
      }
    });

    return SubscriptionUrlInfo(
      url: json['url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      endpoints: endpointsMap,
      supportEncrypt: json['supportEncrypt'] as bool? ?? false,
    );
  }

  /// 获取加密端点
  SubscriptionEndpoint? get encryptEndpoint {
    try {
      return endpoints.values.firstWhere((endpoint) => endpoint.isEncrypt);
    } catch (e) {
      return endpoints['v2'] ?? (endpoints.isNotEmpty ? endpoints.values.first : null);
    }
  }

  /// 获取普通端点
  SubscriptionEndpoint? get normalEndpoint {
    try {
      return endpoints.values.firstWhere((endpoint) => !endpoint.isEncrypt);
    } catch (e) {
      return endpoints['v1'] ?? (endpoints.isNotEmpty ? endpoints.values.first : null);
    }
  }

  /// 获取首选端点（优先加密）
  SubscriptionEndpoint? get preferredEndpoint {
    return encryptEndpoint ?? normalEndpoint;
  }

  /// 构建完整的订阅URL
  String buildSubscriptionUrl(String token, {bool preferEncrypt = true}) {
    final endpoint = preferEncrypt ? encryptEndpoint : normalEndpoint;
    if (endpoint == null) return url;

    final path = endpoint.path.replaceAll('{token}', token);
    final baseUrl = url.endsWith('/') ? '$url${path.startsWith('/') ? path.substring(1) : path}'
                                      : '$url${path.startsWith('/') ? path : '/$path'}';

    // 添加 FlClash 标识参数
    final separator = baseUrl.contains('?') ? '&' : '?';
    return '$baseUrl${separator}flag=flclash';
  }

  @override
  Map<String, dynamic> toJson() {
    final result = super.toJson();
    result.addAll({
      'endpoints': endpoints.map((key, value) => MapEntry(key, value.toJson())),
      'supportEncrypt': supportEncrypt,
    });
    return result;
  }

  @override
  String toString() {
    return 'SubscriptionUrlInfo(url: $url, encrypt: $supportEncrypt, endpoints: ${endpoints.length})';
  }
}

/// 订阅配置信息
class SubscriptionInfo {
  final List<SubscriptionUrlInfo> urls;
  final bool enableEncrypt; // 是否启用加密订阅
  final String preferredEncryptVersion; // 首选加密版本

  const SubscriptionInfo({
    required this.urls,
    this.enableEncrypt = true,
    this.preferredEncryptVersion = 'v2',
  });

  /// 从JSON创建订阅配置
  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) {
    final urlsList = json['urls'] as List<dynamic>? ?? [];
    
    return SubscriptionInfo(
      urls: urlsList
          .map((item) => SubscriptionUrlInfo.fromJson(item as Map<String, dynamic>))
          .toList(),
      enableEncrypt: json['enableEncrypt'] as bool? ?? true,
      preferredEncryptVersion: json['preferredEncryptVersion'] as String? ?? 'v2',
    );
  }

  /// 获取第一个可用的订阅URL
  String? get firstUrl {
    return urls.isNotEmpty ? urls.first.url : null;
  }

  /// 获取第一个支持加密的URL
  SubscriptionUrlInfo? get firstEncryptUrl {
    try {
      return urls.firstWhere((url) => url.supportEncrypt);
    } catch (e) {
      return urls.isNotEmpty ? urls.first : null;
    }
  }

  /// 获取所有支持加密的URL
  List<SubscriptionUrlInfo> get encryptUrls {
    return urls.where((url) => url.supportEncrypt).toList();
  }

  /// 构建订阅URL（优先使用加密）
  String? buildSubscriptionUrl(String token, {bool forceEncrypt = false}) {
    if (urls.isEmpty) return null;

    final targetUrl = forceEncrypt || enableEncrypt 
        ? firstEncryptUrl ?? urls.first
        : urls.first;

    return targetUrl.buildSubscriptionUrl(token, preferEncrypt: enableEncrypt);
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'urls': urls.map((url) => url.toJson()).toList(),
      'enableEncrypt': enableEncrypt,
      'preferredEncryptVersion': preferredEncryptVersion,
    };
  }

  @override
  String toString() {
    return 'SubscriptionInfo(urls: ${urls.length}, encrypt: $enableEncrypt)';
  }
}