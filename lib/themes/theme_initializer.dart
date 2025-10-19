/// 主题初始化器
/// 在应用启动时注册所有可用的主题包
library;

import 'package:fl_clash/themes/theme_manager_widget.dart';
import 'package:flutter/material.dart';

/// 主题初始化器
class ThemeInitializer {
  static bool _initialized = false;

  /// 初始化所有主题包
  static Future<void> initialize() async {
    if (_initialized) {
      debugPrint('[ThemeInitializer] 主题已初始化，跳过');
      return;
    }

    debugPrint('[ThemeInitializer] 开始初始化主题包...');

    // 在这里注册所有可用的主题包
    // 注意：需要先在 pubspec.yaml 中添加依赖

    // 注册默认主题
    _registerDefaultTheme();

    // 注册现代主题
    _registerModernTheme();

    // 可以在这里添加更多主题包的注册

    _initialized = true;
    debugPrint('[ThemeInitializer] 主题包初始化完成，共 ${AppThemeManager.availableThemes.length} 个主题');
  }

  /// 注册默认主题（内置）
  static void _registerDefaultTheme() {
    AppThemeManager.registerTheme(
      ThemePackageConfig(
        id: 'default',
        name: '默认主题',
        description: 'XBoard Mihomo 经典默认主题',
        lightThemeBuilder: (context, {int? primaryColor}) {
          // 使用当前的主题生成逻辑
          return ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor != null 
                  ? Color(primaryColor) 
                  : const Color(0xFF554DAF),
              brightness: Brightness.light,
            ),
            textTheme: const TextTheme(
              displayLarge: TextStyle(fontFamily: 'JetBrainsMono'),
              displayMedium: TextStyle(fontFamily: 'JetBrainsMono'),
              displaySmall: TextStyle(fontFamily: 'JetBrainsMono'),
              headlineLarge: TextStyle(fontFamily: 'JetBrainsMono'),
              headlineMedium: TextStyle(fontFamily: 'JetBrainsMono'),
              headlineSmall: TextStyle(fontFamily: 'JetBrainsMono'),
              titleLarge: TextStyle(fontFamily: 'JetBrainsMono'),
              titleMedium: TextStyle(fontFamily: 'JetBrainsMono'),
              titleSmall: TextStyle(fontFamily: 'JetBrainsMono'),
              bodyLarge: TextStyle(fontFamily: 'JetBrainsMono'),
              bodyMedium: TextStyle(fontFamily: 'JetBrainsMono'),
              bodySmall: TextStyle(fontFamily: 'JetBrainsMono'),
            ),
            cardTheme: CardTheme(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
        darkThemeBuilder: (context, {int? primaryColor}) {
          return ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor != null 
                  ? Color(primaryColor) 
                  : const Color(0xFF554DAF),
              brightness: Brightness.dark,
            ),
            textTheme: const TextTheme(
              displayLarge: TextStyle(fontFamily: 'JetBrainsMono'),
              displayMedium: TextStyle(fontFamily: 'JetBrainsMono'),
              displaySmall: TextStyle(fontFamily: 'JetBrainsMono'),
              headlineLarge: TextStyle(fontFamily: 'JetBrainsMono'),
              headlineMedium: TextStyle(fontFamily: 'JetBrainsMono'),
              headlineSmall: TextStyle(fontFamily: 'JetBrainsMono'),
              titleLarge: TextStyle(fontFamily: 'JetBrainsMono'),
              titleMedium: TextStyle(fontFamily: 'JetBrainsMono'),
              titleSmall: TextStyle(fontFamily: 'JetBrainsMono'),
              bodyLarge: TextStyle(fontFamily: 'JetBrainsMono'),
              bodyMedium: TextStyle(fontFamily: 'JetBrainsMono'),
              bodySmall: TextStyle(fontFamily: 'JetBrainsMono'),
            ),
            cardTheme: CardTheme(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 注册现代主题（内置）
  static void _registerModernTheme() {
    AppThemeManager.registerTheme(
      ThemePackageConfig(
        id: 'modern',
        name: '现代主题',
        description: '现代化设计风格，更大的圆角和间距',
        lightThemeBuilder: (context, {int? primaryColor}) {
          return ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor != null 
                  ? Color(primaryColor) 
                  : const Color(0xFF6366F1),
              brightness: Brightness.light,
            ),
            cardTheme: CardTheme(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(12),
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              elevation: 8,
            ),
            filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                minimumSize: const Size(64, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          );
        },
        darkThemeBuilder: (context, {int? primaryColor}) {
          return ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor != null 
                  ? Color(primaryColor) 
                  : const Color(0xFF6366F1),
              brightness: Brightness.dark,
            ),
            cardTheme: CardTheme(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(12),
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              elevation: 8,
            ),
            filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                minimumSize: const Size(64, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 从外部包注册主题（示例）
  /// 
  /// 使用方式：
  /// ```dart
  /// import 'package:custom_theme/custom_theme.dart';
  /// 
  /// ThemeInitializer.registerExternalTheme(
  ///   id: 'custom',
  ///   name: '自定义主题',
  ///   description: '我的自定义主题',
  ///   lightBuilder: CustomTheme.buildLightTheme,
  ///   darkBuilder: CustomTheme.buildDarkTheme,
  /// );
  /// ```
  static void registerExternalTheme({
    required String id,
    required String name,
    required String description,
    required ThemeData Function(BuildContext context, {int? primaryColor}) lightBuilder,
    required ThemeData Function(BuildContext context, {int? primaryColor}) darkBuilder,
  }) {
    AppThemeManager.registerTheme(
      ThemePackageConfig(
        id: id,
        name: name,
        description: description,
        lightThemeBuilder: lightBuilder,
        darkThemeBuilder: darkBuilder,
      ),
    );
    debugPrint('[ThemeInitializer] 外部主题已注册: $name');
  }
}

