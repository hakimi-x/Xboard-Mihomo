/// 登录页面契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

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

  const LoginPageData({
    this.username = '',
    this.password = '',
    this.rememberMe = false,
    this.isLoading = false,
    this.errorMessage,
    this.showPassword = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'rememberMe': rememberMe,
      'isLoading': isLoading,
      'errorMessage': errorMessage,
      'showPassword': showPassword,
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

  const LoginPageCallbacks({
    required this.onLogin,
    required this.onNavigateToRegister,
    required this.onNavigateToForgotPassword,
    required this.onTogglePasswordVisibility,
    required this.onToggleRememberMe,
  });
}

