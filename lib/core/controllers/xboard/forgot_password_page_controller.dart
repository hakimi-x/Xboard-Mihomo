/// 忘记密码页面控制器
///
/// 负责：
/// 1. 管理忘记密码流程的步骤
/// 2. 处理发送验证码和重置密码
/// 3. 使用 UIRegistry 动态构建页面

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordPageController extends ConsumerStatefulWidget {
  const ForgotPasswordPageController({super.key});

  @override
  ConsumerState<ForgotPasswordPageController> createState() => _ForgotPasswordPageControllerState();
}

class _ForgotPasswordPageControllerState extends ConsumerState<ForgotPasswordPageController> {
  String _email = '';
  String _code = '';
  String _password = '';
  String _confirmPassword = '';
  ResetPasswordStep _currentStep = ResetPasswordStep.sendCode;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _handleSendVerificationCode() async {
    if (_email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).pleaseEnterEmail)),
      );
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).pleaseEnterValidEmail)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await XBoardSDK.sendVerificationCode(_email);

      if (mounted) {
        setState(() {
          _currentStep = ResetPasswordStep.resetPassword;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).verificationCodeSent),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context).sendCodeFailed}: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleResetPassword() async {
    if (_code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).pleaseEnterVerificationCode)),
      );
      return;
    }

    if (_password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).pleaseEnterNewPassword)),
      );
      return;
    }

    if (_confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).pleaseConfirmNewPassword)),
      );
      return;
    }

    if (_password != _confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).passwordMismatch)),
      );
      return;
    }

    if (_password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).passwordMinLength)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await XBoardSDK.resetPassword(
        email: _email,
        password: _password,
        emailCode: _code,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).passwordResetSuccessful),
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context).passwordResetFailed}: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleGoBackToSendCode() {
    setState(() {
      _currentStep = ResetPasswordStep.sendCode;
      _code = '';
      _password = '';
      _confirmPassword = '';
    });
  }

  void _handleBackToLogin() {
    Navigator.of(context).pop();
  }

  void _handleTogglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleToggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 准备契约数据
    final data = ForgotPasswordPageData(
      email: _email,
      code: _code,
      password: _password,
      confirmPassword: _confirmPassword,
      currentStep: _currentStep,
      isLoading: _isLoading,
      obscurePassword: _obscurePassword,
      obscureConfirmPassword: _obscureConfirmPassword,
    );

    // 准备回调
    final callbacks = ForgotPasswordPageCallbacks(
      onSendVerificationCode: _handleSendVerificationCode,
      onResetPassword: _handleResetPassword,
      onGoBackToSendCode: _handleGoBackToSendCode,
      onBackToLogin: _handleBackToLogin,
      onTogglePasswordVisibility: _handleTogglePasswordVisibility,
      onToggleConfirmPasswordVisibility: _handleToggleConfirmPasswordVisibility,
      onEmailChanged: (value) => setState(() => _email = value),
      onCodeChanged: (value) => setState(() => _code = value),
      onPasswordChanged: (value) => setState(() => _password = value),
      onConfirmPasswordChanged: (value) => setState(() => _confirmPassword = value),
    );

    // 使用 UIRegistry 动态构建页面
    return UIRegistry().buildPage<ForgotPasswordPageContract>(
      data: data,
      callbacks: callbacks,
    );
  }
}
