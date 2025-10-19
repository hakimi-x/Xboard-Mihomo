// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 注册页面
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class ModernRegisterPage extends RegisterPageContract {
  const ModernRegisterPage({super.key, required super.data, required super.callbacks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: callbacks.onNavigateToLogin),
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
                      Text('创建账号', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 24),
                      _buildTextField('用户名', Icons.person_outline, false),
                      const SizedBox(height: 16),
                      _buildTextField('邮箱', Icons.email_outlined, false),
                      const SizedBox(height: 16),
                      _buildTextField('密码', Icons.lock_outline, true, showPassword: data.showPassword, onToggle: callbacks.onTogglePasswordVisibility),
                      const SizedBox(height: 16),
                      _buildTextField('确认密码', Icons.lock_clock_outlined, true, showPassword: data.showConfirmPassword, onToggle: callbacks.onToggleConfirmPasswordVisibility),
                      const SizedBox(height: 16),
                      _buildTextField('邀请码（可选）', Icons.card_giftcard_outlined, false),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(value: data.agreeToTerms, onChanged: (v) => callbacks.onToggleAgreeToTerms(v ?? false)),
                          Expanded(
                            child: Wrap(
                              children: [
                                const Text('我同意 '),
                                InkWell(onTap: callbacks.onViewTerms, child: Text('用户协议', style: TextStyle(color: Theme.of(context).colorScheme.primary))),
                                const Text(' 和 '),
                                InkWell(onTap: callbacks.onViewPrivacy, child: Text('隐私政策', style: TextStyle(color: Theme.of(context).colorScheme.primary))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          onPressed: data.isFormValid ? () => callbacks.onRegister(data.username, data.email, data.password, data.inviteCode) : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            minimumSize: const Size(double.infinity, 64),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text('注册', style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
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

  Widget _buildTextField(String label, IconData icon, bool isPassword, {bool showPassword = false, VoidCallback? onToggle}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: isPassword ? IconButton(icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility), onPressed: onToggle) : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      ),
      obscureText: isPassword && !showPassword,
    );
  }
}

