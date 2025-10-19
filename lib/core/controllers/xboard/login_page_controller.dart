/// 登录页面控制器
/// 
/// 负责：
/// 1. 监听业务状态（Provider）
/// 2. 准备页面数据（Data）
/// 3. 准备回调函数（Callbacks）
/// 4. 使用UIRegistry动态构建页面

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fl_clash/xboard/features/auth/providers/xboard_user_provider.dart';

class LoginPageController extends ConsumerStatefulWidget {
  const LoginPageController({super.key});

  @override
  ConsumerState<LoginPageController> createState() => _LoginPageControllerState();
}

class _LoginPageControllerState extends ConsumerState<LoginPageController> {
  String _username = '';
  String _password = '';
  bool _rememberMe = false;
  bool _showPassword = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    // TODO: 从存储服务加载已保存的凭据
    // final savedEmail = await _storageService.getSavedEmail();
    // final savedPassword = await _storageService.getSavedPassword();
    // setState(() {
    //   _username = savedEmail ?? '';
    //   _password = savedPassword ?? '';
    // });
  }

  Future<void> _handleLogin(String username, String password, bool rememberMe) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // TODO: 调用实际的登录逻辑
      // final userNotifier = ref.read(xboardUserProvider.notifier);
      // final success = await userNotifier.login(username, password);
      
      // 临时模拟
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        // TODO: 登录成功后导航到主页
        // if (success) {
        //   if (rememberMe) {
        //     await _storageService.saveCredentials(username, password, true);
        //   }
        //   Navigator.pushReplacementNamed(context, '/xboard_home');
        // }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleNavigateToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  void _handleNavigateToForgotPassword() {
    Navigator.pushNamed(context, '/forgot_password');
  }

  void _handleTogglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _handleToggleRememberMe(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 监听实际的业务状态
    // final authState = ref.watch(xboardUserProvider);
    
    // 准备契约数据
    final data = LoginPageData(
      username: _username,
      password: _password,
      rememberMe: _rememberMe,
      isLoading: _isLoading,
      errorMessage: _errorMessage,
      showPassword: _showPassword,
    );
    
    // 准备回调
    final callbacks = LoginPageCallbacks(
      onLogin: _handleLogin,
      onNavigateToRegister: _handleNavigateToRegister,
      onNavigateToForgotPassword: _handleNavigateToForgotPassword,
      onTogglePasswordVisibility: _handleTogglePasswordVisibility,
      onToggleRememberMe: _handleToggleRememberMe,
    );
    
    // 使用 UIRegistry 动态构建页面
    return UIRegistry().buildPage<LoginPageContract>(
      data: data,
      callbacks: callbacks,
    );
  }
}

