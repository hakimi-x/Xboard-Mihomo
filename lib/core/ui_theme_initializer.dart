/// UI主题系统初始化器
/// 
/// 负责在应用启动时初始化UI主题系统

import 'package:default_ui/default_ui_theme.dart';
import 'package:modern_ui/modern_ui_theme.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UIThemeInitializer {
  static bool _initialized = false;

  /// 初始化UI主题系统
  /// 
  /// 此方法应该在 main() 函数中调用，在 runApp() 之前
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      // 1. 创建并注册主题包
      final defaultTheme = DefaultUITheme();
      final modernTheme = ModernUITheme();

      defaultTheme.register();
      modernTheme.register();

      // 2. 加载已保存的主题选择
      final prefs = await SharedPreferences.getInstance();
      final savedThemeId = prefs.getString('ui_theme_id') ?? 'default';

      // 3. 设置当前激活的主题
      UIRegistry().setActiveTheme(savedThemeId);

      _initialized = true;

      print('✅ UI主题系统初始化完成');
      print('   - 已注册主题: ${UIRegistry().availableThemes.join(", ")}');
      print('   - 当前主题: $savedThemeId');
    } catch (e) {
      print('❌ UI主题系统初始化失败: $e');
      
      // 即使失败也标记为已初始化，使用默认配置
      _initialized = true;
      
      // 设置默认主题
      UIRegistry().setActiveTheme('default');
    }
  }

  /// 检查是否已初始化
  static bool get isInitialized => _initialized;
}

