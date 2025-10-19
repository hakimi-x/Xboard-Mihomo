// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 忘记密码页面
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class ModernForgotPasswordPage extends ForgotPasswordPageContract {
  const ModernForgotPasswordPage({super.key, required super.data, required super.callbacks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('重置密码'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Theme.of(context).colorScheme.primary.withOpacity(0.2), Theme.of(context).colorScheme.tertiary.withOpacity(0.2)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    children: [
                      _buildStepIndicator(context),
                      const SizedBox(height: 32),
                      if (data.currentStep == ResetPasswordStep.enterEmail) _buildEmailStep(context)
                      else if (data.currentStep == ResetPasswordStep.enterCode) _buildCodeStep(context)
                      else if (data.currentStep == ResetPasswordStep.enterNewPassword) _buildPasswordStep(context)
                      else _buildSuccessStep(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(BuildContext context) {
    return Row(
      children: [
        _buildDot(context, 0), const SizedBox(width: 8),
        Expanded(child: Container(height: 2, color: data.currentStep.index >= 1 ? Theme.of(context).colorScheme.primary : Colors.grey)),
        const SizedBox(width: 8),
        _buildDot(context, 1), const SizedBox(width: 8),
        Expanded(child: Container(height: 2, color: data.currentStep.index >= 2 ? Theme.of(context).colorScheme.primary : Colors.grey)),
        const SizedBox(width: 8),
        _buildDot(context, 2),
      ],
    );
  }

  Widget _buildDot(BuildContext context, int step) {
    final isActive = data.currentStep.index >= step;
    return Container(
      width: 40, height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isActive ? LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]) : null,
        color: isActive ? null : Colors.grey,
      ),
      child: Center(child: Text('${step + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildEmailStep(BuildContext context) {
    return Column(
      children: [
        Text('输入注册邮箱', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        TextField(
          decoration: InputDecoration(
            labelText: '邮箱',
            prefixIcon: const Icon(Icons.email_outlined),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 24),
        _buildGradientButton(context, '发送验证码', callbacks.onSendVerificationCode),
      ],
    );
  }

  Widget _buildCodeStep(BuildContext context) {
    return Column(
      children: [
        Text('输入验证码', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        TextField(
          decoration: InputDecoration(
            labelText: '验证码',
            prefixIcon: const Icon(Icons.key_outlined),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 24),
        _buildGradientButton(context, '下一步', callbacks.onVerifyCode),
      ],
    );
  }

  Widget _buildPasswordStep(BuildContext context) {
    return Column(
      children: [
        Text('设置新密码', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        TextField(
          decoration: InputDecoration(
            labelText: '新密码',
            prefixIcon: const Icon(Icons.lock_outline),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: '确认新密码',
            prefixIcon: const Icon(Icons.lock_clock_outlined),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 24),
        _buildGradientButton(context, '重置密码', callbacks.onResetPassword),
      ],
    );
  }

  Widget _buildSuccessStep(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.check_circle, size: 80, color: Colors.green),
        const SizedBox(height: 24),
        Text('密码重置成功', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 32),
        _buildGradientButton(context, '返回登录', callbacks.onNavigateToLogin),
      ],
    );
  }

  Widget _buildGradientButton(BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 64),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(text, style: const TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}

