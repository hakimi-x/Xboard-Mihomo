import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart' hide PaymentMethod;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanPurchasePageController extends ConsumerStatefulWidget {
  final PlanData plan;
  
  const PlanPurchasePageController({
    super.key,
    required this.plan,
  });

  @override
  ConsumerState<PlanPurchasePageController> createState() => _PlanPurchasePageControllerState();
}

class _PlanPurchasePageControllerState extends ConsumerState<PlanPurchasePageController> {
  PlanPeriod _selectedPeriod = PlanPeriod.monthly;
  PaymentMethod? _selectedPaymentMethod;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // 将 PlanData 转换为 PlanInfo（简化版本，仅用于演示）
    final planInfo = PlanInfo(
      id: widget.plan.id.toString(),
      name: widget.plan.name,
      description: widget.plan.content ?? '',
      monthlyPrice: (widget.plan.monthPrice ?? 0).toInt(),
      quarterlyPrice: (widget.plan.quarterPrice ?? 0).toInt(),
      semiAnnuallyPrice: (widget.plan.halfYearPrice ?? 0).toInt(),
      annuallyPrice: (widget.plan.yearPrice ?? 0).toInt(),
      trafficLimit: (widget.plan.transferEnable ?? 0).toInt(),
      deviceLimit: 3, // PlanData 没有 deviceLimit 字段，使用默认值
      features: [], // TODO: 从 plan 中提取特性
    );
    
    final data = PlanPurchasePageData(
      plans: [planInfo], // 使用传入的 plan
      selectedPlan: planInfo,
      selectedPeriod: _selectedPeriod,
      paymentMethods: const [], // TODO: 从API获取支付方式
      selectedPaymentMethod: _selectedPaymentMethod,
      isLoading: _isLoading,
    );
    
    final callbacks = PlanPurchasePageCallbacks(
      onSelectPlan: (plan) => setState(() { /* selectedPlan is fixed */ }),
      onSelectPeriod: (period) => setState(() { _selectedPeriod = period; }),
      onSelectPaymentMethod: (method) => setState(() { _selectedPaymentMethod = method; }),
      onApplyCoupon: (code) async { /* TODO: 应用优惠码 */ return null; },
      onRemoveCoupon: () { /* TODO: 移除优惠码 */ },
      onConfirmPurchase: () async {
        setState(() { _isLoading = true; });
        // TODO: 创建订单并跳转到支付页面
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          setState(() { _isLoading = false; });
          Navigator.pushNamed(context, '/payment_gateway');
        }
      },
      onViewPlanDetails: (plan) { /* TODO: 查看套餐详情 */ },
    );
    
    return UIRegistry().buildPage<PlanPurchasePageContract>(data: data, callbacks: callbacks);
  }
}

