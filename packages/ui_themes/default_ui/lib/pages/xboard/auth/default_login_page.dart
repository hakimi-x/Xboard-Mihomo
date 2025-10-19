// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 登录页面
// ═══════════════════════════════════════════════════════
// XBoard 登录页面的 DefaultUI 实现
// 基于原有风格，采用契约模式
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class DefaultLoginPage extends LoginPageContract {
  const DefaultLoginPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  Icon(
                    Icons.vpn_key,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  
                  // 标题
                  Text(
                    '登录',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '欢迎回来',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // 错误提示
                  if (data.errorMessage != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Theme.of(context).colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              data.errorMessage!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // 邮箱输入
                  TextField(
                    controller: TextEditingController(text: data.username),
                    decoration: InputDecoration(
                      labelText: '邮箱',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    enabled: !data.isLoading,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 密码输入
                  TextField(
                    controller: TextEditingController(text: data.password),
                    decoration: InputDecoration(
                      labelText: '密码',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          data.showPassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: callbacks.onTogglePasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    obscureText: !data.showPassword,
                    enabled: !data.isLoading,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 记住我和忘记密码
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: data.rememberMe,
                            onChanged: data.isLoading 
                                ? null 
                                : (value) => callbacks.onToggleRememberMe(value ?? false),
                          ),
                          const Text('记住我'),
                        ],
                      ),
                      TextButton(
                        onPressed: data.isLoading ? null : callbacks.onNavigateToForgotPassword,
                        child: const Text('忘记密码？'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // 登录按钮
                  FilledButton(
                    onPressed: data.isLoading
                        ? null
                        : () => callbacks.onLogin(
                              data.username,
                              data.password,
                              data.rememberMe,
                            ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: data.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('登录'),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 注册按钮
                  OutlinedButton(
                    onPressed: data.isLoading ? null : callbacks.onNavigateToRegister,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('还没有账号？立即注册'),
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

