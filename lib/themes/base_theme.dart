/// 基础主题实现
/// 提供默认的主题配置和工具方法
library;

import 'package:fl_clash/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// 基础主题类
/// 其他主题可以继承这个类来快速实现自定义主题
abstract class BaseUITheme extends UIThemeProvider {
  /// 从单个颜色生成完整的ColorScheme
  ColorScheme generateColorScheme({
    required Color seedColor,
    required Brightness brightness,
    DynamicSchemeVariant variant = DynamicSchemeVariant.tonalSpot,
  }) {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
      dynamicSchemeVariant: variant,
    );
  }

  /// 创建自定义TextTheme
  TextTheme createTextTheme({
    String? fontFamily,
    double? scale,
  }) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 57 * (scale ?? 1.0),
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 45 * (scale ?? 1.0),
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36 * (scale ?? 1.0),
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32 * (scale ?? 1.0),
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28 * (scale ?? 1.0),
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24 * (scale ?? 1.0),
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22 * (scale ?? 1.0),
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16 * (scale ?? 1.0),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14 * (scale ?? 1.0),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16 * (scale ?? 1.0),
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14 * (scale ?? 1.0),
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12 * (scale ?? 1.0),
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14 * (scale ?? 1.0),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12 * (scale ?? 1.0),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11 * (scale ?? 1.0),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }

  /// 创建CardTheme
  CardTheme createCardTheme({
    double? elevation,
    double? borderRadius,
  }) {
    return CardTheme(
      elevation: elevation ?? 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
      ),
    );
  }

  /// 创建AppBarTheme
  AppBarTheme createAppBarTheme({
    double? elevation,
    bool? centerTitle,
  }) {
    return AppBarTheme(
      elevation: elevation ?? 0,
      centerTitle: centerTitle ?? false,
    );
  }

  /// 创建DialogTheme
  DialogTheme createDialogTheme({
    double? borderRadius,
  }) {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 28),
      ),
    );
  }
}

