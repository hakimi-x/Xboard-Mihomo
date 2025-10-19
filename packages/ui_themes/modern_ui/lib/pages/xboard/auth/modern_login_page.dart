// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 登录页面
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class ModernLoginPage extends LoginPageContract {
  const ModernLoginPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
              Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              ),
                            ),
                            child: const Icon(Icons.vpn_key, size: 48, color: Colors.white),
                          ),
                          const SizedBox(height: 24),
                          Text('欢迎回来', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 32),
                          
                          if (data.errorMessage != null)
                            Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.red.withOpacity(0.3)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.error_outline, color: Colors.red),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(data.errorMessage!, style: const TextStyle(color: Colors.red))),
                                ],
                              ),
                            ),
                          
                          TextField(
                            decoration: InputDecoration(
                              labelText: '邮箱',
                              prefixIcon: const Icon(Icons.email_outlined),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                            ),
                            enabled: !data.isLoading,
                          ),
                          const SizedBox(height: 16),
                          
                          TextField(
                            decoration: InputDecoration(
                              labelText: '密码',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(data.showPassword ? Icons.visibility_off : Icons.visibility),
                                onPressed: callbacks.onTogglePasswordVisibility,
                              ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                            ),
                            obscureText: !data.showPassword,
                            enabled: !data.isLoading,
                          ),
                          const SizedBox(height: 16),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(value: data.rememberMe, onChanged: data.isLoading ? null : (v) => callbacks.onToggleRememberMe(v ?? false)),
                                  const Text('记住我'),
                                ],
                              ),
                              TextButton(onPressed: callbacks.onNavigateToForgotPassword, child: const Text('忘记密码？')),
                            ],
                          ),
                          const SizedBox(height: 24),
                          
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: data.isLoading ? null : () => callbacks.onLogin(data.username, data.password, data.rememberMe),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                minimumSize: const Size(double.infinity, 64),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: data.isLoading
                                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                  : const Text('登录', style: TextStyle(fontSize: 18, color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          OutlinedButton(
                            onPressed: callbacks.onNavigateToRegister,
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 56),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              side: BorderSide(color: Theme.of(context).colorScheme.primary),
                            ),
                            child: const Text('还没有账号？立即注册'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

