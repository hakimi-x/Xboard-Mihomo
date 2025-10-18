import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
import 'package:fl_clash/xboard/features/auth/providers/xboard_user_provider.dart';
import 'package:fl_clash/xboard/features/subscription/providers/xboard_subscription_provider.dart';
import 'plan_purchase_page.dart';
import '../widgets/plan_description_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class PlansView extends ConsumerStatefulWidget {
  const PlansView({super.key});
  @override
  ConsumerState<PlansView> createState() => _PlansViewState();
}
class _PlansViewState extends ConsumerState<PlansView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final subscriptionNotifier = ref.read(xboardSubscriptionProvider.notifier);
      subscriptionNotifier.autoRefreshIfNeeded();
    });
  }
  Future<void> _refreshPlans() async {
    final subscriptionNotifier = ref.read(xboardSubscriptionProvider.notifier);
    await subscriptionNotifier.refreshPlans();
  }
  String _formatPrice(double? price) {
    if (price == null) return '-';
    return '¥${price.toStringAsFixed(2)}';
  }
  String _formatTraffic(double transferEnable) {
    if (transferEnable >= 1024) {
      return '${(transferEnable / 1024).toStringAsFixed(1)}TB';
    }
    return '${transferEnable.toStringAsFixed(0)}GB';
  }
  String _getLowestPrice(PlanData plan) {
    List<double> prices = [];
    if (plan.monthPrice != null) prices.add(plan.monthPrice!);
    if (plan.quarterPrice != null) prices.add(plan.quarterPrice!);
    if (plan.halfYearPrice != null) prices.add(plan.halfYearPrice!);
    if (plan.yearPrice != null) prices.add(plan.yearPrice!);
    if (plan.twoYearPrice != null) prices.add(plan.twoYearPrice!);
    if (plan.threeYearPrice != null) prices.add(plan.threeYearPrice!);
    if (plan.onetimePrice != null) prices.add(plan.onetimePrice!);
    if (prices.isEmpty) return '-';
    final lowestPrice = prices.reduce((a, b) => a < b ? a : b);
    return _formatPrice(lowestPrice);
  }
  int? _getSpeedLimitText(PlanData plan) {
    // 直接使用PlanData模型中的formattedSpeedLimit方法
    return plan.speedLimit;
  }
  Widget _buildPlanCard(PlanData plan) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    return Card(
      margin: isDesktop 
        ? EdgeInsets.zero 
        : const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: IntrinsicHeight(
        child: Padding(
        padding: EdgeInsets.all(isDesktop ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    plan.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (plan.hasPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade600],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _getLowestPrice(plan),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: isDesktop ? 8 : 12),
            Row(
              children: [
                Icon(Icons.data_usage, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  '${AppLocalizations.of(context).xboardTraffic}: ${_formatTraffic(plan.transferEnable)}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(width: 16),
                Icon(Icons.speed, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  '${AppLocalizations.of(context).xboardSpeedLimit}: ${_getSpeedLimitText(plan)}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            if (plan.content != null) ...[
              SizedBox(height: isDesktop ? 8 : 12),
              PlanDescriptionWidget(content: plan.content!),
            ],
            SizedBox(height: isDesktop ? 12 : 20),
            if (plan.hasPrice)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _navigateToPurchase(plan),
                  icon: const Icon(Icons.shopping_cart),
                  label: Text(appLocalizations.xboardBuyNow),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: isDesktop ? 8 : 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
          ],
        ),
        ),
      ),
    );
  }
  void _navigateToPurchase(PlanData plan) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlanPurchasePage(plan: plan),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    return Scaffold(
      appBar: isDesktop ? null : AppBar(
        title: Text(appLocalizations.xboardPlanInfo),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPlans,
        child: Consumer(
          builder: (context, ref, child) {
            final plans = ref.watch(xboardSubscriptionProvider);
            final uiState = ref.watch(userUIStateProvider);
            if (uiState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (uiState.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '加载失败',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      uiState.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _refreshPlans,
                      child: Text(appLocalizations.xboardRetry),
                    ),
                  ],
                ),
              );
            }
            if (plans.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      '暂无套餐信息',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }
            final screenWidth = MediaQuery.of(context).size.width;
            final isDesktop = screenWidth > 768;
            if (isDesktop) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: plans.map((plan) {
                    return SizedBox(
                      width: 350, // 固定宽度
                      child: _buildPlanCard(plan),
                    );
                  }).toList(),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  return _buildPlanCard(plans[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}