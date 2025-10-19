/// UI 主题包基类
/// 所有主题包都应该实现这个接口
library;

import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:flutter/material.dart';

/// 主题包元数据
class ThemePackageMetadata {
  /// 主题 ID（唯一标识）
  final String id;
  
  /// 主题名称
  final String name;
  
  /// 主题描述
  final String description;
  
  /// 主题版本
  final String version;
  
  /// 主题作者
  final String author;
  
  /// 主题预览图（可选）
  final String? previewImage;
  
  /// 支持的功能标签
  final List<String> tags;

  const ThemePackageMetadata({
    required this.id,
    required this.name,
    required this.description,
    required this.version,
    required this.author,
    this.previewImage,
    this.tags = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'version': version,
      'author': author,
      'previewImage': previewImage,
      'tags': tags,
    };
  }
}

/// 主题包基类
/// 
/// 所有主题包都应该继承这个类并实现 register() 方法
/// 
/// 使用示例：
/// ```dart
/// class DefaultUITheme extends ThemePackageBase {
///   @override
///   ThemePackageMetadata get metadata => ThemePackageMetadata(
///         id: 'default',
///         name: '默认主题',
///         description: '基于原生 Material Design 的经典主题',
///         version: '1.0.0',
///         author: 'XBoard Mihomo Team',
///       );
///
///   @override
///   void register() {
///     // 注册所有页面和组件
///     final registry = UIRegistry();
///     
///     registry.registerPage(
///       themeId: metadata.id,
///       pageType: HomePageContract,
///       builder: (data, callbacks) => DefaultHomePage(
///         data: data,
///         callbacks: callbacks,
///       ),
///     );
///     
///     // ... 注册其他页面和组件
///   }
/// }
/// ```
abstract class ThemePackageBase {
  /// 主题元数据
  ThemePackageMetadata get metadata;

  /// 注册所有 UI 实现
  /// 
  /// 在这个方法中，应该将所有页面和组件的构建器注册到 UIRegistry
  void register();

  /// 注销主题（清理资源）
  void unregister() {
    UIRegistry().clearTheme(metadata.id);
  }

  /// 检查主题是否已注册
  bool get isRegistered {
    final registry = UIRegistry();
    return registry.getRegisteredThemes().contains(metadata.id);
  }

  /// 获取主题信息摘要
  String get summary {
    return '${metadata.name} (${metadata.id}) v${metadata.version} by ${metadata.author}';
  }
}

/// 主题包管理器
/// 
/// 用于管理所有可用的主题包
class ThemePackageManager {
  static final ThemePackageManager _instance = ThemePackageManager._internal();
  factory ThemePackageManager() => _instance;
  ThemePackageManager._internal();

  /// 已安装的主题包
  final Map<String, ThemePackageBase> _themes = {};

  /// 安装主题包
  void install(ThemePackageBase theme) {
    final id = theme.metadata.id;
    
    if (_themes.containsKey(id)) {
      debugPrint('[ThemePackageManager] 主题 $id 已存在，将被覆盖');
    }
    
    _themes[id] = theme;
    debugPrint('[ThemePackageManager] 已安装主题: ${theme.summary}');
  }

  /// 批量安装主题包
  void installAll(List<ThemePackageBase> themes) {
    for (final theme in themes) {
      install(theme);
    }
  }

  /// 卸载主题包
  void uninstall(String themeId) {
    final theme = _themes.remove(themeId);
    if (theme != null) {
      theme.unregister();
      debugPrint('[ThemePackageManager] 已卸载主题: $themeId');
    }
  }

  /// 获取主题包
  ThemePackageBase? getTheme(String themeId) {
    return _themes[themeId];
  }

  /// 获取所有已安装的主题
  List<ThemePackageBase> get installedThemes {
    return _themes.values.toList();
  }

  /// 获取所有主题元数据
  List<ThemePackageMetadata> get themesMetadata {
    return _themes.values.map((theme) => theme.metadata).toList();
  }

  /// 检查主题是否已安装
  bool isInstalled(String themeId) {
    return _themes.containsKey(themeId);
  }

  /// 获取已安装主题数量
  int get themeCount => _themes.length;

  /// 激活主题（注册并设置为当前主题）
  bool activateTheme(String themeId) {
    final theme = _themes[themeId];
    if (theme == null) {
      debugPrint('[ThemePackageManager] 主题 $themeId 未安装');
      return false;
    }

    try {
      // 注册 UI 实现
      theme.register();
      
      // 设置为当前主题
      UIRegistry().setTheme(themeId);
      
      debugPrint('[ThemePackageManager] 已激活主题: ${theme.summary}');
      return true;
    } catch (e, stackTrace) {
      debugPrint('[ThemePackageManager] 激活主题失败: $themeId');
      debugPrint('错误: $e');
      debugPrint('堆栈: $stackTrace');
      return false;
    }
  }

  /// 切换主题
  Future<bool> switchTheme(String themeId) async {
    if (!isInstalled(themeId)) {
      debugPrint('[ThemePackageManager] 主题 $themeId 未安装');
      return false;
    }

    // 清空旧主题的注册
    final currentThemeId = UIRegistry().currentThemeId;
    if (currentThemeId != themeId) {
      UIRegistry().clearTheme(currentThemeId);
    }

    // 激活新主题
    return activateTheme(themeId);
  }

  /// 打印所有已安装的主题
  void debugPrintThemes() {
    debugPrint('═══════════════════════════════════════');
    debugPrint('已安装的主题包 (${_themes.length})');
    debugPrint('═══════════════════════════════════════');
    
    _themes.values.forEach((theme) {
      final meta = theme.metadata;
      debugPrint('');
      debugPrint('ID: ${meta.id}');
      debugPrint('名称: ${meta.name}');
      debugPrint('描述: ${meta.description}');
      debugPrint('版本: ${meta.version}');
      debugPrint('作者: ${meta.author}');
      debugPrint('标签: ${meta.tags.join(', ')}');
      debugPrint('已注册: ${theme.isRegistered}');
    });
    
    debugPrint('═══════════════════════════════════════');
  }

  /// 清空所有主题
  void clear() {
    _themes.values.forEach((theme) => theme.unregister());
    _themes.clear();
    debugPrint('[ThemePackageManager] 已清空所有主题');
  }
}

