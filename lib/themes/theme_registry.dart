/// 主题注册中心
/// 用于管理所有可用的主题包
library;

import 'package:fl_clash/themes/theme_provider.dart';
import 'package:flutter/foundation.dart';

/// 主题注册中心
class ThemeRegistry extends ChangeNotifier {
  static final ThemeRegistry _instance = ThemeRegistry._internal();
  factory ThemeRegistry() => _instance;
  ThemeRegistry._internal();

  /// 已注册的主题
  final Map<String, UIThemeProvider> _themes = {};

  /// 当前激活的主题ID
  String? _activeThemeId;

  /// 注册主题
  void register(UIThemeProvider theme) {
    final id = theme.metadata.id;
    if (_themes.containsKey(id)) {
      debugPrint('[ThemeRegistry] 主题 $id 已存在，将被覆盖');
    }
    _themes[id] = theme;
    debugPrint('[ThemeRegistry] 主题已注册: ${theme.metadata.name} (ID: $id)');
    notifyListeners();
  }

  /// 批量注册主题
  void registerAll(List<UIThemeProvider> themes) {
    for (var theme in themes) {
      register(theme);
    }
  }

  /// 注销主题
  void unregister(String themeId) {
    if (_themes.remove(themeId) != null) {
      debugPrint('[ThemeRegistry] 主题已注销: $themeId');
      if (_activeThemeId == themeId) {
        _activeThemeId = null;
      }
      notifyListeners();
    }
  }

  /// 获取主题
  UIThemeProvider? getTheme(String themeId) {
    return _themes[themeId];
  }

  /// 获取当前激活的主题
  UIThemeProvider? get activeTheme {
    if (_activeThemeId == null) return null;
    return _themes[_activeThemeId];
  }

  /// 设置激活的主题
  void setActiveTheme(String themeId) {
    if (!_themes.containsKey(themeId)) {
      debugPrint('[ThemeRegistry] 主题不存在: $themeId');
      return;
    }
    _activeThemeId = themeId;
    debugPrint('[ThemeRegistry] 切换主题: $themeId');
    notifyListeners();
  }

  /// 获取所有可用主题
  List<UIThemeProvider> get availableThemes {
    return _themes.values.toList();
  }

  /// 获取所有主题元数据
  List<ThemeMetadata> get availableThemesMetadata {
    return _themes.values.map((theme) => theme.metadata).toList();
  }

  /// 检查主题是否已注册
  bool hasTheme(String themeId) {
    return _themes.containsKey(themeId);
  }

  /// 获取主题数量
  int get themeCount => _themes.length;

  /// 清除所有主题
  void clear() {
    _themes.clear();
    _activeThemeId = null;
    notifyListeners();
  }
}

