/// 合并策略
enum MergeStrategy {
  /// 后面的配置覆盖前面的
  override,
  /// 合并所有配置项
  merge,
  /// 只保留第一个配置
  first,
  /// 只保留最后一个配置
  last,
}

/// 合并选项
class MergeOptions {
  final MergeStrategy panelStrategy;
  final MergeStrategy serviceStrategy;
  final MergeStrategy metadataStrategy;
  final bool removeDuplicates;
  final bool preserveOrder;

  const MergeOptions({
    this.panelStrategy = MergeStrategy.merge,
    this.serviceStrategy = MergeStrategy.merge,
    this.metadataStrategy = MergeStrategy.override,
    this.removeDuplicates = true,
    this.preserveOrder = true,
  });
}

/// 配置合并器
/// 
/// 负责合并多个配置源的数据，处理冲突和重复项
class ConfigMerger {
  final MergeOptions _options;

  ConfigMerger({MergeOptions? options}) 
      : _options = options ?? const MergeOptions();

  /// 合并多个配置
  Map<String, dynamic> mergeConfigs(List<Map<String, dynamic>> configs) {
    if (configs.isEmpty) {
      return {};
    }

    if (configs.length == 1) {
      return Map<String, dynamic>.from(configs.first);
    }

    final merged = <String, dynamic>{};

    // 合并面板配置
    final panelConfigs = configs
        .where((config) => config.containsKey('panels'))
        .map((config) => config['panels'] as Map<String, dynamic>)
        .toList();
    
    if (panelConfigs.isNotEmpty) {
      merged['panels'] = _mergePanels(panelConfigs);
    }

    // 合并服务配置
    for (final serviceType in ['proxy', 'ws', 'update']) {
      final serviceLists = configs
          .where((config) => config.containsKey(serviceType))
          .map((config) => config[serviceType] as List<dynamic>)
          .toList();
      
      if (serviceLists.isNotEmpty) {
        merged[serviceType] = _mergeServiceLists(serviceLists, serviceType);
      }
    }

    // 合并元数据
    final metadataConfigs = configs
        .where((config) => config.containsKey('metadata'))
        .map((config) => config['metadata'] as Map<String, dynamic>)
        .toList();
    
    if (metadataConfigs.isNotEmpty) {
      merged['metadata'] = _mergeMetadata(metadataConfigs);
    }

    return merged;
  }

  /// 合并面板配置
  Map<String, dynamic> _mergePanels(List<Map<String, dynamic>> panelConfigs) {
    switch (_options.panelStrategy) {
      case MergeStrategy.first:
        return Map<String, dynamic>.from(panelConfigs.first);
      
      case MergeStrategy.last:
        return Map<String, dynamic>.from(panelConfigs.last);
      
      case MergeStrategy.override:
        final merged = <String, dynamic>{};
        for (final config in panelConfigs) {
          merged.addAll(config);
        }
        return merged;
      
      case MergeStrategy.merge:
        return _mergeProviderPanels(panelConfigs);
    }
  }

  /// 合并提供商面板
  Map<String, dynamic> _mergeProviderPanels(List<Map<String, dynamic>> panelConfigs) {
    final merged = <String, List<dynamic>>{};

    for (final config in panelConfigs) {
      config.forEach((provider, panelList) {
        if (panelList is List) {
          final existingList = merged[provider] ?? [];
          final newList = List<dynamic>.from(panelList);
          
          if (_options.removeDuplicates) {
            // 根据URL去重
            final existingUrls = existingList
                .where((item) => item is Map && item.containsKey('url'))
                .map((item) => item['url'])
                .toSet();
            
            final uniqueNewItems = newList
                .where((item) => item is Map && 
                       item.containsKey('url') && 
                       !existingUrls.contains(item['url']))
                .toList();
            
            merged[provider] = [...existingList, ...uniqueNewItems];
          } else {
            merged[provider] = [...existingList, ...newList];
          }
        }
      });
    }

    return merged.cast<String, dynamic>();
  }

  /// 合并服务列表
  List<dynamic> _mergeServiceLists(List<List<dynamic>> serviceLists, String serviceType) {
    switch (_options.serviceStrategy) {
      case MergeStrategy.first:
        return List<dynamic>.from(serviceLists.first);
      
      case MergeStrategy.last:
        return List<dynamic>.from(serviceLists.last);
      
      case MergeStrategy.override:
        final merged = <dynamic>[];
        for (final list in serviceLists) {
          merged.addAll(list);
        }
        return merged;
      
      case MergeStrategy.merge:
        return _mergeServiceItems(serviceLists, serviceType);
    }
  }

  /// 合并服务项
  List<dynamic> _mergeServiceItems(List<List<dynamic>> serviceLists, String serviceType) {
    final merged = <dynamic>[];
    final seenUrls = <String>{};

    for (final list in serviceLists) {
      for (final item in list) {
        if (item is Map<String, dynamic> && item.containsKey('url')) {
          final url = item['url'] as String;
          
          if (_options.removeDuplicates) {
            if (!seenUrls.contains(url)) {
              seenUrls.add(url);
              merged.add(item);
            }
          } else {
            merged.add(item);
          }
        } else {
          // 非标准格式的项目直接添加
          merged.add(item);
        }
      }
    }

    return merged;
  }

  /// 合并元数据
  Map<String, dynamic> _mergeMetadata(List<Map<String, dynamic>> metadataConfigs) {
    switch (_options.metadataStrategy) {
      case MergeStrategy.first:
        return Map<String, dynamic>.from(metadataConfigs.first);
      
      case MergeStrategy.last:
        return Map<String, dynamic>.from(metadataConfigs.last);
      
      case MergeStrategy.override:
      case MergeStrategy.merge:
        final merged = <String, dynamic>{};
        for (final config in metadataConfigs) {
          merged.addAll(config);
        }
        
        // 合并sources列表
        if (merged.containsKey('sources')) {
          final allSources = <String>[];
          for (final config in metadataConfigs) {
            if (config.containsKey('sources') && config['sources'] is List) {
              final sources = (config['sources'] as List).cast<String>();
              allSources.addAll(sources);
            }
          }
          merged['sources'] = _options.removeDuplicates 
              ? allSources.toSet().toList() 
              : allSources;
        }
        
        return merged;
    }
  }

  /// 验证合并结果
  bool validateMergedConfig(Map<String, dynamic> mergedConfig) {
    // 检查基本结构
    if (!mergedConfig.containsKey('panels') && 
        !mergedConfig.containsKey('proxy') && 
        !mergedConfig.containsKey('ws') && 
        !mergedConfig.containsKey('update')) {
      return false;
    }

    // 验证面板结构
    if (mergedConfig.containsKey('panels')) {
      final panels = mergedConfig['panels'];
      if (panels is! Map<String, dynamic>) {
        return false;
      }
      
      for (final entry in panels.entries) {
        if (entry.value is! List) {
          return false;
        }
      }
    }

    // 验证服务列表
    for (final serviceType in ['proxy', 'ws', 'update']) {
      if (mergedConfig.containsKey(serviceType)) {
        if (mergedConfig[serviceType] is! List) {
          return false;
        }
      }
    }

    return true;
  }

  /// 获取合并统计信息
  Map<String, dynamic> getMergeStats(
    List<Map<String, dynamic>> configs,
    Map<String, dynamic> mergedConfig,
  ) {
    final stats = <String, dynamic>{
      'inputConfigs': configs.length,
      'mergeStrategy': {
        'panels': _options.panelStrategy.toString(),
        'services': _options.serviceStrategy.toString(),
        'metadata': _options.metadataStrategy.toString(),
      },
      'options': {
        'removeDuplicates': _options.removeDuplicates,
        'preserveOrder': _options.preserveOrder,
      },
    };

    // 统计各类型的项目数量
    if (mergedConfig.containsKey('panels')) {
      final panels = mergedConfig['panels'] as Map<String, dynamic>;
      final panelCounts = <String, int>{};
      panels.forEach((provider, panelList) {
        if (panelList is List) {
          panelCounts[provider] = panelList.length;
        }
      });
      stats['panelCounts'] = panelCounts;
    }

    for (final serviceType in ['proxy', 'ws', 'update']) {
      if (mergedConfig.containsKey(serviceType)) {
        final serviceList = mergedConfig[serviceType] as List;
        stats['${serviceType}Count'] = serviceList.length;
      }
    }

    return stats;
  }
}