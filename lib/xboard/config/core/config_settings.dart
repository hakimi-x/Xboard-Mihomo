/// 配置设置
/// 
/// 包含模块的各种配置参数
class ConfigSettings {
  final String currentProvider;
  final RemoteConfigSettings remoteConfig;
  final SubscriptionSettings subscription;
  final LogSettings log;

  const ConfigSettings({
    this.currentProvider = 'Flclash',
    this.remoteConfig = const RemoteConfigSettings(),
    this.subscription = const SubscriptionSettings(),
    this.log = const LogSettings(),
  });

  /// 从JSON创建配置
  factory ConfigSettings.fromJson(Map<String, dynamic> json) {
    return ConfigSettings(
      currentProvider: json['currentProvider'] as String? ?? 'Flclash',
      remoteConfig: RemoteConfigSettings.fromJson(
        json['remoteConfig'] as Map<String, dynamic>? ?? {}
      ),
      subscription: SubscriptionSettings.fromJson(
        json['subscription'] as Map<String, dynamic>? ?? {}
      ),
      log: LogSettings.fromJson(
        json['log'] as Map<String, dynamic>? ?? {}
      ),
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'currentProvider': currentProvider,
      'remoteConfig': remoteConfig.toJson(),
      'subscription': subscription.toJson(),
      'log': log.toJson(),
    };
  }

  /// 验证配置
  bool validate() {
    // 移除 provider 硬编码限制，允许使用任意 provider
    // 只要远程配置 JSON 中有对应的键名即可
    return remoteConfig.validate() && subscription.validate() && log.validate();
  }

  /// 获取验证错误
  List<String> getValidationErrors() {
    final errors = <String>[];

    // 移除 provider 硬编码限制
    // provider 仅作为 key 从远程配置的 panels 对象中选择数据

    errors.addAll(remoteConfig.getValidationErrors());
    errors.addAll(subscription.getValidationErrors());
    errors.addAll(log.getValidationErrors());

    return errors;
  }

  @override
  String toString() {
    return 'ConfigSettings(provider: $currentProvider, subscription: $subscription)';
  }
}

/// 远程配置设置
class RemoteConfigSettings {
  final List<RemoteSourceConfig> sources;
  final int maxRetries;
  final Duration timeout;
  final Duration retryDelay;

  const RemoteConfigSettings({
    this.sources = const [],
    this.maxRetries = 3,
    this.timeout = const Duration(seconds: 10),
    this.retryDelay = const Duration(seconds: 2),
  });

  factory RemoteConfigSettings.fromJson(Map<String, dynamic> json) {
    final sourcesList = json['sources'] as List<dynamic>? ?? [];
    final sources = sourcesList
        .map((item) => RemoteSourceConfig.fromJson(item as Map<String, dynamic>))
        .toList();

    return RemoteConfigSettings(
      sources: sources,
      maxRetries: json['maxRetries'] as int? ?? 3,
      timeout: Duration(seconds: json['timeoutSeconds'] as int? ?? 10),
      retryDelay: Duration(seconds: json['retryDelaySeconds'] as int? ?? 2),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sources': sources.map((s) => s.toJson()).toList(),
      'maxRetries': maxRetries,
      'timeoutSeconds': timeout.inSeconds,
      'retryDelaySeconds': retryDelay.inSeconds,
    };
  }

  bool validate() {
    return sources.isNotEmpty && 
           maxRetries > 0 && 
           timeout.inSeconds > 0 && 
           retryDelay.inSeconds >= 0;
  }

  List<String> getValidationErrors() {
    final errors = <String>[];

    if (sources.isEmpty) {
      errors.add('Remote config sources cannot be empty');
    }

    if (maxRetries <= 0) {
      errors.add('Max retries must be greater than 0');
    }

    if (timeout.inSeconds <= 0) {
      errors.add('Timeout must be greater than 0');
    }

    for (int i = 0; i < sources.length; i++) {
      final sourceErrors = sources[i].getValidationErrors();
      errors.addAll(sourceErrors.map((e) => 'sources[$i]: $e'));
    }

    return errors;
  }
}

/// 远程源配置
class RemoteSourceConfig {
  final String name;
  final String url;
  final Map<String, String>? headers;
  final Duration? timeout;
  final String? encryptionKey; // 加密密钥（用于gitee源）

  const RemoteSourceConfig({
    required this.name,
    required this.url,
    this.headers,
    this.timeout,
    this.encryptionKey,
  });

  factory RemoteSourceConfig.fromJson(Map<String, dynamic> json) {
    final headersData = json['headers'] as Map<String, dynamic>?;
    final timeoutSeconds = json['timeoutSeconds'] as int?;

    return RemoteSourceConfig(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
      headers: headersData?.cast<String, String>(),
      timeout: timeoutSeconds != null ? Duration(seconds: timeoutSeconds) : null,
      encryptionKey: json['encryptionKey'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      if (headers != null) 'headers': headers,
      if (timeout != null) 'timeoutSeconds': timeout!.inSeconds,
      if (encryptionKey != null) 'encryptionKey': encryptionKey,
    };
  }

  List<String> getValidationErrors() {
    final errors = <String>[];

    if (name.isEmpty) {
      errors.add('Source name cannot be empty');
    }

    if (url.isEmpty) {
      errors.add('Source URL cannot be empty');
    } else {
      try {
        final uri = Uri.parse(url);
        if (!uri.hasScheme || !uri.host.isNotEmpty) {
          errors.add('Invalid URL format: $url');
        }
      } catch (e) {
        errors.add('Invalid URL: $url');
      }
    }

    return errors;
  }
}

/// 订阅设置
class SubscriptionSettings {
  final bool preferEncrypt;

  const SubscriptionSettings({
    this.preferEncrypt = true,
  });

  /// 是否启用竞速（自动跟随加密选项）
  bool get enableRace => preferEncrypt;

  factory SubscriptionSettings.fromJson(Map<String, dynamic> json) {
    return SubscriptionSettings(
      preferEncrypt: json['preferEncrypt'] as bool? ?? json['prefer_encrypt'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preferEncrypt': preferEncrypt,
    };
  }

  bool validate() {
    // 布尔值总是有效的
    return true;
  }

  List<String> getValidationErrors() {
    // 没有验证错误
    return [];
  }

  @override
  String toString() {
    return 'SubscriptionSettings(preferEncrypt: $preferEncrypt, enableRace: $enableRace)';
  }
}

/// 日志设置
class LogSettings {
  final bool enabled;
  final String level;
  final String prefix;

  const LogSettings({
    this.enabled = true,
    this.level = 'info',
    this.prefix = '[XBoardConfig]',
  });

  factory LogSettings.fromJson(Map<String, dynamic> json) {
    return LogSettings(
      enabled: json['enabled'] as bool? ?? true,
      level: json['level'] as String? ?? 'info',
      prefix: json['prefix'] as String? ?? '[XBoardConfig]',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'level': level,
      'prefix': prefix,
    };
  }

  bool validate() {
    const validLevels = ['debug', 'info', 'warning', 'error'];
    return validLevels.contains(level.toLowerCase()) && prefix.isNotEmpty;
  }

  List<String> getValidationErrors() {
    final errors = <String>[];

    const validLevels = ['debug', 'info', 'warning', 'error'];
    if (!validLevels.contains(level.toLowerCase())) {
      errors.add('Invalid log level: $level');
    }

    if (prefix.isEmpty) {
      errors.add('Log prefix cannot be empty');
    }

    return errors;
  }
}