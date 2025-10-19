/// 忘记密码页面控制器
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordPageController extends ConsumerStatefulWidget {
  const ForgotPasswordPageController({super.key});

  @override
  ConsumerState<ForgotPasswordPageController> createState() => _ForgotPasswordPageControllerState();
}

class _ForgotPasswordPageControllerState extends ConsumerState<ForgotPasswordPageController> {
  String _email = '';
  String _verificationCode = '';
  String _newPassword = '';
  String _confirmNewPassword = '';
  ResetPasswordStep _currentStep = ResetPasswordStep.enterEmail;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _isLoading = false;
  int _countdown = 0;
  String? _errorMessage;

  Future<void> _handleSendVerificationCode() async {
    setState(() { _isLoading = true; });
    try {
      // TODO: 发送验证码逻辑
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() { _currentStep = ResetPasswordStep.enterCode; _countdown = 60; });
        _startCountdown();
      }
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _countdown > 0) {
        setState(() { _countdown--; });
        _startCountdown();
      }
    });
  }

  Future<void> _handleVerifyCode() async {
    setState(() { _isLoading = true; });
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) setState(() { _currentStep = ResetPasswordStep.enterNewPassword; });
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  Future<void> _handleResetPassword() async {
    setState(() { _isLoading = true; });
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) setState(() { _currentStep = ResetPasswordStep.success; });
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ForgotPasswordPageData(
      email: _email,
      verificationCode: _verificationCode,
      newPassword: _newPassword,
      confirmNewPassword: _confirmNewPassword,
      currentStep: _currentStep,
      isLoading: _isLoading,
      showPassword: _showPassword,
      showConfirmPassword: _showConfirmPassword,
      countdown: _countdown,
    );
    
    final callbacks = ForgotPasswordPageCallbacks(
      onSendVerificationCode: _handleSendVerificationCode,
      onVerifyCode: _handleVerifyCode,
      onResetPassword: _handleResetPassword,
      onBack: () => setState(() { if (_currentStep.index > 0) _currentStep = ResetPasswordStep.values[_currentStep.index - 1]; }),
      onNavigateToLogin: () => Navigator.pushReplacementNamed(context, '/login'),
      onTogglePasswordVisibility: () => setState(() { _showPassword = !_showPassword; }),
      onToggleConfirmPasswordVisibility: () => setState(() { _showConfirmPassword = !_showConfirmPassword; }),
    );
    
    return UIRegistry().buildPage<ForgotPasswordPageContract>(data: data, callbacks: callbacks);
  }
}

