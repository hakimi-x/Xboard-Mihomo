// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 注册页面
// ═══════════════════════════════════════════════════════
// XBoard 注册页面的 ModernUI 实现
// 现代风格：大圆角、渐变、毛玻璃效果
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';

class ModernRegisterPage extends RegisterPageContract {
  const ModernRegisterPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: callbacks.onBackToLogin,
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
                  appLocalizations.createAccount,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  appLocalizations.fillInfoToRegister,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
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
                      child: Column(
                        children: [
                          _buildModernTextField(
                            context,
                            label: appLocalizations.emailAddress,
                            hint: appLocalizations.pleaseEnterYourEmailAddress,
                            icon: Icons.email_outlined,
                            value: data.email,
                            enabled: !data.isRegistering,
                            onChanged: callbacks.onEmailChanged,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          _buildModernTextField(
                            context,
                            label: appLocalizations.password,
                            hint: appLocalizations.pleaseEnterAtLeast8CharsPassword,
                            icon: Icons.lock_outlined,
                            value: data.password,
                            enabled: !data.isRegistering,
                            onChanged: callbacks.onPasswordChanged,
                            obscureText: !data.showPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                data.showPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.white70,
                              ),
                              onPressed: callbacks.onTogglePasswordVisibility,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildModernTextField(
                            context,
                            label: appLocalizations.confirmNewPassword,
                            hint: appLocalizations.pleaseReEnterPassword,
                            icon: Icons.lock_outlined,
                            value: data.confirmPassword,
                            enabled: !data.isRegistering,
                            onChanged: callbacks.onConfirmPasswordChanged,
                            obscureText: !data.showConfirmPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                data.showConfirmPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.white70,
                              ),
                              onPressed: callbacks.onToggleConfirmPasswordVisibility,
                            ),
                          ),
                          if (data.isEmailVerify) ...[
                            const SizedBox(height: 16),
                            _buildModernTextField(
                              context,
                              label: appLocalizations.emailVerificationCode,
                              hint: appLocalizations.pleaseEnterEmailVerificationCode,
                              icon: Icons.verified_user_outlined,
                              value: data.emailCode,
                              enabled: !data.isRegistering,
                              onChanged: callbacks.onEmailCodeChanged,
                              keyboardType: TextInputType.number,
                              suffixIcon: data.isSendingEmailCode
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: callbacks.onSendEmailCode,
                                      child: Text(
                                        appLocalizations.sendVerificationCode,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),
                          ],
                          const SizedBox(height: 16),
                          _buildModernTextField(
                            context,
                            label: data.isInviteForce
                                ? '${appLocalizations.xboardInviteCode} *'
                                : appLocalizations.xboardInviteCode,
                            hint: data.isInviteForce
                                ? appLocalizations.pleaseEnterInviteCode
                                : appLocalizations.inviteCodeOptional,
                            icon: Icons.card_giftcard_outlined,
                            value: data.inviteCode,
                            enabled: !data.isRegistering && !data.isConfigLoading,
                            onChanged: callbacks.onInviteCodeChanged,
                          ),
                          const SizedBox(height: 24),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.purple.shade300, Colors.blue.shade400],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ElevatedButton(
                              onPressed: data.isRegistering ? null : callbacks.onRegister,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                minimumSize: const Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: data.isRegistering
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      appLocalizations.registerAccount,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                appLocalizations.alreadyHaveAccount,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              TextButton(
                                onPressed: callbacks.onBackToLogin,
                                child: Text(
                                  appLocalizations.loginNow,
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
              ],
            ),
          ),
        ),
      ),
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
}
