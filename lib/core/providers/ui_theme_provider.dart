/// UI主题Provider
/// 
/// 管理当前激活的UI主题

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';

/// 主题ID状态Provider
class UIThemeNotifier extends StateNotifier<String> {
  UIThemeNotifier() : super('default') {
    _loadTheme();
  }

  static const String _themeKey = 'ui_theme_id';

  /// 加载已保存的主题
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString(_themeKey);
      
      if (savedTheme != null && savedTheme.isNotEmpty) {
        state = savedTheme;
        UIRegistry().setActiveTheme(savedTheme);
      }
    } catch (e) {
      // 忽略加载错误，使用默认主题
    }
  }

  /// 切换主题
  Future<void> setTheme(String themeId) async {
    if (state == themeId) return;

    try {
      // 1. 更新注册表
      UIRegistry().setActiveTheme(themeId);
      
      // 2. 更新状态
      state = themeId;
      
      // 3. 持久化
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, themeId);
    } catch (e) {
      // 处理错误
      rethrow;
    }
  }

  /// 获取可用主题列表
  List<String> get availableThemes => UIRegistry().availableThemes;
  
  /// 获取主题显示名称
  String getThemeDisplayName(String themeId) {
    switch (themeId) {
      case 'default':
        return '默认主题';
      case 'modern':
        return '现代主题';
      default:
        return themeId;
    }
  }
  
  /// 获取主题描述
  String getThemeDescription(String themeId) {
    switch (themeId) {
      case 'default':
        return '经典的 Material Design 风格，简洁实用';
      case 'modern':
        return '现代化设计风格，大圆角、毛玻璃效果、渐变背景';
      default:
        return '';
    }
  }
}

/// UI主题Provider
final uiThemeProvider = StateNotifierProvider<UIThemeNotifier, String>(
  (ref) => UIThemeNotifier(),
);

