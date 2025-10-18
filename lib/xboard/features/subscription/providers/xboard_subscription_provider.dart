import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/auth/auth.dart';
import 'package:fl_clash/xboard/features/auth/providers/xboard_user_provider.dart';
class XBoardSubscriptionNotifier extends Notifier<List<PlanData>> {
  @override
  List<PlanData> build() {
    ref.listen(xboardUserAuthProvider, (previous, next) {
      if (next.isAuthenticated) {
        if (previous?.isAuthenticated != true) {
          loadPlans();
        }
      } else if (!next.isAuthenticated) {
        _clearPlans();
      }
    });
    return const [];
  }
  Future<void> loadPlans() async {
    final userAuthState = ref.read(xboardUserAuthProvider);
    if (!userAuthState.isAuthenticated) {
      state = [];
      ref.read(userUIStateProvider.notifier).state = const UIState(
        errorMessage: '请先登录',
      );
      return;
    }
    ref.read(userUIStateProvider.notifier).state = const UIState(isLoading: true);
    try {
      commonPrint.log('开始加载套餐列表...');
      final plans = await XBoardSDK.getPlans();
      final visiblePlans = plans.where((plan) => plan.isVisible).toList();
      state = visiblePlans;
      ref.read(userUIStateProvider.notifier).state = UIState(
        isLoading: false,
        lastUpdated: DateTime.now(),
      );
      commonPrint.log('套餐列表加载成功，共 ${visiblePlans.length} 个可见套餐');
    } catch (e) {
      commonPrint.log('加载套餐列表失败: $e');
      ref.read(userUIStateProvider.notifier).state = UIState(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
  Future<void> refreshPlans() async {
    commonPrint.log('刷新套餐列表...');
    await loadPlans();
  }
  PlanData? getPlanById(int planId) {
    try {
      return state.firstWhere((plan) => plan.id == planId);
    } catch (e) {
      return null;
    }
  }
  List<PlanData> get plansWithPrice {
    return state.where((plan) => plan.hasPrice).toList();
  }
  List<PlanData> get recommendedPlans {
    return state.where((plan) => plan.isVisible && plan.hasPrice).take(3).toList();
  }
  void _clearPlans() {
    commonPrint.log('清空套餐列表');
    state = [];
    ref.read(userUIStateProvider.notifier).state = const UIState();
  }
  void clearError() {
    final uiState = ref.read(userUIStateProvider);
    if (uiState.errorMessage != null) {
      ref.read(userUIStateProvider.notifier).state = uiState.clearError();
    }
  }
  bool get needsRefresh {
    final uiState = ref.read(userUIStateProvider);
    if (uiState.lastUpdated == null) return true;
    final now = DateTime.now();
    final diff = now.difference(uiState.lastUpdated!);
    return diff.inMinutes > 10; // 10分钟后需要刷新
  }
  Future<void> autoRefreshIfNeeded() async {
    final uiState = ref.read(userUIStateProvider);
    if (needsRefresh && !uiState.isLoading) {
      await refreshPlans();
    }
  }
}
final xboardSubscriptionProvider = NotifierProvider<XBoardSubscriptionNotifier, List<PlanData>>(
  XBoardSubscriptionNotifier.new,
);
final xboardPlanProvider = Provider.family<PlanData?, int>((ref, planId) {
  final plans = ref.watch(xboardSubscriptionProvider);
  try {
    return plans.firstWhere((plan) => plan.id == planId);
  } catch (e) {
    return null;
  }
});
final xboardPlansWithPriceProvider = Provider<List<PlanData>>((ref) {
  final plans = ref.watch(xboardSubscriptionProvider);
  return plans.where((plan) => plan.hasPrice).toList();
});
final xboardRecommendedPlansProvider = Provider<List<PlanData>>((ref) {
  final plans = ref.watch(xboardSubscriptionProvider);
  return plans.where((plan) => plan.isVisible && plan.hasPrice).take(3).toList();
}); 