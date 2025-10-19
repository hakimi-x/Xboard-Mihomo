# Default Theme - XBoard Mihomo 默认主题

XBoard Mihomo 的默认主题包，提供经典的Material Design 3风格UI。

## 特性

- ✅ Material Design 3 设计规范
- ✅ 完整的亮色/暗色主题支持
- ✅ 自定义主色调支持
- ✅ JetBrainsMono 字体
- ✅ 圆角卡片和对话框

## 使用方法

```dart
import 'package:default_theme/default_theme.dart';

// 在 MaterialApp 中使用
MaterialApp(
  theme: DefaultTheme.buildLightTheme(context),
  darkTheme: DefaultTheme.buildDarkTheme(context),
  themeMode: ThemeMode.system,
  // ...
)

// 使用自定义主色调
MaterialApp(
  theme: DefaultTheme.buildLightTheme(
    context, 
    primaryColor: 0xFF554DAF,
  ),
  // ...
)
```

## 配置

### 颜色

默认主色调：`#554DAF` (柔和深蓝紫色)

### 字体

- 主字体：JetBrainsMono
- 表情符号：Twemoji

### 圆角

- 卡片：12px
- 对话框：28px

## 自定义

如果需要自定义主题，可以：

1. 继承 `DefaultTheme` 类
2. 覆写需要自定义的部分
3. 保持与 Material Design 3 的一致性

## License

与 XBoard Mihomo 项目相同

