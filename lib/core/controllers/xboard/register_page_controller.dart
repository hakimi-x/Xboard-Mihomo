/// 注册页面控制器
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPageController extends ConsumerStatefulWidget {
  const RegisterPageController({super.key});

  @override
  ConsumerState<RegisterPageController> createState() => _RegisterPageControllerState();
}

class _RegisterPageControllerState extends ConsumerState<RegisterPageController> {
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _inviteCode = '';
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _agreeToTerms = false;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleRegister(String username, String email, String password, String inviteCode) async {
    setState(() { _isLoading = true; _errorMessage = null; });
    try {
      // TODO: 调用实际的注册逻辑
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) setState(() { _errorMessage = e.toString(); });
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = RegisterPageData(
      username: _username,
      email: _email,
      password: _password,
      confirmPassword: _confirmPassword,
      inviteCode: _inviteCode,
      isLoading: _isLoading,
      errorMessage: _errorMessage,
      showPassword: _showPassword,
      showConfirmPassword: _showConfirmPassword,
      agreeToTerms: _agreeToTerms,
    );
    
    final callbacks = RegisterPageCallbacks(
      onRegister: _handleRegister,
      onNavigateToLogin: () => Navigator.pop(context),
      onTogglePasswordVisibility: () => setState(() { _showPassword = !_showPassword; }),
      onToggleConfirmPasswordVisibility: () => setState(() { _showConfirmPassword = !_showConfirmPassword; }),
      onToggleAgreeToTerms: (v) => setState(() { _agreeToTerms = v; }),
      onViewTerms: () { /* TODO: 显示用户协议 */ },
      onViewPrivacy: () { /* TODO: 显示隐私政策 */ },
    );
    
    return UIRegistry().buildPage<RegisterPageContract>(data: data, callbacks: callbacks);
  }
}

