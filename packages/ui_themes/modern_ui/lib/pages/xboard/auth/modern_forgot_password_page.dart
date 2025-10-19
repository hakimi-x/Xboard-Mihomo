// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 忘记密码页面
// ═══════════════════════════════════════════════════════
// XBoard 忘记密码页面的 ModernUI 实现
// 现代风格：大圆角、渐变、毛玻璃效果
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ModernForgotPasswordPage extends ForgotPasswordPageContract {
  const ModernForgotPasswordPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (data.currentStep == ResetPasswordStep.resetPassword) {
              callbacks.onGoBackToSendCode();
            } else {
              callbacks.onBackToLogin();
            }
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade400,
              Colors.blue.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  data.currentStep == ResetPasswordStep.sendCode
                      ? AppLocalizations.of(context).resetPassword
                      : AppLocalizations.of(context).setNewPassword,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 32),
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: data.currentStep == ResetPasswordStep.sendCode
                          ? _buildSendCodeStep(context)
                          : _buildResetPasswordStep(context),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).rememberPassword,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: callbacks.onBackToLogin,
                      child: Text(
                        AppLocalizations.of(context).backToLogin,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendCodeStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context).enterEmailForReset,
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 24),
        _buildModernTextField(
          context,
          label: AppLocalizations.of(context).emailAddress,
          hint: AppLocalizations.of(context).pleaseEnterEmail,
          icon: Icons.email_outlined,
          value: data.email,
          enabled: !data.isLoading,
          onChanged: callbacks.onEmailChanged,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        _buildGradientButton(
          context,
          AppLocalizations.of(context).sendVerificationCode,
          data.isLoading ? null : callbacks.onSendVerificationCode,
          isLoading: data.isLoading,
        ),
      ],
    );
  }

  Widget _buildResetPasswordStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context).verificationCodeSentTo(data.email),
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 24),
        _buildModernTextField(
          context,
          label: AppLocalizations.of(context).verificationCode,
          hint: AppLocalizations.of(context).pleaseEnterVerificationCode,
          icon: Icons.verified_user_outlined,
          value: data.code,
          enabled: !data.isLoading,
          onChanged: callbacks.onCodeChanged,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        _buildModernTextField(
          context,
          label: AppLocalizations.of(context).newPassword,
          hint: AppLocalizations.of(context).pleaseEnterNewPassword,
          icon: Icons.lock_outlined,
          value: data.password,
          enabled: !data.isLoading,
          onChanged: callbacks.onPasswordChanged,
          obscureText: data.obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              data.obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: Colors.white70,
            ),
            onPressed: callbacks.onTogglePasswordVisibility,
          ),
        ),
        const SizedBox(height: 16),
        _buildModernTextField(
          context,
          label: AppLocalizations.of(context).confirmNewPassword,
          hint: AppLocalizations.of(context).pleaseConfirmNewPassword,
          icon: Icons.lock_outlined,
          value: data.confirmPassword,
          enabled: !data.isLoading,
          onChanged: callbacks.onConfirmPasswordChanged,
          obscureText: data.obscureConfirmPassword,
          suffixIcon: IconButton(
            icon: Icon(
              data.obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: Colors.white70,
            ),
            onPressed: callbacks.onToggleConfirmPasswordVisibility,
          ),
        ),
        const SizedBox(height: 24),
        _buildGradientButton(
          context,
          AppLocalizations.of(context).resetPassword,
          data.isLoading ? null : callbacks.onResetPassword,
          isLoading: data.isLoading,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: data.isLoading ? null : callbacks.onGoBackToSendCode,
          child: Text(
            AppLocalizations.of(context).resendVerificationCode,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernTextField(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
    required String value,
    required bool enabled,
    ValueCallback<String>? onChanged,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value)..selection = TextSelection.fromPosition(TextPosition(offset: value.length)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            prefixIcon: Icon(icon, color: Colors.white70),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          obscureText: obscureText,
          enabled: enabled,
          keyboardType: keyboardType,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildGradientButton(
    BuildContext context,
    String text,
    VoidCallback? onPressed, {
    bool isLoading = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade300, Colors.blue.shade400],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
