import '../models/parsed_configuration.dart';

/// 配置解析异常
class ConfigurationParseException implements Exception {
  final String message;
  final dynamic originalError;

  const ConfigurationParseException(this.message, [this.originalError]);

  @override
  String toString() {
    return 'ConfigurationParseException: $message';
  }
}

/// 验证错误类型
enum ValidationErrorType {
  missingField,
  invalidType,
  invalidFormat,
  invalidValue,
}

/// 验证错误
class ValidationError {
  final String field;
  final String message;
  final ValidationErrorType type;

  const ValidationError({
    required this.field,
    required this.message,
    required this.type,
  });

  @override
  String toString() {
    return 'ValidationError(field: $field, message: $message, type: $type)';
  }
}

/// 配置验证器
class ConfigValidator {
  /// 验证配置数据格式
  bool validateConfiguration(Map<String, dynamic> json) {
    try {
      final errors = getValidationErrors(json);
      return errors.isEmpty;
    } catch (e) {
      return false;
    }
  }

  /// 获取验证错误列表
  List<ValidationError> getValidationErrors(Map<String, dynamic> json) {
    final errors = <ValidationError>[];

    // 检查基本结构 - 至少要有一个主要字段
    if (!json.containsKey('panels') && 
        !json.containsKey('proxy') && 
        !json.containsKey('ws') && 
        !json.containsKey('update') &&
        !json.containsKey('onlineSupport') &&
        !json.containsKey('subscription')) {
      errors.add(ValidationError(
        field: 'root',
        message: 'Configuration must contain at least one of: panels, proxy, ws, update, onlineSupport, subscription',
        type: ValidationErrorType.missingField,
      ));
      return errors;
    }

    // 验证panels结构
    if (json.containsKey('panels')) {
      errors.addAll(_validatePanelStructure(json['panels']));
    }

    // 验证其他服务字段
    for (final key in ['proxy', 'ws', 'update']) {
      if (json.containsKey(key)) {
        errors.addAll(_validateServiceList(json[key], key));
      }
    }

    // 验证在线客服配置
    if (json.containsKey('onlineSupport')) {
      errors.addAll(_validateOnlineSupportList(json['onlineSupport']));
    }

    // 验证订阅配置 - 暂时跳过，使用基本验证
    if (json.containsKey('subscription')) {
      final subscription = json['subscription'];
      if (subscription is! Map<String, dynamic>) {
        errors.add(ValidationError(
          field: 'subscription',
          message: 'subscription must be an object',
          type: ValidationErrorType.invalidType,
        ));
      }
    }

    return errors;
  }

  /// 验证面板结构
  List<ValidationError> _validatePanelStructure(dynamic panels) {
    final errors = <ValidationError>[];

    if (panels is! Map<String, dynamic>) {
      errors.add(ValidationError(
        field: 'panels',
        message: 'Panels must be a map',
        type: ValidationErrorType.invalidType,
      ));
      return errors;
    }

    final panelsMap = panels;

    // 验证每个提供商的面板列表
    panelsMap.forEach((provider, panelList) {
      if (panelList is! List) {
        errors.add(ValidationError(
          field: 'panels.$provider',
          message: 'Panel list for $provider must be an array',
          type: ValidationErrorType.invalidType,
        ));
        return;
      }

      final list = panelList;
      for (int i = 0; i < list.length; i++) {
        final item = list[i];
        if (item is! Map<String, dynamic>) {
          errors.add(ValidationError(
            field: 'panels.$provider[$i]',
            message: 'Panel item must be an object',
            type: ValidationErrorType.invalidType,
          ));
          continue;
        }

        final itemMap = item;
        if (!itemMap.containsKey('url') || itemMap['url'] is! String) {
          errors.add(ValidationError(
            field: 'panels.$provider[$i].url',
            message: 'Panel item must have a valid url field',
            type: ValidationErrorType.missingField,
          ));
        }

        if (!itemMap.containsKey('description') || itemMap['description'] is! String) {
          errors.add(ValidationError(
            field: 'panels.$provider[$i].description',
            message: 'Panel item must have a valid description field',
            type: ValidationErrorType.missingField,
          ));
        }
      }
    });

    return errors;
  }

  /// 验证服务列表
  List<ValidationError> _validateServiceList(dynamic serviceList, String serviceType) {
    final errors = <ValidationError>[];

    if (serviceList is! List) {
      errors.add(ValidationError(
        field: serviceType,
        message: '$serviceType must be an array',
        type: ValidationErrorType.invalidType,
      ));
      return errors;
    }

    final list = serviceList;
    for (int i = 0; i < list.length; i++) {
      final item = list[i];
      if (item is! Map<String, dynamic>) {
        errors.add(ValidationError(
          field: '$serviceType[$i]',
          message: 'Service item must be an object',
          type: ValidationErrorType.invalidType,
        ));
        continue;
      }

      final itemMap = item;
      if (!itemMap.containsKey('url') || itemMap['url'] is! String) {
        errors.add(ValidationError(
          field: '$serviceType[$i].url',
          message: 'Service item must have a valid url field',
          type: ValidationErrorType.missingField,
        ));
      }

      if (!itemMap.containsKey('description') || itemMap['description'] is! String) {
        errors.add(ValidationError(
          field: '$serviceType[$i].description',
          message: 'Service item must have a valid description field',
          type: ValidationErrorType.missingField,
        ));
      }

      // 代理服务需要protocol字段
      if (serviceType == 'proxy' && 
          (!itemMap.containsKey('protocol') || itemMap['protocol'] is! String)) {
        errors.add(ValidationError(
          field: '$serviceType[$i].protocol',
          message: 'Proxy item must have a valid protocol field',
          type: ValidationErrorType.missingField,
        ));
      }
    }

    return errors;
  }

  /// 验证在线客服配置列表
  List<ValidationError> _validateOnlineSupportList(dynamic onlineSupportList) {
    final errors = <ValidationError>[];

    if (onlineSupportList is! List) {
      errors.add(ValidationError(
        field: 'onlineSupport',
        message: 'onlineSupport must be an array',
        type: ValidationErrorType.invalidType,
      ));
      return errors;
    }

    final list = onlineSupportList;
    for (int i = 0; i < list.length; i++) {
      final item = list[i];
      if (item is! Map<String, dynamic>) {
        errors.add(ValidationError(
          field: 'onlineSupport[$i]',
          message: 'Online support item must be an object',
          type: ValidationErrorType.invalidType,
        ));
        continue;
      }

      final itemMap = item;
      
      // 验证必填字段
      if (!itemMap.containsKey('url') || itemMap['url'] is! String) {
        errors.add(ValidationError(
          field: 'onlineSupport[$i].url',
          message: 'Online support item must have a valid url field',
          type: ValidationErrorType.missingField,
        ));
      }

      if (!itemMap.containsKey('description') || itemMap['description'] is! String) {
        errors.add(ValidationError(
          field: 'onlineSupport[$i].description',
          message: 'Online support item must have a valid description field',
          type: ValidationErrorType.missingField,
        ));
      }

      if (!itemMap.containsKey('apiBaseUrl') || itemMap['apiBaseUrl'] is! String) {
        errors.add(ValidationError(
          field: 'onlineSupport[$i].apiBaseUrl',
          message: 'Online support item must have a valid apiBaseUrl field',
          type: ValidationErrorType.missingField,
        ));
      }

      if (!itemMap.containsKey('wsBaseUrl') || itemMap['wsBaseUrl'] is! String) {
        errors.add(ValidationError(
          field: 'onlineSupport[$i].wsBaseUrl',
          message: 'Online support item must have a valid wsBaseUrl field',
          type: ValidationErrorType.missingField,
        ));
      }

      // 验证URL格式
      if (itemMap.containsKey('apiBaseUrl') && itemMap['apiBaseUrl'] is String) {
        final apiUrl = itemMap['apiBaseUrl'] as String;
        if (!_isValidHttpUrl(apiUrl)) {
          errors.add(ValidationError(
            field: 'onlineSupport[$i].apiBaseUrl',
            message: 'apiBaseUrl must be a valid HTTP/HTTPS URL',
            type: ValidationErrorType.invalidFormat,
          ));
        }
      }

      if (itemMap.containsKey('wsBaseUrl') && itemMap['wsBaseUrl'] is String) {
        final wsUrl = itemMap['wsBaseUrl'] as String;
        if (!_isValidWebSocketUrl(wsUrl)) {
          errors.add(ValidationError(
            field: 'onlineSupport[$i].wsBaseUrl',
            message: 'wsBaseUrl must be a valid WebSocket URL',
            type: ValidationErrorType.invalidFormat,
          ));
        }
      }
    }

    return errors;
  }

  /// 检查是否为有效的HTTP URL
  bool _isValidHttpUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return (uri.scheme == 'http' || uri.scheme == 'https') && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// 检查是否为有效的WebSocket URL
  bool _isValidWebSocketUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return (uri.scheme == 'ws' || uri.scheme == 'wss') && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}

/// 配置解析器
/// 
/// 负责解析JSON配置数据并转换为结构化的配置对象
class ConfigurationParser {
  final ConfigValidator _validator;

  ConfigurationParser({ConfigValidator? validator}) 
      : _validator = validator ?? ConfigValidator();

  /// 从JSON数据解析配置
  ParsedConfiguration parseFromJson(
    Map<String, dynamic> json, 
    String currentProvider,
  ) {
    try {
      // 验证配置格式
      if (!_validator.validateConfiguration(json)) {
        final errors = _validator.getValidationErrors(json);
        throw ConfigurationParseException(
          'Configuration validation failed: ${errors.map((e) => e.toString()).join(', ')}'
        );
      }

      return ParsedConfiguration.fromJson(json, currentProvider);
    } catch (e) {
      if (e is ConfigurationParseException) {
        rethrow;
      }
      throw ConfigurationParseException('Failed to parse configuration: $e', e);
    }
  }

  /// 从多个配置源解析配置
  ParsedConfiguration parseFromMultipleSources(
    List<Map<String, dynamic>> configs,
    String currentProvider,
  ) {
    if (configs.isEmpty) {
      throw ConfigurationParseException('No configurations to parse');
    }

    if (configs.length == 1) {
      return parseFromJson(configs.first, currentProvider);
    }

    // 合并多个配置
    final merged = _mergeConfigurations(configs);
    return parseFromJson(merged, currentProvider);
  }

  /// 从远程配置结果中提取配置数据
  Map<String, dynamic>? extractConfigFromRemoteResult(Map<String, dynamic> remoteResult) {
    // 直接检查是否包含新格式的配置结构
    if (remoteResult.containsKey('panels') || 
        remoteResult.containsKey('proxy') || 
        remoteResult.containsKey('ws') || 
        remoteResult.containsKey('update') ||
        remoteResult.containsKey('onlineSupport') ||
        remoteResult.containsKey('subscription')) {
      return remoteResult;
    }

    // 兼容旧格式：检查是否有panel_urls字段，转换为新格式
    if (remoteResult.containsKey('panel_urls')) {
      final panelUrls = remoteResult['panel_urls'] as List?;
      if (panelUrls != null) {
        // 将旧格式转换为新格式
        final convertedConfig = <String, dynamic>{
          'panels': {
            'Flclash': panelUrls.map((url) => {
              'url': url.toString(),
              'description': '从旧格式转换的面板URL',
            }).toList(),
          },
        };
        
        // 复制其他可能存在的字段
        for (final key in ['proxy', 'ws', 'update', 'onlineSupport', 'subscription']) {
          if (remoteResult.containsKey(key)) {
            convertedConfig[key] = remoteResult[key];
          }
        }
        
        return convertedConfig;
      }
    }

    // 如果没有找到预期的配置结构，返回null
    return null;
  }

  /// 合并多个配置数据
  Map<String, dynamic> _mergeConfigurations(List<Map<String, dynamic>> configs) {
    final merged = <String, dynamic>{};
    
    for (final config in configs) {
      if (!_validator.validateConfiguration(config)) {
        continue; // 跳过无效配置
      }
      
      // 合并panels
      if (config.containsKey('panels')) {
        final panels = config['panels'] as Map<String, dynamic>;
        final existingPanels = (merged['panels'] as Map<String, dynamic>?) ?? {};
        
        panels.forEach((provider, panelList) {
          final existingList = (existingPanels[provider] as List?) ?? [];
          final newList = panelList as List;
          existingPanels[provider] = [...existingList, ...newList];
        });
        
        merged['panels'] = existingPanels;
      }

      // 合并其他列表字段  
      for (final key in ['proxy', 'ws', 'update', 'onlineSupport']) {
        if (config.containsKey(key)) {
          final existingList = (merged[key] as List?) ?? [];
          final newList = config[key] as List;
          merged[key] = [...existingList, ...newList];
        }
      }

      // 合并订阅配置
      if (config.containsKey('subscription')) {
        final existingSubscription = (merged['subscription'] as Map<String, dynamic>?) ?? {};
        final newSubscription = config['subscription'] as Map<String, dynamic>;
        
        // 合并urls数组
        if (newSubscription.containsKey('urls')) {
          final existingUrls = (existingSubscription['urls'] as List?) ?? [];
          final newUrls = newSubscription['urls'] as List;
          existingSubscription['urls'] = [...existingUrls, ...newUrls];
        }
        
        // 合并其他字段
        newSubscription.forEach((key, value) {
          if (key != 'urls') {
            existingSubscription[key] = value;
          }
        });
        
        merged['subscription'] = existingSubscription;
      }

      // 合并元数据
      if (config.containsKey('metadata')) {
        final existingMetadata = (merged['metadata'] as Map<String, dynamic>?) ?? {};
        final newMetadata = config['metadata'] as Map<String, dynamic>;
        merged['metadata'] = {...existingMetadata, ...newMetadata};
      }
    }

    return merged;
  }

}