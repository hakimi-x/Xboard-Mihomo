# Modern Theme - XBoard Mihomo 现代主题

XBoard Mihomo 的现代风格主题包，提供更时尚的UI设计。

## 特性

- ✅ 更鲜艳的配色方案
- ✅ 更大的圆角（20px卡片，32px对话框）
- ✅ 更粗的字体权重
- ✅ 更大的按钮和间距
- ✅ 更明显的阴影效果
- ✅ 系统字体支持

## 使用方法

```dart
import 'package:modern_theme/modern_theme.dart';

// 在 MaterialApp 中使用
MaterialApp(
  theme: ModernTheme.buildLightTheme(context),
  darkTheme: ModernTheme.buildDarkTheme(context),
  themeMode: ThemeMode.system,
  // ...
)
```

## 设计理念

### 视觉层次

现代主题强调**视觉层次和可读性**：

- 更大的标题字号
- 更粗的字体权重
- 更明显的阴影效果
- 更大的点击区域

### 圆角设计

采用**更柔和的圆角**设计：

- 卡片：20px
- 对话框：32px
- 按钮：16px

### 配色方案

使用 **Vibrant** 动态配色方案，提供：

- 更鲜艳的色彩
- 更高的对比度
- 更现代的视觉效果

## 对比

| 特性 | 默认主题 | 现代主题 |
|------|---------|---------|
| 卡片圆角 | 12px | 20px |
| 对话框圆角 | 28px | 32px |
| 按钮高度 | 默认 | 52px |
| 配色方案 | TonalSpot | Vibrant |
| 字体 | JetBrainsMono | 系统字体 |
| 标题权重 | 400-500 | 600-700 |

## License

与 XBoard Mihomo 项目相同

