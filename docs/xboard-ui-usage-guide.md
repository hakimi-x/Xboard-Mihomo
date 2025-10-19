# XBoard UI 分离系统 - 使用指南

## 📖 简介

本指南说明如何使用新的 UI 分离系统，以及如何将其集成到现有的 XBoard 应用中。

## 🎯 核心概念

### 1. 三层架构

```
┌─────────────────────────────────────┐
│   UI 实现层（DefaultUI / ModernUI）  │  ← 可替换
├─────────────────────────────────────┤
│   UI 契约层（Contracts）             │  ← 接口定义
├─────────────────────────────────────┤
│   业务逻辑层（Controllers）          │  ← 数据处理
└─────────────────────────────────────┘
```

### 2. 数据流

```
Provider → Controller → Data → Contract → UI Implementation
                    ↓
                Callbacks ← User Actions
```

## 🚀 快速开始

### 步骤 1：初始化主题系统

在 `lib/main.dart` 中初始化：

```dart
import 'package:default_ui/default_ui_theme.dart';
import 'package:modern_ui/modern_ui_theme.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. 安装主题包
  final defaultTheme = DefaultUITheme();
  final modernTheme = ModernUITheme();
  
  defaultTheme.register();
  modernTheme.register();
  
  // 2. 设置当前主题（从存储加载）
  final prefs = await SharedPreferences.getInstance();
  final themeId = prefs.getString('current_theme') ?? 'default';
  UIRegistry().setActiveTheme(themeId);
  
  runApp(const MyApp());
}
```

### 步骤 2：配置路由

修改路由配置，使用新的 Controller：

```dart
// lib/routes/routes.dart

import 'package:fl_clash/core/controllers/xboard/xboard_controllers.dart';

final routes = <String, WidgetBuilder>{
  '/login': (context) => const LoginPageController(),
  '/register': (context) => const RegisterPageController(),
  '/forgot_password': (context) => const ForgotPasswordPageController(),
  '/xboard_home': (context) => const XBoardHomePageController(),
  '/subscription': (context) => const SubscriptionPageController(),
  '/plan_purchase': (context) => const PlanPurchasePageController(),
  '/payment_gateway': (context) => const PaymentGatewayPageController(orderId: ''),
  '/invite': (context) => const InvitePageController(),
  '/online_support': (context) => const OnlineSupportPageController(),
};
```

### 步骤 3：添加主题切换功能

在设置页面添加主题选择：

```dart
// lib/features/settings/settings_page.dart

class SettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        ListTile(
          title: const Text('UI 主题'),
          subtitle: const Text('切换应用外观'),
          trailing: DropdownButton<String>(
            value: UIRegistry().activeThemeId,
            items: const [
              DropdownMenuItem(value: 'default', child: Text('默认主题')),
              DropdownMenuItem(value: 'modern', child: Text('现代主题')),
            ],
            onChanged: (themeId) async {
              if (themeId != null) {
                // 1. 切换主题
                UIRegistry().setActiveTheme(themeId);
                
                // 2. 保存选择
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('current_theme', themeId);
                
                // 3. 重新构建应用（可选）
                // 或者使用 setState/Provider 触发重建
              }
            },
          ),
        ),
      ],
    );
  }
}
```

## 📝 创建新页面

### 1. 定义契约

```dart
// lib/ui/contracts/pages/my_page_contract.dart

abstract class MyPageContract extends PageContract<MyPageData, MyPageCallbacks> {
  const MyPageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

class MyPageData implements DataModel {
  final String title;
  final bool isLoading;
  
  const MyPageData({
    required this.title,
    this.isLoading = false,
  });
  
  @override
  Map<String, dynamic> toMap() => {
    'title': title,
    'isLoading': isLoading,
  };
}

class MyPageCallbacks implements CallbacksModel {
  final VoidCallback onAction;
  
  const MyPageCallbacks({required this.onAction});
}
```

### 2. 实现 DefaultUI

```dart
// packages/ui_themes/default_ui/lib/pages/my_page/default_my_page.dart

// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 我的页面
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class DefaultMyPage extends MyPageContract {
  const DefaultMyPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data.title)),
      body: Center(
        child: ElevatedButton(
          onPressed: callbacks.onAction,
          child: const Text('Action'),
        ),
      ),
    );
  }
}
```

### 3. 实现 ModernUI

```dart
// packages/ui_themes/modern_ui/lib/pages/my_page/modern_my_page.dart

// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 我的页面
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class ModernMyPage extends MyPageContract {
  const ModernMyPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
            ],
          ),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(data.title, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: callbacks.onAction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text('Action'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### 4. 注册到主题包

```dart
// packages/ui_themes/default_ui/lib/default_ui_theme.dart

@override
void register() {
  final registry = UIRegistry();
  
  // ... 其他页面注册
  
  registry.registerPage<MyPageContract>(
    themeId: metadata.id,
    pageType: MyPageContract,
    builder: (data, callbacks) => DefaultMyPage(
      data: data as MyPageData,
      callbacks: callbacks as MyPageCallbacks,
    ),
  );
}
```

### 5. 创建控制器

```dart
// lib/core/controllers/my_page_controller.dart

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPageController extends ConsumerWidget {
  const MyPageController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 准备数据
    final data = const MyPageData(
      title: 'My Page',
      isLoading: false,
    );
    
    // 2. 准备回调
    final callbacks = MyPageCallbacks(
      onAction: () {
        print('Action triggered');
      },
    );
    
    // 3. 使用 UIRegistry 构建
    return UIRegistry().buildPage<MyPageContract>(
      data: data,
      callbacks: callbacks,
    );
  }
}
```

## 🎨 主题特点对比

| 特性 | DefaultUI | ModernUI |
|------|-----------|----------|
| 设计语言 | Material Design 3 | 现代化设计 |
| 圆角 | 12px | 20-32px |
| 背景 | 纯色 | 渐变 + 毛玻璃 |
| 按钮 | 标准 | 渐变 + 阴影 |
| 动画 | 基础 | 丰富 |
| 适用场景 | 商务、传统 | 时尚、年轻 |

## 🔧 常见问题

### Q1: 如何调试主题切换？

```dart
// 在任何地方检查当前主题
print('Current theme: ${UIRegistry().activeThemeId}');

// 检查已注册的主题
print('Available themes: ${UIRegistry().availableThemes}');
```

### Q2: 如何为特定页面使用不同主题？

```dart
// 在 Controller 中临时切换
final originalTheme = UIRegistry().activeThemeId;
UIRegistry().setActiveTheme('modern');

final widget = UIRegistry().buildPage<MyPageContract>(...);

// 恢复
UIRegistry().setActiveTheme(originalTheme);
```

### Q3: 新的 UI 实现如何识别？

所有新创建的 UI 实现文件都有明显的标记：

```dart
// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI XXX页面
// ═══════════════════════════════════════════════════════
```

## 📊 性能优化

### 1. 延迟加载主题

```dart
// 只在需要时加载 ModernUI
if (themeId == 'modern') {
  final modernTheme = ModernUITheme();
  modernTheme.register();
}
```

### 2. 缓存构建结果

```dart
// 在 Controller 中缓存
final _cachedWidget = useMemoized(
  () => UIRegistry().buildPage<MyPageContract>(...),
  [data, callbacks],
);
```

## 🧪 测试

### 单元测试契约

```dart
test('MyPageData should serialize correctly', () {
  final data = MyPageData(title: 'Test', isLoading: true);
  final map = data.toMap();
  
  expect(map['title'], 'Test');
  expect(map['isLoading'], true);
});
```

### Widget 测试

```dart
testWidgets('DefaultMyPage should render', (tester) async {
  final data = MyPageData(title: 'Test');
  final callbacks = MyPageCallbacks(onAction: () {});
  
  await tester.pumpWidget(
    MaterialApp(
      home: DefaultMyPage(data: data, callbacks: callbacks),
    ),
  );
  
  expect(find.text('Test'), findsOneWidget);
});
```

## 📚 更多资源

- [UI 分离架构文档](./ui-separation-architecture.md)
- [UI 分离实现逻辑](./ui-separation-logic.md)
- [实施进度报告](./xboard-ui-implementation-progress.md)
- [重构路线图](./refactoring-roadmap.md)

## 💡 最佳实践

1. **Contract 优先**：先定义契约，再实现 UI
2. **保持简洁**：Data 和 Callbacks 只包含必要信息
3. **类型安全**：充分利用 Dart 的类型系统
4. **注释清晰**：为复杂的业务逻辑添加注释
5. **一致性**：同一功能在不同主题中保持一致的交互逻辑

## 🤝 贡献新主题

1. 创建新的主题包目录：`packages/ui_themes/my_theme/`
2. 实现所有页面契约
3. 创建 `MyTheme extends ThemePackageBase`
4. 注册所有页面
5. 在文档中添加主题说明

---

**祝您使用愉快！🎉**

如有问题，请参考文档或提交 Issue。

