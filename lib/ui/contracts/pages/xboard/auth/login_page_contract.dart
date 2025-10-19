/// 登录页面契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';

/// 登录页面契约
abstract class LoginPageContract extends PageContract<LoginPageData, LoginPageCallbacks> {
  const LoginPageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 登录页面数据
class LoginPageData implements DataModel {
  /// 应用标题
  final String appTitle;
  
  /// 应用网站
  final String appWebsite;
  
  /// 用户名/邮箱
  final String username;
  
  /// 密码
  final String password;
  
  /// 记住我
  final bool rememberMe;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 错误信息
  final String? errorMessage;
  
  /// 是否显示密码
  final bool showPassword;
  
  /// 域名是否就绪
  final bool isDomainReady;

  const LoginPageData({
    this.appTitle = 'XBoard',
    this.appWebsite = '',
    this.username = '',
    this.password = '',
    this.rememberMe = false,
    this.isLoading = false,
    this.errorMessage,
    this.showPassword = false,
    this.isDomainReady = true,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'appTitle': appTitle,
      'appWebsite': appWebsite,
      'username': username,
      'password': password,
      'rememberMe': rememberMe,
      'isLoading': isLoading,
      'errorMessage': errorMessage,
      'showPassword': showPassword,
      'isDomainReady': isDomainReady,
    };
  }
}

/// 登录页面回调
class LoginPageCallbacks implements CallbacksModel {
  /// 登录
  final Future<void> Function(String username, String password, bool rememberMe) onLogin;
  
  /// 跳转到注册
  final VoidCallback onNavigateToRegister;
  
  /// 跳转到忘记密码
  final VoidCallback onNavigateToForgotPassword;
  
  /// 切换密码可见性
  final VoidCallback onTogglePasswordVisibility;
  
  /// 切换记住我
  final ValueCallback<bool> onToggleRememberMe;
  
  /// 用户名改变
  final ValueCallback<String>? onUsernameChanged;
  
  /// 密码改变
  final ValueCallback<String>? onPasswordChanged;

  const LoginPageCallbacks({
    required this.onLogin,
    required this.onNavigateToRegister,
    required this.onNavigateToForgotPassword,
    required this.onTogglePasswordVisibility,
    required this.onToggleRememberMe,
    this.onUsernameChanged,
    this.onPasswordChanged,
  });
}

