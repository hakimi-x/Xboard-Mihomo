/// XBoard首页控制器
///
/// 负责：
/// 1. 监听业务状态（用户登录、订阅状态、延迟测试）
/// 2. 准备页面数据（Data）
/// 3. 准备回调函数（Callbacks）
/// 4. 使用UIRegistry动态构建页面

import 'dart:async';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/xboard/features/auth/providers/xboard_user_provider.dart';
import 'package:fl_clash/xboard/features/latency/services/auto_latency_service.dart';
import 'package:fl_clash/xboard/features/subscription/services/subscription_status_checker.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_page_controller.dart';

class XBoardHomePageController extends ConsumerStatefulWidget {
  const XBoardHomePageController({super.key});

  @override
  ConsumerState<XBoardHomePageController> createState() => _XBoardHomePageControllerState();
}

class _XBoardHomePageControllerState extends ConsumerState<XBoardHomePageController> with PageMixin {
  bool _hasInitialized = false;
  bool _hasStartedLatencyTesting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_hasInitialized) return;
      _hasInitialized = true;

      final userState = ref.read(xboardUserProvider);
      if (userState.isAuthenticated) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            subscriptionStatusChecker.checkSubscriptionStatusOnStartup(context, ref);
          }
        });
      }

      autoLatencyService.initialize(ref);
      _waitForGroupsAndStartTesting();
    });

    // 监听 Token 过期
    ref.listenManual(xboardUserProvider, (previous, next) {
      if (next.errorMessage == 'TOKEN_EXPIRED') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showTokenExpiredDialog();
        });
      }
    });

    // 监听配置变化，强制测试节点
    ref.listenManual(currentProfileProvider, (previous, next) {
      if (previous?.label != next?.label && previous != null) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            autoLatencyService.testCurrentNode(forceTest: true);
          }
        });
      }
    });

    // 监听节点组加载完成，开始延迟测试
    ref.listenManual(groupsProvider, (previous, next) {
      if ((previous?.isEmpty ?? true) && next.isNotEmpty && !_hasStartedLatencyTesting) {
        _hasStartedLatencyTesting = true;
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            _performInitialLatencyTest();
          }
        });
      }
    });
  }

  void _waitForGroupsAndStartTesting() {
    if (_hasStartedLatencyTesting) {
      return;
    }
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      try {
        final groups = ref.read(groupsProvider);
        if (groups.isNotEmpty && !_hasStartedLatencyTesting) {
          timer.cancel();
          _hasStartedLatencyTesting = true;
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              _performInitialLatencyTest();
            }
          });
        }
      } catch (e) {
        // 忽略错误，继续等待
      }
    });
  }

  void _performInitialLatencyTest() {
    if (!mounted) return;
    autoLatencyService.testCurrentNode();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final userState = ref.read(xboardUserProvider);
        if (userState.isAuthenticated) {
          autoLatencyService.testCurrentGroupNodes();
        }
      }
    });
  }

  void _showTokenExpiredDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(appLocalizations.xboardTokenExpiredTitle),
        content: Text(appLocalizations.xboardTokenExpiredContent),
        actions: [
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final userNotifier = ref.read(xboardUserProvider.notifier);
              navigator.pop();
              if (!mounted) return;
              userNotifier.clearTokenExpiredError();
              await userNotifier.handleTokenExpired();
              if (!mounted) return;
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginPageController(),
                ),
                (route) => false,
              );
            },
            child: Text(appLocalizations.xboardRelogin),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    // 刷新订阅状态
    final userNotifier = ref.read(xboardUserProvider.notifier);
    await userNotifier.refreshUserInfo();
  }

  void _handleManageSubscription() {
    Navigator.of(context).pushNamed('/subscription');
  }

  void _handlePurchasePlan() {
    Navigator.of(context).pushNamed('/plan_purchase');
  }

  void _handleProfile() {
    // TODO: 导航到个人中心
  }

  void _handleOnlineSupport() {
    Navigator.of(context).pushNamed('/online_support');
  }

  void _handleInvite() {
    Navigator.of(context).pushNamed('/invite');
  }

  void _handleViewNotice(NoticeInfo notice) {
    // TODO: 显示公告详情
  }

  Future<void> _handleLogout() async {
    final userNotifier = ref.read(xboardUserProvider.notifier);
    await userNotifier.logout();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPageController(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(xboardUserProvider);
    final userInfoData = ref.watch(userInfoProvider);
    final subscriptionInfoData = ref.watch(subscriptionInfoProvider);

    // 使用实际的用户数据
    final data = XBoardHomePageData(
      userInfo: UserInfo(
        username: userInfoData?.email ?? 'Guest',
        email: userInfoData?.email ?? 'guest@example.com',
        userId: userInfoData?.planId ?? 0, // UserInfo 没有 id 字段，使用 planId 代替
      ),
      subscriptionStatus: SubscriptionStatus(
        planName: subscriptionInfoData?.plan?.name ?? '未订阅',
        expireDate: subscriptionInfoData?.expiredAt,
        remainingDays: _calculateRemainingDays(subscriptionInfoData?.expiredAt),
        isExpired: _isExpired(subscriptionInfoData?.expiredAt),
        isActive: subscriptionInfoData != null && !_isExpired(subscriptionInfoData.expiredAt),
      ),
      trafficStats: TrafficStats(
        usedTraffic: ((subscriptionInfoData?.u ?? 0) + (subscriptionInfoData?.d ?? 0)),
        totalTraffic: subscriptionInfoData?.transferEnable ?? 0,
        uploadTraffic: subscriptionInfoData?.u ?? 0,
        downloadTraffic: subscriptionInfoData?.d ?? 0,
        usagePercentage: _calculateUsagePercentage(subscriptionInfoData),
      ),
      notices: const [],
      isLoading: userState.isLoading,
      isRefreshing: userState.isLoading,
    );

    final callbacks = XBoardHomePageCallbacks(
      onRefresh: _handleRefresh,
      onManageSubscription: _handleManageSubscription,
      onPurchasePlan: _handlePurchasePlan,
      onProfile: _handleProfile,
      onOnlineSupport: _handleOnlineSupport,
      onInvite: _handleInvite,
      onViewNotice: _handleViewNotice,
      onLogout: _handleLogout,
    );

    return UIRegistry().buildPage<XBoardHomePageContract>(
      data: data,
      callbacks: callbacks,
    );
  }

  int _calculateRemainingDays(DateTime? expiredAt) {
    if (expiredAt == null) return 0;
    final now = DateTime.now();
    final difference = expiredAt.difference(now);
    return difference.inDays.clamp(0, 9999);
  }

  bool _isExpired(DateTime? expiredAt) {
    if (expiredAt == null) return true;
    return DateTime.now().isAfter(expiredAt);
  }

  double _calculateUsagePercentage(sdk.SubscriptionInfo? subscriptionInfo) {
    if (subscriptionInfo == null || subscriptionInfo.transferEnable == null || subscriptionInfo.transferEnable == 0) {
      return 0;
    }
    final used = (subscriptionInfo.u ?? 0) + (subscriptionInfo.d ?? 0);
    return (used / subscriptionInfo.transferEnable!) * 100;
  }
}

