// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 主题包
// ═══════════════════════════════════════════════════════
// 这是UI分离重构后的默认主题包
// 基于原有UI风格，保持一致的用户体验
// ═══════════════════════════════════════════════════════

library default_ui;

import 'package:fl_clash/ui/theme_package_base.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:default_ui/pages/xboard/auth/default_login_page.dart';
import 'package:default_ui/pages/xboard/auth/default_register_page.dart';
import 'package:default_ui/pages/xboard/auth/default_forgot_password_page.dart';
import 'package:default_ui/pages/xboard/subscription/default_xboard_home_page.dart';
import 'package:default_ui/pages/xboard/subscription/default_subscription_page.dart';
import 'package:default_ui/pages/xboard/payment/default_plan_purchase_page.dart';
import 'package:default_ui/pages/xboard/payment/default_payment_gateway_page.dart';
import 'package:default_ui/pages/xboard/invite/default_invite_page.dart';
import 'package:default_ui/pages/xboard/online_support/default_online_support_page.dart';

export 'pages/xboard/auth/default_login_page.dart';
export 'pages/xboard/auth/default_register_page.dart';
export 'pages/xboard/auth/default_forgot_password_page.dart';
export 'pages/xboard/subscription/default_xboard_home_page.dart';
export 'pages/xboard/subscription/default_subscription_page.dart';
export 'pages/xboard/payment/default_plan_purchase_page.dart';
export 'pages/xboard/payment/default_payment_gateway_page.dart';
export 'pages/xboard/invite/default_invite_page.dart';
export 'pages/xboard/online_support/default_online_support_page.dart';

/// DefaultUI 主题包
class DefaultUITheme extends ThemePackageBase {
  @override
  ThemePackageMetadata get metadata => const ThemePackageMetadata(
        id: 'default',
        name: '默认主题',
        description: '经典的 Material Design 风格，简洁实用',
        version: '1.0.0',
        author: 'XBoard Mihomo Team',
        tags: ['material', 'classic', 'simple'],
      );

  @override
  void register() {
    final registry = UIRegistry();

    // XBoard Auth 模块
    registry.registerPage<LoginPageContract>(
      themeId: metadata.id,
      pageType: LoginPageContract,
      builder: (data, callbacks) => DefaultLoginPage(
        data: data as LoginPageData,
        callbacks: callbacks as LoginPageCallbacks,
      ),
    );
    registry.registerPage<RegisterPageContract>(
      themeId: metadata.id,
      pageType: RegisterPageContract,
      builder: (data, callbacks) => DefaultRegisterPage(
        data: data as RegisterPageData,
        callbacks: callbacks as RegisterPageCallbacks,
      ),
    );
    registry.registerPage<ForgotPasswordPageContract>(
      themeId: metadata.id,
      pageType: ForgotPasswordPageContract,
      builder: (data, callbacks) => DefaultForgotPasswordPage(
        data: data as ForgotPasswordPageData,
        callbacks: callbacks as ForgotPasswordPageCallbacks,
      ),
    );

    // XBoard Subscription 模块
    registry.registerPage<XBoardHomePageContract>(
      themeId: metadata.id,
      pageType: XBoardHomePageContract,
      builder: (data, callbacks) => DefaultXBoardHomePage(
        data: data as XBoardHomePageData,
        callbacks: callbacks as XBoardHomePageCallbacks,
      ),
    );
    registry.registerPage<SubscriptionPageContract>(
      themeId: metadata.id,
      pageType: SubscriptionPageContract,
      builder: (data, callbacks) => DefaultSubscriptionPage(
        data: data as SubscriptionPageData,
        callbacks: callbacks as SubscriptionPageCallbacks,
      ),
    );

    // XBoard Payment 模块
    registry.registerPage<PlanPurchasePageContract>(
      themeId: metadata.id,
      pageType: PlanPurchasePageContract,
      builder: (data, callbacks) => DefaultPlanPurchasePage(
        data: data as PlanPurchasePageData,
        callbacks: callbacks as PlanPurchasePageCallbacks,
      ),
    );
    registry.registerPage<PaymentGatewayPageContract>(
      themeId: metadata.id,
      pageType: PaymentGatewayPageContract,
      builder: (data, callbacks) => DefaultPaymentGatewayPage(
        data: data as PaymentGatewayPageData,
        callbacks: callbacks as PaymentGatewayPageCallbacks,
      ),
    );

    // XBoard Invite 模块
    registry.registerPage<InvitePageContract>(
      themeId: metadata.id,
      pageType: InvitePageContract,
      builder: (data, callbacks) => DefaultInvitePage(
        data: data as InvitePageData,
        callbacks: callbacks as InvitePageCallbacks,
      ),
    );

    // XBoard OnlineSupport 模块
    registry.registerPage<OnlineSupportPageContract>(
      themeId: metadata.id,
      pageType: OnlineSupportPageContract,
      builder: (data, callbacks) => DefaultOnlineSupportPage(
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

