// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 登录页面
// ═══════════════════════════════════════════════════════
// XBoard 登录页面的 DefaultUI 实现
// 基于原有风格，采用契约模式
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/xboard/features/shared/shared.dart';
import 'package:fl_clash/xboard/features/domain_status/domain_status.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';

class DefaultLoginPage extends LoginPageContract {
  const DefaultLoginPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const LanguageSelector(),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => showDomainStatusDialog(context),
              child: const DomainStatusIndicator(),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surface,
              colorScheme.surface.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorScheme.primary.withValues(alpha: 0.1),
                          ),
                          child: Icon(
                            Icons.vpn_key_outlined,
                            size: 48,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          data.appTitle,
                          style: textTheme.displaySmall?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          data.appWebsite,
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  XBInputField(
                    controller: TextEditingController(text: data.username),
                    labelText: appLocalizations.xboardEmail,
                    hintText: appLocalizations.xboardEmail,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    enabled: data.isDomainReady && !data.isLoading,
                    onChanged: callbacks.onUsernameChanged,
                  ),
                  const SizedBox(height: 20),
                  XBInputField(
                    controller: TextEditingController(text: data.password),
                    labelText: appLocalizations.xboardPassword,
                    hintText: appLocalizations.xboardPassword,
                    prefixIcon: Icons.lock_outlined,
                    obscureText: !data.showPassword,
                    enabled: data.isDomainReady && !data.isLoading,
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
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: data.rememberMe,
                          onChanged: (value) {
                            if (!data.isLoading) {
                              callbacks.onToggleRememberMe(value ?? false);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          if (!data.isLoading) {
                            callbacks.onToggleRememberMe(!data.rememberMe);
                          }
                        },
                        child: Text(
                          appLocalizations.xboardRememberPassword,
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: data.isDomainReady && !data.isLoading
                          ? () => callbacks.onLogin(
                                data.username,
                                data.password,
                                data.rememberMe,
                              )
                          : null,
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: data.isDomainReady && !data.isLoading
                              ? LinearGradient(
                                  colors: [
                                    colorScheme.primary,
                                    colorScheme.primaryContainer,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: data.isLoading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        colorScheme.onPrimary,
                                      ),
                                    ),
                                  )
                                : Text(
                                    appLocalizations.xboardLogin,
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onPrimary,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: data.isLoading ? null : callbacks.onNavigateToForgotPassword,
                        child: Text(
                          appLocalizations.xboardForgotPassword,
                        ),
                      ),
                      TextButton(
                        onPressed: data.isLoading ? null : callbacks.onNavigateToRegister,
                        child: Text(
                          appLocalizations.xboardRegister,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

