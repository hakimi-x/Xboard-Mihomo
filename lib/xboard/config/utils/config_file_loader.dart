import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';
import '../core/config_settings.dart';
import '../../core/core.dart';

/// 配置文件加载器
/// 
/// 从 assets/config/xboard.config.yaml 加载 XBoard 配置
class ConfigFileLoader {
  /// 配置文件路径
  static const String configPath = 'assets/config/xboard.config.yaml';
  
  /// 加载配置文件
  /// 
  /// 从 assets/config/xboard.config.yaml 加载配置
  static Future<ConfigSettings> loadFromFile() async {
    try {
      final yamlString = await rootBundle.loadString(configPath);
      final config = _parseYamlString(yamlString);
      XBoardLogger.info('从 assets 加载配置: $configPath');
      return config;
    } catch (e) {
      XBoardLogger.error('加载配置文件失败', e);
      return const ConfigSettings();
    }
  }
  
  /// 解析 YAML 配置字符串
  static ConfigSettings _parseYamlString(String yamlString) {
    try {
      // 解析 YAML
      final yamlDoc = loadYaml(yamlString);
      final configMap = _yamlToMap(yamlDoc);
      
      // 获取 xboard 配置节点
      final xboardConfig = configMap['xboard'] as Map<String, dynamic>? ?? {};
      
      // 提取配置参数
      final provider = xboardConfig['provider'] as String? ?? 'Flclash';
      final remoteConfigJson = xboardConfig['remote_config'] as Map<String, dynamic>? ?? {};
      final subscriptionJson = xboardConfig['subscription'] as Map<String, dynamic>? ?? {};
      final logJson = xboardConfig['log'] as Map<String, dynamic>? ?? {};
      
      // 构建配置对象
      return ConfigSettings(
        currentProvider: provider,
        remoteConfig: _parseRemoteConfig(remoteConfigJson),
        subscription: _parseSubscriptionSettings(subscriptionJson),
        log: _parseLogSettings(logJson),
      );
    } catch (e) {
      XBoardLogger.error('解析 YAML 配置失败', e);
      rethrow;
    }
  }
  
  /// 将 YAML 转换为 Map（或其他类型）
  static dynamic _yamlToMap(dynamic yaml) {
    if (yaml is YamlMap) {
      final map = <String, dynamic>{};
      yaml.forEach((key, value) {
        map[key.toString()] = _yamlToMap(value);
      });
      return map;
    } else if (yaml is YamlList) {
      return yaml.map((item) => _yamlToMap(item)).toList();
    } else {
      return yaml;
    }
  }
  
  /// 解析远程配置
  static RemoteConfigSettings _parseRemoteConfig(Map<String, dynamic> json) {
    final sourcesList = json['sources'] as List<dynamic>? ?? [];
    XBoardLogger.info('[ConfigLoader] 解析远程配置源: ${sourcesList.length} 个源');
    
    final sources = sourcesList
        .map((item) => _parseRemoteSource(item as Map<String, dynamic>))
        .toList();
    
    XBoardLogger.info('[ConfigLoader] 成功解析 ${sources.length} 个配置源');
    for (final source in sources) {
      XBoardLogger.info('[ConfigLoader] - ${source.name}: ${source.url}');
    }
    
    return RemoteConfigSettings(
      sources: sources,
      maxRetries: json['max_retries'] as int? ?? 3,
      timeout: Duration(seconds: json['timeout_seconds'] as int? ?? 10),
      retryDelay: Duration(seconds: json['retry_delay_seconds'] as int? ?? 2),
    );
  }
  
  /// 解析远程源配置
  static RemoteSourceConfig _parseRemoteSource(Map<String, dynamic> json) {
    return RemoteSourceConfig(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
      headers: (json['headers'] as Map<String, dynamic>?)?.cast<String, String>(),
      timeout: json['timeout_seconds'] != null 
          ? Duration(seconds: json['timeout_seconds'] as int)
          : null,
      encryptionKey: json['encryption_key'] as String?,
    );
  }
  
  /// 解析订阅设置
  static SubscriptionSettings _parseSubscriptionSettings(Map<String, dynamic> json) {
    return SubscriptionSettings(
      preferEncrypt: json['prefer_encrypt'] as bool? ?? true,
    );
  }
  
  /// 解析日志设置
  static LogSettings _parseLogSettings(Map<String, dynamic> json) {
    return LogSettings(
      enabled: json['enabled'] as bool? ?? true,
      level: json['level'] as String? ?? 'info',
      prefix: json['prefix'] as String? ?? '[XBoard]',
    );
  }
  
  /// 获取配置文件的其他配置项
  /// 
  /// 从 assets/config/xboard.config.yaml 加载扩展配置
  static Future<Map<String, dynamic>> loadExtendedConfig() async {
    try {
      final yamlString = await rootBundle.loadString(configPath);
      final yamlDoc = loadYaml(yamlString);
      final configMap = _yamlToMap(yamlDoc);
      
      return configMap['xboard'] as Map<String, dynamic>? ?? {};
    } catch (e) {
      XBoardLogger.error('加载扩展配置失败', e);
      return {};
    }
  }
}

/// 配置辅助函数
extension ConfigFileLoaderHelper on ConfigFileLoader {
  /// 获取订阅设置
  static Future<SubscriptionSettings> getSubscriptionSettings() async {
    try {
      final config = await ConfigFileLoader.loadExtendedConfig();
      final subscriptionJson = config['subscription'] as Map<String, dynamic>? ?? {};
      return SubscriptionSettings(
        preferEncrypt: subscriptionJson['prefer_encrypt'] as bool? ?? true,
      );
    } catch (e) {
      return const SubscriptionSettings();
    }
  }
  
  /// 获取是否优先使用加密订阅
  static Future<bool> getPreferEncrypt() async {
    try {
      final settings = await getSubscriptionSettings();
      return settings.preferEncrypt;
    } catch (e) {
      return true;
    }
  }
  
  /// 获取是否启用订阅URL竞速（自动跟随加密选项）
  static Future<bool> getEnableRace() async {
    try {
      final settings = await getSubscriptionSettings();
      return settings.enableRace; // enableRace 是计算属性，等于 preferEncrypt
    } catch (e) {
      return true;
    }
  }
  
  /// 获取延迟测试配置
  static Future<String> getLatencyTestUrl() async {
    try {
      final config = await ConfigFileLoader.loadExtendedConfig();
      final latencyTest = config['latency_test'] as Map<String, dynamic>? ?? {};
      return latencyTest['test_url'] as String? ?? 'http://www.gstatic.com/generate_204';
    } catch (e) {
      return 'http://www.gstatic.com/generate_204';
    }
  }
  
  /// 获取域名服务配置
  static Future<Map<String, dynamic>> getDomainServiceConfig() async {
    try {
      final config = await ConfigFileLoader.loadExtendedConfig();
      return config['domain_service'] as Map<String, dynamic>? ?? {};
    } catch (e) {
      return {};
    }
  }
  
  /// 获取 SDK 配置
  static Future<Map<String, dynamic>> getSdkConfig() async {
    try {
      final config = await ConfigFileLoader.loadExtendedConfig();
      return config['sdk'] as Map<String, dynamic>? ?? {};
    } catch (e) {
      return {};
    }
  }
  
  /// 获取应用配置
  static Future<Map<String, dynamic>> getAppConfig() async {
    try {
      final config = await ConfigFileLoader.loadExtendedConfig();
      return config['app'] as Map<String, dynamic>? ?? {};
    } catch (e) {
      return {};
    }
  }
  
  /// 获取安全配置
  static Future<Map<String, dynamic>> getSecurityConfig() async {
    try {
      final config = await ConfigFileLoader.loadExtendedConfig();
      return config['security'] as Map<String, dynamic>? ?? {};
    } catch (e) {
      return {};
    }
  }
  
  /// 获取解密密钥
  static Future<String> getDecryptKey() async {
    try {
      final security = await getSecurityConfig();
      return security['decrypt_key'] as String? ?? 'xboard_default_key_2024';
    } catch (e) {
      return 'xboard_default_key_2024';
    }
  }
  
  /// 获取 User-Agent 配置
  static Future<Map<String, String>> getUserAgents() async {
    try {
      final security = await getSecurityConfig();
      final userAgents = security['user_agents'] as Map<String, dynamic>? ?? {};
      return userAgents.cast<String, String>();
    } catch (e) {
      return {};
    }
  }
  
  /// 获取证书配置
  static Future<Map<String, dynamic>> getCertificateConfig() async {
    try {
      final security = await getSecurityConfig();
      return security['certificate'] as Map<String, dynamic>? ?? {};
    } catch (e) {
      return {};
    }
  }
  
  /// 获取应用标题
  static Future<String> getAppTitle() async {
    try {
      final app = await getAppConfig();
      return app['title'] as String? ?? 'XBoard';
    } catch (e) {
      return 'XBoard';
    }
  }
  
  /// 获取应用网站地址
  static Future<String> getAppWebsite() async {
    try {
      final app = await getAppConfig();
      return app['website'] as String? ?? 'example.com';
    } catch (e) {
      return 'example.com';
    }
  }
  
  /// 获取混淆前缀字符串
  /// 
  /// 返回配置文件中的混淆前缀，如果未配置或配置为 null 则返回 null
  /// 用于 Caddy 反代等场景的响应反混淆
  /// SDK 会自动检测响应是否包含此前缀，有则反混淆，无则直接解析
  static Future<String?> getObfuscationPrefix() async {
    try {
      final security = await getSecurityConfig();
      final prefix = security['obfuscation_prefix'];
      
      // 如果配置为空字符串或 null，返回 null
      if (prefix == null || (prefix is String && prefix.isEmpty)) {
        return null;
      }
      
      return prefix as String;
    } catch (e) {
      XBoardLogger.warning('获取混淆前缀失败: $e');
      return null;
    }
  }
}

