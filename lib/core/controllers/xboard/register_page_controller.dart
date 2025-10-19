/// 注册页面控制器
///
/// 负责：
/// 1. 监听配置状态
/// 2. 准备注册页面数据
/// 3. 处理注册业务逻辑
/// 4. 使用 UIRegistry 动态构建页面

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:fl_clash/xboard/features/auth/auth.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
import 'package:fl_clash/xboard/services/services.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPageController extends ConsumerStatefulWidget {
  const RegisterPageController({super.key});

  @override
  ConsumerState<RegisterPageController> createState() => _RegisterPageControllerState();
}

class _RegisterPageControllerState extends ConsumerState<RegisterPageController> {
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _inviteCode = '';
  String _emailCode = '';
  bool _isRegistering = false;
  bool _isSendingEmailCode = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  Future<void> _handleRegister() async {
    // 验证表单
    if (_email.isEmpty || _password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.pleaseEnterEmailAddress)),
      );
      return;
    }

    if (!_email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.pleaseEnterValidEmailAddress)),
      );
      return;
    }

    if (_password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.passwordMin8Chars)),
      );
      return;
    }

    if (_password != _confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.passwordsDoNotMatch)),
      );
      return;
    }

    // 检查邀请码（如果必填）
    final config = ref.read(configProvider).value;
    if (config?.isInviteForce == true && _inviteCode.trim().isEmpty) {
      _showInviteCodeDialog();
      return;
    }

    setState(() {
      _isRegistering = true;
    });

    try {
      final result = await XBoardSDK.register(
        email: _email,
        password: _password,
        inviteCode: _inviteCode,
        emailCode: _emailCode,
      );

      if (result == null) {
        throw Exception(appLocalizations.xboardRegisterFailed);
      }

      if (mounted) {
        final storageService = ref.read(storageServiceProvider);
        await storageService.saveCredentials(
          _email,
          _password,
          true, // 启用记住密码
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.xboardRegisterSuccess),
              duration: const Duration(seconds: 1),
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.of(context).pop();
            }
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.registrationFailed(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRegistering = false;
        });
      }
    }
  }

  Future<void> _handleSendEmailCode() async {
    if (_email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.pleaseEnterEmailAddress)),
      );
      return;
    }

    if (!_email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.pleaseEnterValidEmailAddress)),
      );
      return;
    }

    setState(() {
      _isSendingEmailCode = true;
    });

    try {
      await XBoardSDK.sendVerificationCode(_email);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(appLocalizations.verificationCodeSentCheckEmail),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.sendVerificationCodeFailed(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSendingEmailCode = false;
        });
      }
    }
  }

  void _showInviteCodeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appLocalizations.inviteCodeRequired),
          content: Text(appLocalizations.inviteCodeRequiredMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(appLocalizations.iUnderstand),
            ),
          ],
        );
      },
    );
  }

  void _handleBackToLogin() {
    Navigator.of(context).pop();
  }

  void _handleTogglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _handleToggleConfirmPasswordVisibility() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(configProvider);

    final config = configAsync.value;
    final isEmailVerify = config?.isEmailVerify ?? false;
    final isInviteForce = config?.isInviteForce ?? false;
    final isConfigLoading = configAsync.isLoading;

    // 准备契约数据
    final data = RegisterPageData(
      email: _email,
      password: _password,
      confirmPassword: _confirmPassword,
      inviteCode: _inviteCode,
      emailCode: _emailCode,
      isRegistering: _isRegistering,
      isSendingEmailCode: _isSendingEmailCode,
      showPassword: _showPassword,
      showConfirmPassword: _showConfirmPassword,
      isEmailVerify: isEmailVerify,
      isInviteForce: isInviteForce,
      isConfigLoading: isConfigLoading,
    );

    // 准备回调
    final callbacks = RegisterPageCallbacks(
      onRegister: _handleRegister,
      onSendEmailCode: _handleSendEmailCode,
      onBackToLogin: _handleBackToLogin,
      onTogglePasswordVisibility: _handleTogglePasswordVisibility,
      onToggleConfirmPasswordVisibility: _handleToggleConfirmPasswordVisibility,
      onEmailChanged: (value) => setState(() => _email = value),
      onPasswordChanged: (value) => setState(() => _password = value),
      onConfirmPasswordChanged: (value) => setState(() => _confirmPassword = value),
      onInviteCodeChanged: (value) => setState(() => _inviteCode = value),
      onEmailCodeChanged: (value) => setState(() => _emailCode = value),
    );

    // 使用 UIRegistry 动态构建页面
    return UIRegistry().buildPage<RegisterPageContract>(
      data: data,
      callbacks: callbacks,
    );
  }
}
