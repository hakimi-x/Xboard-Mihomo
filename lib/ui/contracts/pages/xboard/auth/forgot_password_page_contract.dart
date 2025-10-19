/// 忘记密码页面契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';

/// 忘记密码页面契约
abstract class ForgotPasswordPageContract extends PageContract<ForgotPasswordPageData, ForgotPasswordPageCallbacks> {
  const ForgotPasswordPageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 重置密码步骤
enum ResetPasswordStep {
  sendCode,        // 发送验证码步骤
  resetPassword,   // 重置密码步骤
}

/// 忘记密码页面数据
class ForgotPasswordPageData implements DataModel {
  /// 邮箱
  final String email;
  
  /// 验证码
  final String code;
  
  /// 新密码
  final String password;
  
  /// 确认新密码
  final String confirmPassword;
  
  /// 当前步骤
  final ResetPasswordStep currentStep;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 是否显示密码
  final bool obscurePassword;
  
  /// 是否显示确认密码
  final bool obscureConfirmPassword;

  const ForgotPasswordPageData({
    this.email = '',
    this.code = '',
    this.password = '',
    this.confirmPassword = '',
    this.currentStep = ResetPasswordStep.sendCode,
    this.isLoading = false,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'code': code,
      'password': password,
      'confirmPassword': confirmPassword,
      'currentStep': currentStep.toString(),
      'isLoading': isLoading,
      'obscurePassword': obscurePassword,
      'obscureConfirmPassword': obscureConfirmPassword,
    };
  }
}

/// 忘记密码页面回调
class ForgotPasswordPageCallbacks implements CallbacksModel {
  /// 发送验证码
  final VoidCallback onSendVerificationCode;
  
  /// 重置密码
  final VoidCallback onResetPassword;
  
  /// 返回上一步（从resetPassword步骤返回到sendCode步骤）
  final VoidCallback onGoBackToSendCode;
  
  /// 返回登录
  final VoidCallback onBackToLogin;
  
  /// 切换密码可见性
  final VoidCallback onTogglePasswordVisibility;
  
  /// 切换确认密码可见性
  final VoidCallback onToggleConfirmPasswordVisibility;
  
  /// 邮箱改变
  final ValueCallback<String>? onEmailChanged;
  
  /// 验证码改变
  final ValueCallback<String>? onCodeChanged;
  
  /// 密码改变
  final ValueCallback<String>? onPasswordChanged;
  
  /// 确认密码改变
  final ValueCallback<String>? onConfirmPasswordChanged;

  const ForgotPasswordPageCallbacks({
    required this.onSendVerificationCode,
    required this.onResetPassword,
    required this.onGoBackToSendCode,
    required this.onBackToLogin,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    this.onEmailChanged,
    this.onCodeChanged,
    this.onPasswordChanged,
    this.onConfirmPasswordChanged,
  });
}

