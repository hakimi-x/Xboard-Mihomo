// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 主题包
// ═══════════════════════════════════════════════════════
// 这是UI分离重构后的现代风格主题包
// 特点：大圆角、毛玻璃、渐变、动画
// ═══════════════════════════════════════════════════════

library modern_ui;

import 'package:fl_clash/ui/theme_package_base.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:modern_ui/pages/xboard/auth/modern_login_page.dart';
import 'package:modern_ui/pages/xboard/auth/modern_register_page.dart';
import 'package:modern_ui/pages/xboard/auth/modern_forgot_password_page.dart';
import 'package:modern_ui/pages/xboard/subscription/modern_xboard_home_page.dart';
import 'package:modern_ui/pages/xboard/subscription/modern_subscription_page.dart';
import 'package:modern_ui/pages/xboard/payment/modern_plan_purchase_page.dart';
import 'package:modern_ui/pages/xboard/payment/modern_payment_gateway_page.dart';
import 'package:modern_ui/pages/xboard/invite/modern_invite_page.dart';
import 'package:modern_ui/pages/xboard/online_support/modern_online_support_page.dart';

export 'pages/xboard/auth/modern_login_page.dart';
export 'pages/xboard/auth/modern_register_page.dart';
export 'pages/xboard/auth/modern_forgot_password_page.dart';
export 'pages/xboard/subscription/modern_xboard_home_page.dart';
export 'pages/xboard/subscription/modern_subscription_page.dart';
export 'pages/xboard/payment/modern_plan_purchase_page.dart';
export 'pages/xboard/payment/modern_payment_gateway_page.dart';
export 'pages/xboard/invite/modern_invite_page.dart';
export 'pages/xboard/online_support/modern_online_support_page.dart';

/// ModernUI 主题包
class ModernUITheme extends ThemePackageBase {
  @override
  ThemePackageMetadata get metadata => const ThemePackageMetadata(
        id: 'modern',
        name: '现代主题',
        description: '现代化设计风格，大圆角、毛玻璃效果、渐变背景',
        version: '1.0.0',
        author: 'XBoard Mihomo Team',
        tags: ['modern', 'gradient', 'glass', 'rounded'],
      );

  @override
  void register() {
    final registry = UIRegistry();

    // XBoard Auth 模块
    registry.registerPage<LoginPageContract>(
      themeId: metadata.id,
      pageType: LoginPageContract,
      builder: (data, callbacks) => ModernLoginPage(
        data: data as LoginPageData,
        callbacks: callbacks as LoginPageCallbacks,
      ),
    );
    registry.registerPage<RegisterPageContract>(
      themeId: metadata.id,
      pageType: RegisterPageContract,
      builder: (data, callbacks) => ModernRegisterPage(
        data: data as RegisterPageData,
        callbacks: callbacks as RegisterPageCallbacks,
      ),
    );
    registry.registerPage<ForgotPasswordPageContract>(
      themeId: metadata.id,
      pageType: ForgotPasswordPageContract,
      builder: (data, callbacks) => ModernForgotPasswordPage(
        data: data as ForgotPasswordPageData,
        callbacks: callbacks as ForgotPasswordPageCallbacks,
      ),
    );

    // XBoard Subscription 模块
    registry.registerPage<XBoardHomePageContract>(
      themeId: metadata.id,
      pageType: XBoardHomePageContract,
      builder: (data, callbacks) => ModernXBoardHomePage(
        data: data as XBoardHomePageData,
        callbacks: callbacks as XBoardHomePageCallbacks,
      ),
    );
    registry.registerPage<SubscriptionPageContract>(
      themeId: metadata.id,
      pageType: SubscriptionPageContract,
      builder: (data, callbacks) => ModernSubscriptionPage(
        data: data as SubscriptionPageData,
        callbacks: callbacks as SubscriptionPageCallbacks,
      ),
    );

    // XBoard Payment 模块
    registry.registerPage<PlanPurchasePageContract>(
      themeId: metadata.id,
      pageType: PlanPurchasePageContract,
      builder: (data, callbacks) => ModernPlanPurchasePage(
        data: data as PlanPurchasePageData,
        callbacks: callbacks as PlanPurchasePageCallbacks,
      ),
    );
    registry.registerPage<PaymentGatewayPageContract>(
      themeId: metadata.id,
      pageType: PaymentGatewayPageContract,
      builder: (data, callbacks) => ModernPaymentGatewayPage(
        data: data as PaymentGatewayPageData,
        callbacks: callbacks as PaymentGatewayPageCallbacks,
      ),
    );

    // XBoard Invite 模块
    registry.registerPage<InvitePageContract>(
      themeId: metadata.id,
      pageType: InvitePageContract,
      builder: (data, callbacks) => ModernInvitePage(
        data: data as InvitePageData,
        callbacks: callbacks as InvitePageCallbacks,
      ),
    );

    // XBoard OnlineSupport 模块
    registry.registerPage<OnlineSupportPageContract>(
      themeId: metadata.id,
      pageType: OnlineSupportPageContract,
      builder: (data, callbacks) => ModernOnlineSupportPage(
        data: data as OnlineSupportPageData,
        callbacks: callbacks as OnlineSupportPageCallbacks,
      ),
    );

    // TODO: 注册其他页面
    // registry.registerPage<ProfilesPageContract>(...)
    // registry.registerPage<ProxiesPageContract>(...)
    // registry.registerPage<SettingsPageContract>(...)
  }
}

