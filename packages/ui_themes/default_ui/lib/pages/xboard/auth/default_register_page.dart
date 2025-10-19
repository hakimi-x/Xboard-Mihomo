// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 注册页面
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class DefaultRegisterPage extends RegisterPageContract {
  const DefaultRegisterPage({
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
          onPressed: callbacks.onNavigateToLogin,
        ),
        title: const Text('注册'),
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
                  if (data.errorMessage != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        data.errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  
                  // 用户名
                  TextField(
                    decoration: InputDecoration(
                      labelText: '用户名',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    enabled: !data.isLoading,
                  ),
                  const SizedBox(height: 16),
                  
                  // 邮箱
                  TextField(
                    decoration: InputDecoration(
                      labelText: '邮箱',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    enabled: !data.isLoading,
                  ),
                  const SizedBox(height: 16),
                  
                  // 密码
                  TextField(
                    decoration: InputDecoration(
                      labelText: '密码',
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
                  
                  // 确认密码
                  TextField(
                    decoration: InputDecoration(
                      labelText: '确认密码',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(data.showConfirmPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: callbacks.onToggleConfirmPasswordVisibility,
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      errorText: !data.passwordsMatch && data.confirmPassword.isNotEmpty 
                          ? '密码不匹配' 
                          : null,
                    ),
                    obscureText: !data.showConfirmPassword,
                    enabled: !data.isLoading,
                  ),
                  const SizedBox(height: 16),
                  
                  // 邀请码
                  TextField(
                    decoration: InputDecoration(
                      labelText: '邀请码（可选）',
                      prefixIcon: const Icon(Icons.card_giftcard),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    enabled: !data.isLoading,
                  ),
                  const SizedBox(height: 16),
                  
                  // 同意条款
                  Row(
                    children: [
                      Checkbox(
                        value: data.agreeToTerms,
                        onChanged: data.isLoading ? null : (v) => callbacks.onToggleAgreeToTerms(v ?? false),
                      ),
                      Expanded(
                        child: Wrap(
                          children: [
                            const Text('我同意 '),
                            InkWell(
                              onTap: callbacks.onViewTerms,
                              child: Text('用户协议', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                            ),
                            const Text(' 和 '),
                            InkWell(
                              onTap: callbacks.onViewPrivacy,
                              child: Text('隐私政策', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // 注册按钮
                  FilledButton(
                    onPressed: data.isFormValid && !data.isLoading
                        ? () => callbacks.onRegister(data.username, data.email, data.password, data.inviteCode)
                        : null,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: data.isLoading
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('注册'),
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

