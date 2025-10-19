// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 忘记密码页面
// ═══════════════════════════════════════════════════════
// XBoard 忘记密码页面的 DefaultUI 实现
// 基于原有风格，采用契约模式
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/xboard/features/shared/shared.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:flutter/material.dart';

class DefaultForgotPasswordPage extends ForgotPasswordPageContract {
  const DefaultForgotPasswordPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: XBContainer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (data.currentStep == ResetPasswordStep.resetPassword) {
                        callbacks.onGoBackToSendCode();
                      } else {
                        callbacks.onBackToLogin();
                      }
                    },
                    icon: const Icon(Icons.arrow_back),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.surfaceContainerLow,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    data.currentStep == ResetPasswordStep.sendCode
                        ? AppLocalizations.of(context).resetPassword
                        : AppLocalizations.of(context).setNewPassword,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (data.currentStep == ResetPasswordStep.sendCode)
                        _buildSendCodeStep(context)
                      else
                        _buildResetPasswordStep(context),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context).rememberPassword,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                          TextButton(
                            onPressed: callbacks.onBackToLogin,
                            child: Text(
                              AppLocalizations.of(context).backToLogin,
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendCodeStep(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context).enterEmailForReset,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 32),
        XBInputField(
          controller: TextEditingController(text: data.email)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: data.email.length),
            ),
          labelText: AppLocalizations.of(context).emailAddress,
          hintText: AppLocalizations.of(context).pleaseEnterEmail,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          enabled: !data.isLoading,
          onChanged: callbacks.onEmailChanged,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: data.isLoading
              ? ElevatedButton(
                  onPressed: null,
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                )
              : ElevatedButton(
                  onPressed: callbacks.onSendVerificationCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context).sendVerificationCode,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildResetPasswordStep(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context).verificationCodeSentTo(data.email),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 32),
        XBInputField(
          controller: TextEditingController(text: data.code)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: data.code.length),
            ),
          labelText: AppLocalizations.of(context).verificationCode,
          hintText: AppLocalizations.of(context).pleaseEnterVerificationCode,
          prefixIcon: Icons.verified_user_outlined,
          keyboardType: TextInputType.number,
          enabled: !data.isLoading,
          onChanged: callbacks.onCodeChanged,
        ),
        const SizedBox(height: 16),
        XBInputField(
          controller: TextEditingController(text: data.password)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: data.password.length),
            ),
          labelText: AppLocalizations.of(context).newPassword,
          hintText: AppLocalizations.of(context).pleaseEnterNewPassword,
          prefixIcon: Icons.lock_outlined,
          obscureText: data.obscurePassword,
          enabled: !data.isLoading,
          onChanged: callbacks.onPasswordChanged,
          suffixIcon: IconButton(
            icon: Icon(
              data.obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            ),
            onPressed: callbacks.onTogglePasswordVisibility,
          ),
        ),
        const SizedBox(height: 16),
        XBInputField(
          controller: TextEditingController(text: data.confirmPassword)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: data.confirmPassword.length),
            ),
          labelText: AppLocalizations.of(context).confirmNewPassword,
          hintText: AppLocalizations.of(context).pleaseConfirmNewPassword,
          prefixIcon: Icons.lock_outlined,
          obscureText: data.obscureConfirmPassword,
          enabled: !data.isLoading,
          onChanged: callbacks.onConfirmPasswordChanged,
          suffixIcon: IconButton(
            icon: Icon(
              data.obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            ),
            onPressed: callbacks.onToggleConfirmPasswordVisibility,
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: data.isLoading
              ? ElevatedButton(
                  onPressed: null,
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                )
              : ElevatedButton(
                  onPressed: callbacks.onResetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context).resetPassword,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: data.isLoading ? null : callbacks.onGoBackToSendCode,
          child: Text(
            AppLocalizations.of(context).resendVerificationCode,
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
