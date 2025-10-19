/// 注册页面契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

/// 注册页面契约
abstract class RegisterPageContract extends PageContract<RegisterPageData, RegisterPageCallbacks> {
  const RegisterPageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 注册页面数据
class RegisterPageData implements DataModel {
  /// 用户名
  final String username;
  
  /// 邮箱
  final String email;
  
  /// 密码
  final String password;
  
  /// 确认密码
  final String confirmPassword;
  
  /// 邀请码
  final String inviteCode;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 错误信息
  final String? errorMessage;
  
  /// 是否显示密码
  final bool showPassword;
  
  /// 是否显示确认密码
  final bool showConfirmPassword;
  
  /// 是否同意条款
  final bool agreeToTerms;

  const RegisterPageData({
    this.username = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.inviteCode = '',
    this.isLoading = false,
    this.errorMessage,
    this.showPassword = false,
    this.showConfirmPassword = false,
    this.agreeToTerms = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'inviteCode': inviteCode,
      'isLoading': isLoading,
      'errorMessage': errorMessage,
      'showPassword': showPassword,
      'showConfirmPassword': showConfirmPassword,
      'agreeToTerms': agreeToTerms,
    };
  }
  
  /// 验证密码是否匹配
  bool get passwordsMatch => password == confirmPassword && password.isNotEmpty;
  
  /// 验证表单是否完整
  bool get isFormValid =>
      username.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      passwordsMatch &&
      agreeToTerms;
}

/// 注册页面回调
class RegisterPageCallbacks implements CallbacksModel {
  /// 注册
  final Future<void> Function(
    String username,
    String email,
    String password,
    String inviteCode,
  ) onRegister;
  
  /// 跳转到登录
  final VoidCallback onNavigateToLogin;
  
  /// 切换密码可见性
  final VoidCallback onTogglePasswordVisibility;
  
  /// 切换确认密码可见性
  final VoidCallback onToggleConfirmPasswordVisibility;
  
  /// 切换同意条款
  final ValueCallback<bool> onToggleAgreeToTerms;
  
  /// 查看用户协议
  final VoidCallback onViewTerms;
  
  /// 查看隐私政策
  final VoidCallback onViewPrivacy;

  const RegisterPageCallbacks({
    required this.onRegister,
    required this.onNavigateToLogin,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    required this.onToggleAgreeToTerms,
    required this.onViewTerms,
    required this.onViewPrivacy,
  });
}

