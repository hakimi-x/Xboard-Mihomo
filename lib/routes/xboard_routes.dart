/// XBoard 路由配置
/// 
/// 定义所有 XBoard 相关页面的路由

import 'package:fl_clash/core/controllers/xboard/xboard_controllers.dart';
import 'package:flutter/material.dart';

/// XBoard 路由路径常量
class XBoardRoutes {
  // Auth 模块
  static const String login = '/xboard/login';
  static const String register = '/xboard/register';
  static const String forgotPassword = '/xboard/forgot_password';
  
  // Subscription 模块
  static const String home = '/xboard/home';
  static const String subscription = '/xboard/subscription';
  
  // Payment 模块
  static const String planPurchase = '/xboard/plan_purchase';
  static const String paymentGateway = '/xboard/payment_gateway';
  
  // Invite 模块
  static const String invite = '/xboard/invite';
  
  // OnlineSupport 模块
  static const String onlineSupport = '/xboard/online_support';
}

/// XBoard 路由映射
/// 
/// 使用示例：
/// ```dart
/// final routes = {
///   ...xboardRoutes,
///   // 其他路由
/// };
/// ```
final Map<String, WidgetBuilder> xboardRoutes = {
  // Auth 模块
  XBoardRoutes.login: (context) => const LoginPageController(),
  XBoardRoutes.register: (context) => const RegisterPageController(),
  XBoardRoutes.forgotPassword: (context) => const ForgotPasswordPageController(),
  
  // Subscription 模块
  XBoardRoutes.home: (context) => const XBoardHomePageController(),
  XBoardRoutes.subscription: (context) => const SubscriptionPageController(),
  
  // Payment 模块
  XBoardRoutes.planPurchase: (context) => const PlanPurchasePageController(),
  // Payment Gateway 需要参数，使用 onGenerateRoute
  
  // Invite 模块
  XBoardRoutes.invite: (context) => const InvitePageController(),
  
  // OnlineSupport 模块
  XBoardRoutes.onlineSupport: (context) => const OnlineSupportPageController(),
};

/// XBoard 路由生成器
/// 
/// 处理需要参数的路由
Route<dynamic>? generateXBoardRoute(RouteSettings settings) {
  switch (settings.name) {
    case XBoardRoutes.paymentGateway:
      // 从参数中获取 orderId
      final args = settings.arguments as Map<String, dynamic>?;
      final orderId = args?['orderId'] as String? ?? '';
      
      return MaterialPageRoute(
        builder: (context) => PaymentGatewayPageController(orderId: orderId),
        settings: settings,
      );
    
    default:
      return null;
  }
}

/// 导航辅助方法
class XBoardNavigator {
  /// 导航到登录页
  static Future<void> toLogin(BuildContext context) {
    return Navigator.pushNamed(context, XBoardRoutes.login);
  }

  /// 导航到注册页
  static Future<void> toRegister(BuildContext context) {
    return Navigator.pushNamed(context, XBoardRoutes.register);
  }

  /// 导航到忘记密码页
  static Future<void> toForgotPassword(BuildContext context) {
    return Navigator.pushNamed(context, XBoardRoutes.forgotPassword);
  }

  /// 导航到XBoard首页
  static Future<void> toHome(BuildContext context) {
    return Navigator.pushNamed(context, XBoardRoutes.home);
  }

  /// 导航到XBoard首页（清除历史）
  static Future<void> toHomeAndClearHistory(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      XBoardRoutes.home,
      (route) => false,
    );
  }

  /// 导航到订阅管理
  static Future<void> toSubscription(BuildContext context) {
    return Navigator.pushNamed(context, XBoardRoutes.subscription);
  }

  /// 导航到套餐购买
  static Future<void> toPlanPurchase(BuildContext context) {
    return Navigator.pushNamed(context, XBoardRoutes.planPurchase);
  }

  /// 导航到支付网关
  static Future<void> toPaymentGateway(BuildContext context, String orderId) {
    return Navigator.pushNamed(
      context,
      XBoardRoutes.paymentGateway,
      arguments: {'orderId': orderId},
    );
  }

  /// 导航到邀请页面
  static Future<void> toInvite(BuildContext context) {
    return Navigator.pushNamed(context, XBoardRoutes.invite);
  }

  /// 导航到在线客服
  static Future<void> toOnlineSupport(BuildContext context) {
    return Navigator.pushNamed(context, XBoardRoutes.onlineSupport);
  }
}

