// Domain Service 配置类
// 
// 为各个服务提供统一的配置管理

/// 认证服务配置
class AuthServiceConfig {
  final Duration sessionTimeout;
  final int maxRetries;
  final bool enableAutoLogin;
  final Duration requestTimeout;
  
  const AuthServiceConfig({
    this.sessionTimeout = const Duration(hours: 24),
    this.maxRetries = 3,
    this.enableAutoLogin = true,
    this.requestTimeout = const Duration(seconds: 30),
  });
  
  Map<String, dynamic> toMap() {
    return {
      'session_timeout': sessionTimeout.inMilliseconds,
      'max_retries': maxRetries,
      'enable_auto_login': enableAutoLogin,
      'request_timeout': requestTimeout.inMilliseconds,
    };
  }
  
  factory AuthServiceConfig.fromMap(Map<String, dynamic> map) {
    return AuthServiceConfig(
      sessionTimeout: Duration(milliseconds: map['session_timeout'] ?? 86400000),
      maxRetries: map['max_retries'] ?? 3,
      enableAutoLogin: map['enable_auto_login'] ?? true,
      requestTimeout: Duration(milliseconds: map['request_timeout'] ?? 30000),
    );
  }
}

/// 用户服务配置
class UserServiceConfig {
  final Duration cacheTimeout;
  final int maxRetries;
  final bool enableCache;
  
  const UserServiceConfig({
    this.cacheTimeout = const Duration(minutes: 5),
    this.maxRetries = 3,
    this.enableCache = true,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'cache_timeout': cacheTimeout.inMilliseconds,
      'max_retries': maxRetries,
      'enable_cache': enableCache,
    };
  }
  
  factory UserServiceConfig.fromMap(Map<String, dynamic> map) {
    return UserServiceConfig(
      cacheTimeout: Duration(milliseconds: map['cache_timeout'] ?? 300000),
      maxRetries: map['max_retries'] ?? 3,
      enableCache: map['enable_cache'] ?? true,
    );
  }
}

/// 订阅服务配置
class SubscriptionServiceConfig {
  final Duration refreshInterval;
  final int maxRetries;
  final bool autoRefresh;
  
  const SubscriptionServiceConfig({
    this.refreshInterval = const Duration(minutes: 10),
    this.maxRetries = 3,
    this.autoRefresh = true,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'refresh_interval': refreshInterval.inMilliseconds,
      'max_retries': maxRetries,
      'auto_refresh': autoRefresh,
    };
  }
  
  factory SubscriptionServiceConfig.fromMap(Map<String, dynamic> map) {
    return SubscriptionServiceConfig(
      refreshInterval: Duration(milliseconds: map['refresh_interval'] ?? 600000),
      maxRetries: map['max_retries'] ?? 3,
      autoRefresh: map['auto_refresh'] ?? true,
    );
  }
}

/// 支付服务配置
class PaymentServiceConfig {
  final Duration paymentTimeout;
  final int maxRetries;
  final bool enableRetry;
  
  const PaymentServiceConfig({
    this.paymentTimeout = const Duration(minutes: 5),
    this.maxRetries = 2,
    this.enableRetry = true,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'payment_timeout': paymentTimeout.inMilliseconds,
      'max_retries': maxRetries,
      'enable_retry': enableRetry,
    };
  }
  
  factory PaymentServiceConfig.fromMap(Map<String, dynamic> map) {
    return PaymentServiceConfig(
      paymentTimeout: Duration(milliseconds: map['payment_timeout'] ?? 300000),
      maxRetries: map['max_retries'] ?? 2,
      enableRetry: map['enable_retry'] ?? true,
    );
  }
}

/// 系统服务配置
class SystemServiceConfig {
  final Duration configCacheTimeout;
  final int maxRetries;
  final bool enableConfigCache;
  
  const SystemServiceConfig({
    this.configCacheTimeout = const Duration(hours: 1),
    this.maxRetries = 3,
    this.enableConfigCache = true,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'config_cache_timeout': configCacheTimeout.inMilliseconds,
      'max_retries': maxRetries,
      'enable_config_cache': enableConfigCache,
    };
  }
  
  factory SystemServiceConfig.fromMap(Map<String, dynamic> map) {
    return SystemServiceConfig(
      configCacheTimeout: Duration(milliseconds: map['config_cache_timeout'] ?? 3600000),
      maxRetries: map['max_retries'] ?? 3,
      enableConfigCache: map['enable_config_cache'] ?? true,
    );
  }
}

/// 支持服务配置
class SupportServiceConfig {
  final Duration requestTimeout;
  final int maxRetries;
  final bool enableNotifications;
  
  const SupportServiceConfig({
    this.requestTimeout = const Duration(seconds: 45),
    this.maxRetries = 3,
    this.enableNotifications = true,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'request_timeout': requestTimeout.inMilliseconds,
      'max_retries': maxRetries,
      'enable_notifications': enableNotifications,
    };
  }
  
  factory SupportServiceConfig.fromMap(Map<String, dynamic> map) {
    return SupportServiceConfig(
      requestTimeout: Duration(milliseconds: map['request_timeout'] ?? 45000),
      maxRetries: map['max_retries'] ?? 3,
      enableNotifications: map['enable_notifications'] ?? true,
    );
  }
}

/// 邀请服务配置
class InviteServiceConfig {
  final Duration cacheTimeout;
  final int maxRetries;
  final bool enableCache;
  
  const InviteServiceConfig({
    this.cacheTimeout = const Duration(minutes: 15),
    this.maxRetries = 3,
    this.enableCache = true,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'cache_timeout': cacheTimeout.inMilliseconds,
      'max_retries': maxRetries,
      'enable_cache': enableCache,
    };
  }
  
  factory InviteServiceConfig.fromMap(Map<String, dynamic> map) {
    return InviteServiceConfig(
      cacheTimeout: Duration(milliseconds: map['cache_timeout'] ?? 900000),
      maxRetries: map['max_retries'] ?? 3,
      enableCache: map['enable_cache'] ?? true,
    );
  }
}