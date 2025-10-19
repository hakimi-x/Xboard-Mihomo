// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 忘记密码页面
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class DefaultForgotPasswordPage extends ForgotPasswordPageContract {
  const DefaultForgotPasswordPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: data.currentStep == ResetPasswordStep.enterEmail
              ? callbacks.onNavigateToLogin
              : callbacks.onBack,
        ),
        title: const Text('重置密码'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 步骤指示器
                  _buildStepIndicator(context),
                  const SizedBox(height: 32),
                  
                  // 根据步骤显示不同内容
                  if (data.currentStep == ResetPasswordStep.enterEmail)
                    _buildEmailStep(context)
                  else if (data.currentStep == ResetPasswordStep.enterCode)
                    _buildCodeStep(context)
                  else if (data.currentStep == ResetPasswordStep.enterNewPassword)
                    _buildPasswordStep(context)
                  else
                    _buildSuccessStep(context),
                ],
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
        _buildStepDot(context, 1, data.currentStep.index >= 0),
        Expanded(child: Divider(color: data.currentStep.index >= 1 ? Theme.of(context).colorScheme.primary : null)),
        _buildStepDot(context, 2, data.currentStep.index >= 1),
        Expanded(child: Divider(color: data.currentStep.index >= 2 ? Theme.of(context).colorScheme.primary : null)),
        _buildStepDot(context, 3, data.currentStep.index >= 2),
      ],
    );
  }

  Widget _buildStepDot(BuildContext context, int step, bool isActive) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Center(
        child: Text(
          '$step',
          style: TextStyle(
            color: isActive ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('输入注册邮箱', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text('我们将向您的邮箱发送验证码', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 24),
        TextField(
          decoration: InputDecoration(
            labelText: '邮箱',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.emailAddress,
          enabled: !data.isLoading,
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: data.canSendCode && !data.isLoading ? callbacks.onSendVerificationCode : null,
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: data.isLoading
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(data.countdown > 0 ? '${data.countdown}秒后重试' : '发送验证码'),
        ),
      ],
    );
  }

  Widget _buildCodeStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('输入验证码', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text('验证码已发送到 ${data.email}', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 24),
        TextField(
          decoration: InputDecoration(
            labelText: '验证码',
            prefixIcon: const Icon(Icons.key),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.number,
          enabled: !data.isLoading,
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: data.canProceed && !data.isLoading ? callbacks.onVerifyCode : null,
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: data.isLoading
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('下一步'),
        ),
      ],
    );
  }

  Widget _buildPasswordStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('设置新密码', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        TextField(
          decoration: InputDecoration(
            labelText: '新密码',
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(data.showPassword ? Icons.visibility_off : Icons.visibility),
              onPressed: callbacks.onTogglePasswordVisibility,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          obscureText: !data.showPassword,
          enabled: !data.isLoading,
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: '确认新密码',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(data.showConfirmPassword ? Icons.visibility_off : Icons.visibility),
              onPressed: callbacks.onToggleConfirmPasswordVisibility,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            errorText: !data.passwordsMatch && data.confirmNewPassword.isNotEmpty ? '密码不匹配' : null,
          ),
          obscureText: !data.showConfirmPassword,
          enabled: !data.isLoading,
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: data.canProceed && !data.isLoading ? callbacks.onResetPassword : null,
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: data.isLoading
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('重置密码'),
        ),
      ],
    );
  }

  Widget _buildSuccessStep(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.check_circle, size: 80, color: Colors.green),
        const SizedBox(height: 24),
        Text('密码重置成功', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('您现在可以使用新密码登录了', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: callbacks.onNavigateToLogin,
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('返回登录'),
        ),
      ],
    );
  }
}

