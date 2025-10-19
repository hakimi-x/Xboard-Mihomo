/// 登录页面控制器
/// 
/// 负责：
/// 1. 监听业务状态（Provider）
/// 2. 准备页面数据（Data）
/// 3. 准备回调函数（Callbacks）
/// 4. 使用UIRegistry动态构建页面

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:fl_clash/xboard/features/auth/providers/xboard_user_provider.dart';
import 'package:fl_clash/xboard/features/domain_status/domain_status.dart';
import 'package:fl_clash/xboard/services/services.dart';
import 'package:fl_clash/xboard/config/utils/config_file_loader.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'register_page_controller.dart';
import 'forgot_password_page_controller.dart';

class LoginPageController extends ConsumerStatefulWidget {
  const LoginPageController({super.key});

  @override
  ConsumerState<LoginPageController> createState() => _LoginPageControllerState();
}

class _LoginPageControllerState extends ConsumerState<LoginPageController> {
  String _appTitle = 'XBoard';
  String _appWebsite = '';
  String _username = '';
  String _password = '';
  bool _rememberMe = false;
  bool _showPassword = false;
  late XBoardStorageService _storageService;

  @override
  void initState() {
    super.initState();
    _storageService = ref.read(storageServiceProvider);
    _loadSavedCredentials();
    _checkDomainStatus();
    _loadAppInfo();
  }

  /// 加载应用信息（标题和网站）
  Future<void> _loadAppInfo() async {
    final title = await ConfigFileLoaderHelper.getAppTitle();
    final website = await ConfigFileLoaderHelper.getAppWebsite();
    if (mounted) {
      setState(() {
        _appTitle = title;
        _appWebsite = website;
      });
    }
  }

  Future<void> _checkDomainStatus() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(domainStatusProvider.notifier).checkDomain();
    });
  }

  Future<void> _loadSavedCredentials() async {
    try {
      final savedEmail = await _storageService.getSavedEmail();
      final savedPassword = await _storageService.getSavedPassword();
      final rememberPassword = await _storageService.getRememberPassword();
      
      if (mounted) {
        setState(() {
          if (savedEmail != null && savedEmail.isNotEmpty) {
            _username = savedEmail;
          }
          if (savedPassword != null && savedPassword.isNotEmpty && rememberPassword) {
            _password = savedPassword;
          }
          _rememberMe = rememberPassword;
        });
      }
    } catch (e) {
      // 忽略加载凭据失败，继续正常流程
    }
  }

  Future<void> _handleLogin(String username, String password, bool rememberMe) async {
    final userNotifier = ref.read(xboardUserProvider.notifier);
    final success = await userNotifier.login(username, password);
    
    if (mounted) {
      if (success) {
        if (rememberMe) {
          await _storageService.saveCredentials(username, password, true);
        } else {
          await _storageService.saveCredentials(username, '', false);
        }
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.xboardLoginSuccess),
              duration: const Duration(seconds: 1),
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (route) => false,
              );
            }
          });
        }
      } else {
        final userState = ref.read(xboardUserProvider);
        if (userState.errorMessage != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${appLocalizations.xboardLoginFailed}: ${userState.errorMessage}'),
            ),
          );
        }
      }
    }
  }

  void _handleNavigateToRegister() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const RegisterPageController()),
    );
    _loadSavedCredentials();
    _checkDomainStatus();
  }

  void _handleNavigateToForgotPassword() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ForgotPasswordPageController()),
    );
    _checkDomainStatus();
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

  void _handleUsernameChanged(String value) {
    setState(() {
      _username = value;
    });
  }

  void _handlePasswordChanged(String value) {
    setState(() {
      _password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(xboardUserProvider);
    final domainStatus = ref.watch(domainStatusProvider);
    
    // 准备契约数据
    final data = LoginPageData(
      appTitle: _appTitle,
      appWebsite: _appWebsite,
      username: _username,
      password: _password,
      rememberMe: _rememberMe,
      isLoading: userState.isLoading,
      errorMessage: userState.errorMessage,
      showPassword: _showPassword,
      isDomainReady: domainStatus.isReady,
    );
    
    // 准备回调
    final callbacks = LoginPageCallbacks(
      onLogin: _handleLogin,
      onNavigateToRegister: _handleNavigateToRegister,
      onNavigateToForgotPassword: _handleNavigateToForgotPassword,
      onTogglePasswordVisibility: _handleTogglePasswordVisibility,
      onToggleRememberMe: _handleToggleRememberMe,
      onUsernameChanged: _handleUsernameChanged,
      onPasswordChanged: _handlePasswordChanged,
    );
    
    // 使用 UIRegistry 动态构建页面
    return UIRegistry().buildPage<LoginPageContract>(
      data: data,
      callbacks: callbacks,
    );
  }
}

