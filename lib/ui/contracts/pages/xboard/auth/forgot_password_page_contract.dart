/// 忘记密码页面契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

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
  enterEmail,      // 输入邮箱
  enterCode,       // 输入验证码
  enterNewPassword, // 输入新密码
  success,         // 重置成功
}

/// 忘记密码页面数据
class ForgotPasswordPageData implements DataModel {
  /// 邮箱
  final String email;
  
  /// 验证码
  final String verificationCode;
  
  /// 新密码
  final String newPassword;
  
  /// 确认新密码
  final String confirmNewPassword;
  
  /// 当前步骤
  final ResetPasswordStep currentStep;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 错误信息
  final String? errorMessage;
  
  /// 成功信息
  final String? successMessage;
  
  /// 是否显示密码
  final bool showPassword;
  
  /// 是否显示确认密码
  final bool showConfirmPassword;
  
  /// 倒计时秒数（发送验证码后）
  final int countdown;

  const ForgotPasswordPageData({
    this.email = '',
    this.verificationCode = '',
    this.newPassword = '',
    this.confirmNewPassword = '',
    this.currentStep = ResetPasswordStep.enterEmail,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.showPassword = false,
    this.showConfirmPassword = false,
    this.countdown = 0,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'verificationCode': verificationCode,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
      'currentStep': currentStep.toString(),
      'isLoading': isLoading,
      'errorMessage': errorMessage,
      'successMessage': successMessage,
      'showPassword': showPassword,
      'showConfirmPassword': showConfirmPassword,
      'countdown': countdown,
    };
  }
  
  /// 验证密码是否匹配
  bool get passwordsMatch => newPassword == confirmNewPassword && newPassword.isNotEmpty;
  
  /// 是否可以发送验证码
  bool get canSendCode => email.isNotEmpty && countdown == 0;
  
  /// 是否可以继续下一步
  bool get canProceed {
    switch (currentStep) {
      case ResetPasswordStep.enterEmail:
        return email.isNotEmpty;
      case ResetPasswordStep.enterCode:
        return verificationCode.isNotEmpty;
      case ResetPasswordStep.enterNewPassword:
        return passwordsMatch;
      case ResetPasswordStep.success:
        return true;
    }
  }
}

/// 忘记密码页面回调
class ForgotPasswordPageCallbacks implements CallbacksModel {
  /// 发送验证码
  final AsyncCallback onSendVerificationCode;
  
  /// 验证验证码
  final AsyncCallback onVerifyCode;
  
  /// 重置密码
  final AsyncCallback onResetPassword;
  
  /// 返回上一步
  final VoidCallback onBack;
  
  /// 返回登录
  final VoidCallback onNavigateToLogin;
  
  /// 切换密码可见性
  final VoidCallback onTogglePasswordVisibility;
  
  /// 切换确认密码可见性
  final VoidCallback onToggleConfirmPasswordVisibility;

  const ForgotPasswordPageCallbacks({
    required this.onSendVerificationCode,
    required this.onVerifyCode,
    required this.onResetPassword,
    required this.onBack,
    required this.onNavigateToLogin,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
  });
}

