/// 注册页面契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';

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
  /// 邮箱
  final String email;
  
  /// 密码
  final String password;
  
  /// 确认密码
  final String confirmPassword;
  
  /// 邀请码
  final String inviteCode;
  
  /// 邮箱验证码
  final String emailCode;
  
  /// 是否正在注册
  final bool isRegistering;
  
  /// 是否正在发送邮箱验证码
  final bool isSendingEmailCode;
  
  /// 错误信息
  final String? errorMessage;
  
  /// 是否显示密码
  final bool showPassword;
  
  /// 是否显示确认密码
  final bool showConfirmPassword;
  
  /// 是否需要邮箱验证
  final bool isEmailVerify;
  
  /// 邀请码是否必填
  final bool isInviteForce;
  
  /// 配置是否加载中
  final bool isConfigLoading;

  const RegisterPageData({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.inviteCode = '',
    this.emailCode = '',
    this.isRegistering = false,
    this.isSendingEmailCode = false,
    this.errorMessage,
    this.showPassword = false,
    this.showConfirmPassword = false,
    this.isEmailVerify = false,
    this.isInviteForce = false,
    this.isConfigLoading = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'inviteCode': inviteCode,
      'emailCode': emailCode,
      'isRegistering': isRegistering,
      'isSendingEmailCode': isSendingEmailCode,
      'errorMessage': errorMessage,
      'showPassword': showPassword,
      'showConfirmPassword': showConfirmPassword,
      'isEmailVerify': isEmailVerify,
      'isInviteForce': isInviteForce,
      'isConfigLoading': isConfigLoading,
    };
  }
}

/// 注册页面回调
class RegisterPageCallbacks implements CallbacksModel {
  /// 注册
  final VoidCallback onRegister;
  
  /// 发送邮箱验证码
  final VoidCallback onSendEmailCode;
  
  /// 返回登录
  final VoidCallback onBackToLogin;
  
  /// 切换密码可见性
  final VoidCallback onTogglePasswordVisibility;
  
  /// 切换确认密码可见性
  final VoidCallback onToggleConfirmPasswordVisibility;
  
  /// 邮箱改变
  final ValueCallback<String>? onEmailChanged;
  
  /// 密码改变
  final ValueCallback<String>? onPasswordChanged;
  
  /// 确认密码改变
  final ValueCallback<String>? onConfirmPasswordChanged;
  
  /// 邀请码改变
  final ValueCallback<String>? onInviteCodeChanged;
  
  /// 邮箱验证码改变
  final ValueCallback<String>? onEmailCodeChanged;

  const RegisterPageCallbacks({
    required this.onRegister,
    required this.onSendEmailCode,
    required this.onBackToLogin,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    this.onEmailChanged,
    this.onPasswordChanged,
    this.onConfirmPasswordChanged,
    this.onInviteCodeChanged,
    this.onEmailCodeChanged,
  });
}

