/// 配置验证工具
/// 
/// 提供配置数据的验证功能
class ConfigValidator {
  /// 验证URL格式
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// 验证HTTP/HTTPS URL
  static bool isValidHttpUrl(String url) {
    if (!isValidUrl(url)) return false;
    
    final uri = Uri.parse(url);
    return uri.scheme == 'http' || uri.scheme == 'https';
  }

  /// 验证WebSocket URL
  static bool isValidWebSocketUrl(String url) {
    if (!isValidUrl(url)) return false;
    
    final uri = Uri.parse(url);
    return uri.scheme == 'ws' || uri.scheme == 'wss';
  }

  /// 验证代理URL格式
  static bool isValidProxyUrl(String url) {
    try {
      // 支持格式：protocol://username:password@host:port
      // 或者：username:password@host:port
      if (url.contains('@')) {
        final parts = url.split('@');
        if (parts.length != 2) return false;
        
        final hostPart = parts[1];
        return hostPart.contains(':') && hostPart.split(':').length >= 2;
      }
      
      // 简单的host:port格式
      return url.contains(':') && url.split(':').length >= 2;
    } catch (e) {
      return false;
    }
  }

  /// 验证端口号
  static bool isValidPort(int port) {
    return port > 0 && port <= 65535;
  }

  /// 验证提供商名称
  static bool isValidProvider(String provider) {
    // 移除硬编码限制，允许使用任意 provider
    // 只要不为空且是有效字符串即可
    return provider.isNotEmpty;
  }

  /// 验证协议类型
  static bool isValidProtocol(String protocol) {
    const validProtocols = ['http', 'https', 'socks5', 'ws', 'wss'];
    return validProtocols.contains(protocol.toLowerCase());
  }

  /// 验证配置条目
  static bool isValidConfigEntry(Map<String, dynamic> entry) {
    // 必须有url和description字段
    if (!entry.containsKey('url') || !entry.containsKey('description')) {
      return false;
    }

    final url = entry['url'];
    final description = entry['description'];

    if (url is! String || description is! String) {
      return false;
    }

    if (url.isEmpty || description.isEmpty) {
      return false;
    }

    return isValidUrl(url);
  }

  /// 验证代理配置条目
  static bool isValidProxyEntry(Map<String, dynamic> entry) {
    if (!isValidConfigEntry(entry)) {
      return false;
    }

    // 代理必须有protocol字段
    if (!entry.containsKey('protocol')) {
      return false;
    }

    final protocol = entry['protocol'];
    if (protocol is! String || !isValidProtocol(protocol)) {
      return false;
    }

    return isValidProxyUrl(entry['url'] as String);
  }

  /// 验证WebSocket配置条目
  static bool isValidWebSocketEntry(Map<String, dynamic> entry) {
    if (!isValidConfigEntry(entry)) {
      return false;
    }

    return isValidWebSocketUrl(entry['url'] as String);
  }

  /// 验证面板配置结构
  static bool isValidPanelConfig(Map<String, dynamic> panels) {
    for (final entry in panels.entries) {
      final provider = entry.key;
      final panelList = entry.value;

      // 验证提供商名称
      if (!isValidProvider(provider)) {
        return false;
      }

      // 验证面板列表
      if (panelList is! List) {
        return false;
      }

      for (final panel in panelList) {
        if (panel is! Map<String, dynamic> || !isValidConfigEntry(panel)) {
          return false;
        }
      }
    }

    return true;
  }

  /// 验证订阅配置
  static bool isValidSubscriptionConfig(Map<String, dynamic> subscription) {
    // 必须包含urls字段
    if (!subscription.containsKey('urls')) {
      return false;
    }

    final urls = subscription['urls'];
    if (urls is! List) {
      return false;
    }

    // 验证每个订阅URL
    for (final url in urls) {
      if (url is! Map<String, dynamic>) {
        return false;
      }

      if (!isValidSubscriptionUrlEntry(url)) {
        return false;
      }
    }

    return true;
  }

  /// 验证订阅URL条目
  static bool isValidSubscriptionUrlEntry(Map<String, dynamic> entry) {
    // 必须有基本字段
    if (!isValidConfigEntry(entry)) {
      return false;
    }

    // 验证endpoints字段
    if (entry.containsKey('endpoints')) {
      final endpoints = entry['endpoints'];
      if (endpoints is! Map<String, dynamic>) {
        return false;
      }

      // 验证每个端点
      for (final endpoint in endpoints.values) {
        if (endpoint is! Map<String, dynamic>) {
          return false;
        }

        if (!isValidSubscriptionEndpoint(endpoint)) {
          return false;
        }
      }
    }

    return true;
  }

  /// 验证订阅端点
  static bool isValidSubscriptionEndpoint(Map<String, dynamic> endpoint) {
    // 必须有path字段
    if (!endpoint.containsKey('path') || endpoint['path'] is! String) {
      return false;
    }

    // 验证method字段
    if (endpoint.containsKey('method')) {
      final method = endpoint['method'];
      if (method is! String) {
        return false;
      }
      const validMethods = ['GET', 'POST', 'PUT', 'DELETE'];
      if (!validMethods.contains(method.toUpperCase())) {
        return false;
      }
    }

    // 验证requiresToken字段
    if (endpoint.containsKey('requiresToken')) {
      if (endpoint['requiresToken'] is! bool) {
        return false;
      }
    }

    // 验证isEncrypt字段
    if (endpoint.containsKey('isEncrypt')) {
      if (endpoint['isEncrypt'] is! bool) {
        return false;
      }
    }

    return true;
  }

  /// 验证服务列表
  static bool isValidServiceList(List<dynamic> services, String serviceType) {
    for (final service in services) {
      if (service is! Map<String, dynamic>) {
        return false;
      }

      switch (serviceType) {
        case 'proxy':
          if (!isValidProxyEntry(service)) {
            return false;
          }
          break;
        case 'ws':
          if (!isValidWebSocketEntry(service)) {
            return false;
          }
          break;
        case 'update':
          if (!isValidConfigEntry(service)) {
            return false;
          }
          break;
        default:
          if (!isValidConfigEntry(service)) {
            return false;
          }
      }
    }

    return true;
  }

  /// 验证完整配置
  static bool isValidConfiguration(Map<String, dynamic> config) {
    // 至少要有一个主要字段
    if (!config.containsKey('panels') && 
        !config.containsKey('proxy') && 
        !config.containsKey('ws') && 
        !config.containsKey('update') &&
        !config.containsKey('subscription')) {
      return false;
    }

    // 验证面板配置
    if (config.containsKey('panels')) {
      final panels = config['panels'];
      if (panels is! Map<String, dynamic> || !isValidPanelConfig(panels)) {
        return false;
      }
    }

    // 验证服务列表
    for (final serviceType in ['proxy', 'ws', 'update']) {
      if (config.containsKey(serviceType)) {
        final services = config[serviceType];
        if (services is! List || !isValidServiceList(services, serviceType)) {
          return false;
        }
      }
    }

    // 验证订阅配置
    if (config.containsKey('subscription')) {
      final subscription = config['subscription'];
      if (subscription is! Map<String, dynamic> || !isValidSubscriptionConfig(subscription)) {
        return false;
      }
    }

    return true;
  }

  /// 获取配置验证错误详情
  static List<String> getValidationErrors(Map<String, dynamic> config) {
    final errors = <String>[];

    // 检查基本结构
    if (!config.containsKey('panels') && 
        !config.containsKey('proxy') && 
        !config.containsKey('ws') && 
        !config.containsKey('update') &&
        !config.containsKey('subscription')) {
      errors.add('Configuration must contain at least one of: panels, proxy, ws, update, subscription');
      return errors;
    }

    // 验证面板配置
    if (config.containsKey('panels')) {
      final panels = config['panels'];
      if (panels is! Map<String, dynamic>) {
        errors.add('panels must be an object');
      } else {
        for (final entry in panels.entries) {
          final provider = entry.key;
          final panelList = entry.value;

          if (!isValidProvider(provider)) {
            errors.add('Invalid provider: $provider');
          }

          if (panelList is! List) {
            errors.add('panels.$provider must be an array');
          } else {
            for (int i = 0; i < panelList.length; i++) {
              final panel = panelList[i];
              if (panel is! Map<String, dynamic>) {
                errors.add('panels.$provider[$i] must be an object');
              } else if (!isValidConfigEntry(panel)) {
                errors.add('panels.$provider[$i] has invalid format');
              }
            }
          }
        }
      }
    }

    // 验证服务列表
    for (final serviceType in ['proxy', 'ws', 'update']) {
      if (config.containsKey(serviceType)) {
        final services = config[serviceType];
        if (services is! List) {
          errors.add('$serviceType must be an array');
        } else {
          for (int i = 0; i < services.length; i++) {
            final service = services[i];
            if (service is! Map<String, dynamic>) {
              errors.add('$serviceType[$i] must be an object');
            } else {
              switch (serviceType) {
                case 'proxy':
                  if (!isValidProxyEntry(service)) {
                    errors.add('$serviceType[$i] has invalid proxy format');
                  }
                  break;
                case 'ws':
                  if (!isValidWebSocketEntry(service)) {
                    errors.add('$serviceType[$i] has invalid WebSocket format');
                  }
                  break;
                default:
                  if (!isValidConfigEntry(service)) {
                    errors.add('$serviceType[$i] has invalid format');
                  }
              }
            }
          }
        }
      }
    }

    // 验证订阅配置
    if (config.containsKey('subscription')) {
      final subscription = config['subscription'];
      if (subscription is! Map<String, dynamic>) {
        errors.add('subscription must be an object');
      } else {
        if (!subscription.containsKey('urls')) {
          errors.add('subscription must contain urls field');
        } else {
          final urls = subscription['urls'];
          if (urls is! List) {
            errors.add('subscription.urls must be an array');
          } else {
            for (int i = 0; i < urls.length; i++) {
              final url = urls[i];
              if (url is! Map<String, dynamic>) {
                errors.add('subscription.urls[$i] must be an object');
              } else if (!isValidSubscriptionUrlEntry(url)) {
                errors.add('subscription.urls[$i] has invalid format');
              }
            }
          }
        }
      }
    }

    return errors;
  }
}