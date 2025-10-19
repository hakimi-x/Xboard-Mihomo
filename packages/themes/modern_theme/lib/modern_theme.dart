/// XBoard Mihomo 现代风格主题包
library modern_theme;

import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// 主题元数据
class ModernThemeMetadata {
  static const String id = 'modern';
  static const String name = '现代主题';
  static const String description = '现代化设计风格，更大的圆角和间距';
  static const String version = '1.0.0';
  static const String author = 'XBoard Mihomo Team';
}

/// 现代主题提供者
class ModernTheme {
  /// 主题元数据
  static Map<String, String> get metadata => {
    'id': ModernThemeMetadata.id,
    'name': ModernThemeMetadata.name,
    'description': ModernThemeMetadata.description,
    'version': ModernThemeMetadata.version,
    'author': ModernThemeMetadata.author,
  };

  /// 获取主题配置
  static ModernThemeConfig getThemeConfig() {
    return const ModernThemeConfig();
  }

  /// 构建亮色主题
  static ThemeData buildLightTheme(BuildContext context, {int? primaryColor}) {
    final config = getThemeConfig();
    return ThemeData(
      useMaterial3: true,
      colorScheme: config.getLightColorScheme(primaryColor),
      textTheme: config.textTheme,
      appBarTheme: config.appBarTheme,
      cardTheme: config.cardTheme,
      dialogTheme: config.dialogTheme,
      filledButtonTheme: config.filledButtonTheme,
      elevatedButtonTheme: config.elevatedButtonTheme,
    );
  }

  /// 构建暗色主题
  static ThemeData buildDarkTheme(BuildContext context, {int? primaryColor}) {
    final config = getThemeConfig();
    return ThemeData(
      useMaterial3: true,
      colorScheme: config.getDarkColorScheme(primaryColor),
      textTheme: config.textTheme,
      appBarTheme: config.appBarTheme,
      cardTheme: config.cardTheme,
      dialogTheme: config.dialogTheme,
      filledButtonTheme: config.filledButtonTheme,
      elevatedButtonTheme: config.elevatedButtonTheme,
    );
  }
}

/// 现代主题配置
class ModernThemeConfig {
  const ModernThemeConfig();

  /// 默认主色调 - 更鲜艳的蓝紫色
  static const Color defaultPrimaryColor = Color(0xFF6366F1);

  /// 获取亮色ColorScheme - 使用更鲜艳的配色方案
  ColorScheme getLightColorScheme(int? primaryColor) {
    return ColorScheme.fromSeed(
      seedColor: primaryColor != null ? Color(primaryColor) : defaultPrimaryColor,
      brightness: Brightness.light,
      dynamicSchemeVariant: DynamicSchemeVariant.vibrant, // 使用更鲜艳的方案
    );
  }

  /// 获取暗色ColorScheme
  ColorScheme getDarkColorScheme(int? primaryColor) {
    return ColorScheme.fromSeed(
      seedColor: primaryColor != null ? Color(primaryColor) : defaultPrimaryColor,
      brightness: Brightness.dark,
      dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
    );
  }

  /// 文本主题 - 使用系统字体，更现代的排版
  TextTheme get textTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 64, // 更大
        fontWeight: FontWeight.w700, // 更粗
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        fontSize: 52,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        fontSize: 18, // 更大的正文
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    );
  }

  /// Card主题 - 更大的圆角和阴影
  CardTheme get cardTheme {
    return CardTheme(
      elevation: 4, // 更明显的阴影
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // 更大的圆角
      ),
      margin: const EdgeInsets.all(12), // 更大的外边距
    );
  }

  /// AppBar主题 - 更现代的风格
  AppBarTheme get appBarTheme {
    return const AppBarTheme(
      elevation: 0,
      centerTitle: true, // 居中标题
      scrolledUnderElevation: 4,
    );
  }

  /// Dialog主题 - 更大的圆角
  DialogTheme get dialogTheme {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32), // 更大的圆角
      ),
      elevation: 8,
    );
  }

  /// FilledButton主题 - 更大的按钮
  FilledButtonThemeData get filledButtonTheme {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(64, 52), // 更大的按钮
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }

  /// ElevatedButton主题
  ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(64, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 2,
      ),
    );
  }
}

