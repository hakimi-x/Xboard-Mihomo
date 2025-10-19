// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 注册页面
// ═══════════════════════════════════════════════════════
// XBoard 注册页面的 DefaultUI 实现
// 基于原有风格，采用契约模式
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/xboard/features/shared/shared.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';

class DefaultRegisterPage extends RegisterPageContract {
  const DefaultRegisterPage({
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
                    onPressed: callbacks.onBackToLogin,
                    icon: const Icon(Icons.arrow_back),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.surfaceContainerLow,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    appLocalizations.createAccount,
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
                      Text(
                        appLocalizations.fillInfoToRegister,
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
                        labelText: appLocalizations.emailAddress,
                        hintText: appLocalizations.pleaseEnterYourEmailAddress,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        enabled: !data.isRegistering,
                        onChanged: callbacks.onEmailChanged,
                      ),
                      const SizedBox(height: 20),
                      XBInputField(
                        controller: TextEditingController(text: data.password)
                          ..selection = TextSelection.fromPosition(
                            TextPosition(offset: data.password.length),
                          ),
                        labelText: appLocalizations.password,
                        hintText: appLocalizations.pleaseEnterAtLeast8CharsPassword,
                        prefixIcon: Icons.lock_outlined,
                        obscureText: !data.showPassword,
                        enabled: !data.isRegistering,
                        onChanged: callbacks.onPasswordChanged,
                        suffixIcon: IconButton(
                          icon: Icon(
                            data.showPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: callbacks.onTogglePasswordVisibility,
                        ),
                      ),
                      const SizedBox(height: 20),
                      XBInputField(
                        controller: TextEditingController(text: data.confirmPassword)
                          ..selection = TextSelection.fromPosition(
                            TextPosition(offset: data.confirmPassword.length),
                          ),
                        labelText: appLocalizations.confirmNewPassword,
                        hintText: appLocalizations.pleaseReEnterPassword,
                        prefixIcon: Icons.lock_outlined,
                        obscureText: !data.showConfirmPassword,
                        enabled: !data.isRegistering,
                        onChanged: callbacks.onConfirmPasswordChanged,
                        suffixIcon: IconButton(
                          icon: Icon(
                            data.showConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: callbacks.onToggleConfirmPasswordVisibility,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // 根据配置决定是否显示邮箱验证码字段
                      if (data.isEmailVerify)
                        Column(
                          children: [
                            XBInputField(
                              controller: TextEditingController(text: data.emailCode)
                                ..selection = TextSelection.fromPosition(
                                  TextPosition(offset: data.emailCode.length),
                                ),
                              labelText: appLocalizations.emailVerificationCode,
                              hintText: appLocalizations.pleaseEnterEmailVerificationCode,
                              prefixIcon: Icons.verified_user_outlined,
                              keyboardType: TextInputType.number,
                              enabled: !data.isRegistering,
                              onChanged: callbacks.onEmailCodeChanged,
                              suffixIcon: data.isSendingEmailCode
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : TextButton(
                                      onPressed: callbacks.onSendEmailCode,
                                      child: Text(appLocalizations.sendVerificationCode),
                                    ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      // 邀请码字段
                      XBInputField(
                        controller: TextEditingController(text: data.inviteCode)
                          ..selection = TextSelection.fromPosition(
                            TextPosition(offset: data.inviteCode.length),
                          ),
                        labelText: data.isInviteForce
                            ? '${appLocalizations.xboardInviteCode} *'
                            : appLocalizations.xboardInviteCode,
                        hintText: data.isInviteForce
                            ? appLocalizations.pleaseEnterInviteCode
                            : appLocalizations.inviteCodeOptional,
                        prefixIcon: Icons.card_giftcard_outlined,
                        enabled: !data.isRegistering && !data.isConfigLoading,
                        onChanged: callbacks.onInviteCodeChanged,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: data.isRegistering
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
                                onPressed: callbacks.onRegister,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  foregroundColor: colorScheme.onPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  appLocalizations.registerAccount,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appLocalizations.alreadyHaveAccount,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                          TextButton(
                            onPressed: callbacks.onBackToLogin,
                            child: Text(
                              appLocalizations.loginNow,
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
}
