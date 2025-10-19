# XBoard UI 分离系统

## 简介

本项目实现了前后端分离式的 UI 主题系统，支持运行时动态切换不同的 UI 实现。

## 核心文件结构

```
lib/
├── core/
│   ├── controllers/xboard/        # 业务逻辑控制器
│   │   ├── login_page_controller.dart
│   │   ├── register_page_controller.dart
│   │   └── ...（9个页面控制器）
│   ├── providers/
│   │   └── ui_theme_provider.dart  # 主题状态管理
│   └── ui_theme_initializer.dart   # 主题初始化器
│
├── ui/
│   ├── contracts/                  # UI 契约层（接口定义）
│   │   ├── contract_base.dart
│   │   └── pages/xboard/           # XBoard 页面契约
│   ├── registry/
│   │   └── ui_registry.dart        # UI 注册中心
│   └── theme_package_base.dart     # 主题包基类
│
└── common/
    └── navigation.dart              # 主导航（已迁移到新系统）

packages/ui_themes/
├── default_ui/                      # 默认主题包
│   ├── lib/
│   │   ├── default_ui_theme.dart
│   │   └── pages/xboard/            # 9个页面实现
│   └── pubspec.yaml
│
└── modern_ui/                       # 现代主题包
    ├── lib/
    │   ├── modern_ui_theme.dart
    │   └── pages/xboard/            # 9个页面实现
    └── pubspec.yaml

docs/
├── XBOARD_UI_SEPARATION_README.md   # 系统概述
└── UI_SEPARATION_INTEGRATION_COMPLETE.md  # 集成说明
```

## 已迁移的页面

| 模块 | 页面 | Controller | 状态 |
|-----|------|-----------|------|
| Auth | 登录 | LoginPageController | ✅ |
| Auth | 注册 | RegisterPageController | ✅ |
| Auth | 忘记密码 | ForgotPasswordPageController | ✅ |
| Subscription | XBoard首页 | XBoardHomePageController | ✅ |
| Subscription | 订阅管理 | SubscriptionPageController | ✅ |
| Payment | 套餐购买 | PlanPurchasePageController | ✅ |
| Payment | 支付网关 | PaymentGatewayPageController | ✅ |
| Invite | 邀请管理 | InvitePageController | ✅ |
| Support | 在线客服 | OnlineSupportPageController | ✅ |

## 如何使用

### 1. 导航到页面

```dart
import 'package:fl_clash/core/controllers/xboard/xboard_controllers.dart';

// 使用 Controller 导航
Navigator.push(context, MaterialPageRoute(
  builder: (_) => const LoginPageController(),
));
```

### 2. 切换主题

在 **XBoard 首页右上角** 点击 🎨 图标选择主题：
- **Default UI**: Material Design 3 风格
- **Modern UI**: 大圆角 + 渐变背景

### 3. 添加新主题

1. 在 `packages/ui_themes/` 创建新主题包
2. 实现所有页面的契约接口
3. 在 `UIThemeInitializer` 中注册新主题

## 架构优势

- ✅ **UI 与逻辑分离**: 业务逻辑在 Controller，UI 在主题包
- ✅ **动态主题切换**: 运行时切换，无需重启
- ✅ **可扩展**: 轻松添加新主题
- ✅ **类型安全**: 通过契约接口保证类型安全
- ✅ **代码整洁**: 职责清晰，易于维护

## 技术栈

- Flutter 3.x
- Riverpod 状态管理
- UI Registry 模式
- Contract 接口模式

---

*更新时间: 2025-10-19*

