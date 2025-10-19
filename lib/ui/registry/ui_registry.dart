/// UI 注册中心
/// 管理所有 UI 构建器，实现动态主题切换
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// UI 构建器函数签名
typedef UIBuilder<T> = Widget Function(dynamic data, dynamic callbacks);

/// UI 注册中心（单例）
class UIRegistry {
  static final UIRegistry _instance = UIRegistry._internal();
  factory UIRegistry() => _instance;
  UIRegistry._internal();

  /// 页面构建器注册表
  /// Key: "themeId_PageContractType"
  /// Value: 构建器函数
  final Map<String, dynamic> _pageBuilders = {};

  /// 组件构建器注册表
  /// Key: "themeId_ComponentContractType"
  /// Value: 构建器函数
  final Map<String, dynamic> _componentBuilders = {};

  /// 当前激活的主题 ID
  String _currentThemeId = 'default';

  /// 获取当前主题 ID
  String get currentThemeId => _currentThemeId;
  
  /// 获取当前激活的主题 ID（别名）
  String get activeThemeId => _currentThemeId;

  /// 设置当前主题
  void setTheme(String themeId) {
    if (_currentThemeId == themeId) return;
    
    _currentThemeId = themeId;
    debugPrint('[UIRegistry] 已切换到主题: $themeId');
  }
  
  /// 设置激活的主题（别名）
  void setActiveTheme(String themeId) => setTheme(themeId);
  
  /// 获取可用的主题列表
  List<String> get availableThemes => getRegisteredThemes().toList()..sort();

  /// 注册页面构建器
  /// 
  /// [themeId] 主题 ID（如 'default', 'modern'）
  /// [pageType] 页面契约类型
  /// [builder] 构建器函数
  void registerPage<T>({
    required String themeId,
    required Type pageType,
    required UIBuilder<T> builder,
  }) {
    final key = _makeKey(themeId, pageType);
    _pageBuilders[key] = builder;
    debugPrint('[UIRegistry] 已注册页面: $key');
  }

  /// 批量注册页面
  void registerPages({
    required String themeId,
    required Map<Type, dynamic> builders,
  }) {
    builders.forEach((pageType, builder) {
      final key = _makeKey(themeId, pageType);
      _pageBuilders[key] = builder;
    });
    debugPrint('[UIRegistry] 批量注册 ${builders.length} 个页面: $themeId');
  }

  /// 注册组件构建器
  void registerComponent<T>({
    required String themeId,
    required Type componentType,
    required UIBuilder<T> builder,
  }) {
    final key = _makeKey(themeId, componentType);
    _componentBuilders[key] = builder;
    debugPrint('[UIRegistry] 已注册组件: $key');
  }

  /// 批量注册组件
  void registerComponents({
    required String themeId,
    required Map<Type, dynamic> builders,
  }) {
    builders.forEach((componentType, builder) {
      final key = _makeKey(themeId, componentType);
      _componentBuilders[key] = builder;
    });
    debugPrint('[UIRegistry] 批量注册 ${builders.length} 个组件: $themeId');
  }

  /// 构建页面
  /// 
  /// [T] 页面契约类型
  /// [data] 页面数据（DataModel）
  /// [callbacks] 页面回调（CallbacksModel）
  /// [themeId] 可选的主题 ID，不传则使用当前主题
  Widget buildPage<T>({
    required dynamic data,
    required dynamic callbacks,
    String? themeId,
  }) {
    final theme = themeId ?? _currentThemeId;
    final key = _makeKey(theme, T);
    
    // 1. 尝试使用指定主题的构建器
    var builder = _pageBuilders[key];
    
    // 2. 如果没找到，尝试使用默认主题
    if (builder == null && theme != 'default') {
      final defaultKey = _makeKey('default', T);
      builder = _pageBuilders[defaultKey];
      
      if (builder != null) {
        debugPrint('[UIRegistry] 页面 $T 在主题 $theme 中未找到，使用默认主题');
      }
    }
    
    // 3. 如果还是没找到，抛出异常
    if (builder == null) {
      throw Exception(
        '[UIRegistry] 未找到页面构建器: $key\n'
        '请确保已注册该页面的 UI 实现。\n'
        '提示：在 main() 中调用对应主题的 register() 方法。'
      );
    }
    
    // 4. 调用构建器创建 Widget
    try {
      return builder(data, callbacks);
    } catch (e, stackTrace) {
      debugPrint('[UIRegistry] 构建页面失败: $key');
      debugPrint('错误: $e');
      debugPrint('堆栈: $stackTrace');
      rethrow;
    }
  }

  /// 构建组件
  Widget buildComponent<T>({
    required T data,
    required dynamic callbacks,
    String? themeId,
  }) {
    final theme = themeId ?? _currentThemeId;
    final key = _makeKey(theme, T);
    
    var builder = _componentBuilders[key] as UIBuilder<T>?;
    
    if (builder == null && theme != 'default') {
      final defaultKey = _makeKey('default', T);
      builder = _componentBuilders[defaultKey] as UIBuilder<T>?;
    }
    
    if (builder == null) {
      throw Exception('[UIRegistry] 未找到组件构建器: $key');
    }
    
    try {
      return builder(data, callbacks);
    } catch (e, stackTrace) {
      debugPrint('[UIRegistry] 构建组件失败: $key');
      debugPrint('错误: $e');
      debugPrint('堆栈: $stackTrace');
      rethrow;
    }
  }

  /// 检查页面是否已注册
  bool hasPage(Type pageType, {String? themeId}) {
    final theme = themeId ?? _currentThemeId;
    final key = _makeKey(theme, pageType);
    return _pageBuilders.containsKey(key);
  }

  /// 检查组件是否已注册
  bool hasComponent(Type componentType, {String? themeId}) {
    final theme = themeId ?? _currentThemeId;
    final key = _makeKey(theme, componentType);
    return _componentBuilders.containsKey(key);
  }

  /// 获取已注册的主题列表
  Set<String> getRegisteredThemes() {
    final themes = <String>{};
    
    for (final key in _pageBuilders.keys) {
      final themeId = key.split('_').first;
      themes.add(themeId);
    }
    
    for (final key in _componentBuilders.keys) {
      final themeId = key.split('_').first;
      themes.add(themeId);
    }
    
    return themes;
  }

  /// 获取指定主题已注册的页面数量
  int getPageCount(String themeId) {
    return _pageBuilders.keys
        .where((key) => key.startsWith('${themeId}_'))
        .length;
  }

  /// 获取指定主题已注册的组件数量
  int getComponentCount(String themeId) {
    return _componentBuilders.keys
        .where((key) => key.startsWith('${themeId}_'))
        .length;
  }

  /// 清空所有注册
  void clear() {
    _pageBuilders.clear();
    _componentBuilders.clear();
    _currentThemeId = 'default';
    debugPrint('[UIRegistry] 已清空所有注册');
  }

  /// 清空指定主题的注册
  void clearTheme(String themeId) {
    _pageBuilders.removeWhere((key, _) => key.startsWith('${themeId}_'));
    _componentBuilders.removeWhere((key, _) => key.startsWith('${themeId}_'));
    debugPrint('[UIRegistry] 已清空主题: $themeId');
  }

  /// 生成注册 key
  String _makeKey(String themeId, Type type) {
    return '${themeId}_${type.toString()}';
  }

  /// 打印注册信息（调试用）
  void debugPrintRegistry() {
    debugPrint('═══════════════════════════════════════');
    debugPrint('UI Registry 注册信息');
    debugPrint('═══════════════════════════════════════');
    debugPrint('当前主题: $_currentThemeId');
    debugPrint('已注册主题: ${getRegisteredThemes()}');
    debugPrint('');
    
    debugPrint('页面构建器 (${_pageBuilders.length})：');
    _pageBuilders.keys.toList()
      ..sort()
      ..forEach((key) => debugPrint('  - $key'));
    debugPrint('');
    
    debugPrint('组件构建器 (${_componentBuilders.length})：');
    _componentBuilders.keys.toList()
      ..sort()
      ..forEach((key) => debugPrint('  - $key'));
    debugPrint('═══════════════════════════════════════');
  }
}

