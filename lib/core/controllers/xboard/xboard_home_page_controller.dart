/// XBoard首页控制器
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class XBoardHomePageController extends ConsumerStatefulWidget {
  const XBoardHomePageController({super.key});

  @override
  ConsumerState<XBoardHomePageController> createState() => _XBoardHomePageControllerState();
}

class _XBoardHomePageControllerState extends ConsumerState<XBoardHomePageController> {
  bool _isLoading = false;
  bool _isRefreshing = false;

  @override
  Widget build(BuildContext context) {
    // TODO: 从Provider获取真实数据
    // final userState = ref.watch(xboardUserProvider);
    // final subscriptionState = ref.watch(subscriptionProvider);
    
    final data = XBoardHomePageData(
      userInfo: const UserInfo(username: 'Demo User', email: 'demo@example.com', userId: 1),
      subscriptionStatus: const SubscriptionStatus(
        planName: '基础套餐',
        expireDate: null,
        remainingDays: 30,
        isExpired: false,
        isActive: true,
      ),
      trafficStats: const TrafficStats(
        usedTraffic: 5000000000,
        totalTraffic: 10000000000,
        uploadTraffic: 2000000000,
        downloadTraffic: 3000000000,
        usagePercentage: 50,
      ),
      notices: const [],
      isLoading: _isLoading,
      isRefreshing: _isRefreshing,
    );
    
    final callbacks = XBoardHomePageCallbacks(
      onRefresh: () async {
        setState(() { _isRefreshing = true; });
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) setState(() { _isRefreshing = false; });
      },
      onManageSubscription: () => Navigator.pushNamed(context, '/subscription'),
      onPurchasePlan: () => Navigator.pushNamed(context, '/plan_purchase'),
      onProfile: () { /* TODO: 导航到个人中心 */ },
      onOnlineSupport: () => Navigator.pushNamed(context, '/online_support'),
      onInvite: () => Navigator.pushNamed(context, '/invite'),
      onViewNotice: (notice) { /* TODO: 显示公告详情 */ },
      onLogout: () async { /* TODO: 退出登录逻辑 */ },
    );
    
    return UIRegistry().buildPage<XBoardHomePageContract>(data: data, callbacks: callbacks);
  }
}

