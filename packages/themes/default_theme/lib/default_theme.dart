/// XBoard Mihomo 默认主题包
library default_theme;

import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// 主题元数据
class DefaultThemeMetadata {
  static const String id = 'default';
  static const String name = '默认主题';
  static const String description = 'XBoard Mihomo 经典默认主题';
  static const String version = '1.0.0';
  static const String author = 'XBoard Mihomo Team';
}

/// 默认主题提供者
class DefaultTheme {
  /// 主题元数据
  static Map<String, String> get metadata => {
    'id': DefaultThemeMetadata.id,
    'name': DefaultThemeMetadata.name,
    'description': DefaultThemeMetadata.description,
    'version': DefaultThemeMetadata.version,
    'author': DefaultThemeMetadata.author,
  };

  /// 获取主题配置
  static DefaultThemeConfig getThemeConfig() {
    return const DefaultThemeConfig();
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
    );
  }
}

/// 默认主题配置
class DefaultThemeConfig {
  const DefaultThemeConfig();

  /// 默认主色调
  static const Color defaultPrimaryColor = Color(0xFF554DAF);

  /// 获取亮色ColorScheme
  ColorScheme getLightColorScheme(int? primaryColor) {
    return ColorScheme.fromSeed(
      seedColor: primaryColor != null ? Color(primaryColor) : defaultPrimaryColor,
      brightness: Brightness.light,
      dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
    );
  }

  /// 获取暗色ColorScheme
  ColorScheme getDarkColorScheme(int? primaryColor) {
    return ColorScheme.fromSeed(
      seedColor: primaryColor != null ? Color(primaryColor) : defaultPrimaryColor,
      brightness: Brightness.dark,
      dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
    );
  }

  /// 文本主题
  TextTheme get textTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 36,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 28,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    );
  }

  /// Card主题
  CardTheme get cardTheme {
    return CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  /// AppBar主题
  AppBarTheme get appBarTheme {
    return const AppBarTheme(
      elevation: 0,
      centerTitle: false,
    );
  }

  /// Dialog主题
  DialogTheme get dialogTheme {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
    );
  }
}

