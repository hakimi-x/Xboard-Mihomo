/// UI主题提供者接口
/// 所有主题包都必须实现这个接口
library;

import 'package:flutter/material.dart';

/// 主题元数据
class ThemeMetadata {
  final String id;
  final String name;
  final String description;
  final String version;
  final String author;
  final String? preview;

  const ThemeMetadata({
    required this.id,
    required this.name,
    required this.description,
    required this.version,
    required this.author,
    this.preview,
  });
}

/// 主题配置
class ThemeConfig {
  final ColorScheme lightColorScheme;
  final ColorScheme darkColorScheme;
  final TextTheme textTheme;
  final AppBarTheme? appBarTheme;
  final CardTheme? cardTheme;
  final ButtonThemeData? buttonTheme;
  final InputDecorationTheme? inputDecorationTheme;
  final DialogTheme? dialogTheme;
  final Map<String, dynamic>? customProperties;

  const ThemeConfig({
    required this.lightColorScheme,
    required this.darkColorScheme,
    required this.textTheme,
    this.appBarTheme,
    this.cardTheme,
    this.buttonTheme,
    this.inputDecorationTheme,
    this.dialogTheme,
    this.customProperties,
  });
}

/// 主题提供者抽象类
/// 所有自定义主题都需要继承这个类
abstract class UIThemeProvider {
  /// 主题元数据
  ThemeMetadata get metadata;

  /// 获取主题配置
  ThemeConfig getThemeConfig();

  /// 构建亮色主题
  ThemeData buildLightTheme(BuildContext context) {
    final config = getThemeConfig();
    return ThemeData(
      useMaterial3: true,
      colorScheme: config.lightColorScheme,
      textTheme: config.textTheme,
      appBarTheme: config.appBarTheme,
      cardTheme: config.cardTheme,
      buttonTheme: config.buttonTheme,
      inputDecorationTheme: config.inputDecorationTheme,
      dialogTheme: config.dialogTheme,
    );
  }

  /// 构建暗色主题
  ThemeData buildDarkTheme(BuildContext context) {
    final config = getThemeConfig();
    return ThemeData(
      useMaterial3: true,
      colorScheme: config.darkColorScheme,
      textTheme: config.textTheme,
      appBarTheme: config.appBarTheme,
      cardTheme: config.cardTheme,
      buttonTheme: config.buttonTheme,
      inputDecorationTheme: config.inputDecorationTheme,
      dialogTheme: config.dialogTheme,
    );
  }

  /// 自定义组件构建器（可选）
  Widget? buildCustomWidget(String widgetType, Map<String, dynamic> props) {
    return null;
  }

  /// 获取自定义属性
  T? getCustomProperty<T>(String key) {
    final config = getThemeConfig();
    return config.customProperties?[key] as T?;
  }
}

