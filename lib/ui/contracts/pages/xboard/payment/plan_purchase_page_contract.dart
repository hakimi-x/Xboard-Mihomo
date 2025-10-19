/// 套餐购买页面契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

/// 套餐购买页面契约
abstract class PlanPurchasePageContract extends PageContract<PlanPurchasePageData, PlanPurchasePageCallbacks> {
  const PlanPurchasePageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 套餐周期类型
enum PlanPeriod {
  monthly,      // 月付
  quarterly,    // 季付
  semiAnnually, // 半年付
  annually,     // 年付
}

/// 套餐信息
class PlanInfo {
  final String id;
  final String name;
  final String description;
  final int monthlyPrice;
  final int quarterlyPrice;
  final int semiAnnuallyPrice;
  final int annuallyPrice;
  final int trafficLimit;  // GB
  final int deviceLimit;
  final List<String> features;
  final bool isPopular;
  final bool isRecommended;

  const PlanInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.monthlyPrice,
    required this.quarterlyPrice,
    required this.semiAnnuallyPrice,
    required this.annuallyPrice,
    required this.trafficLimit,
    required this.deviceLimit,
    required this.features,
    this.isPopular = false,
    this.isRecommended = false,
  });
  
  int getPriceForPeriod(PlanPeriod period) {
    switch (period) {
      case PlanPeriod.monthly:
        return monthlyPrice;
      case PlanPeriod.quarterly:
        return quarterlyPrice;
      case PlanPeriod.semiAnnually:
        return semiAnnuallyPrice;
      case PlanPeriod.annually:
        return annuallyPrice;
    }
  }
  
  String getPeriodLabel(PlanPeriod period) {
    switch (period) {
      case PlanPeriod.monthly:
        return '月付';
      case PlanPeriod.quarterly:
        return '季付';
      case PlanPeriod.semiAnnually:
        return '半年付';
      case PlanPeriod.annually:
        return '年付';
    }
  }
}

/// 支付方式
class PaymentMethod {
  final String id;
  final String name;
  final String icon;
  final bool isEnabled;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.isEnabled,
  });
}

/// 优惠券信息
class CouponInfo {
  final String code;
  final String description;
  final double discountPercentage;
  final int discountAmount;
  final DateTime? expireDate;

  const CouponInfo({
    required this.code,
    required this.description,
    this.discountPercentage = 0,
    this.discountAmount = 0,
    this.expireDate,
  });
}

/// 套餐购买页面数据
class PlanPurchasePageData implements DataModel {
  /// 套餐列表
  final List<PlanInfo> plans;
  
  /// 当前选中的套餐
  final PlanInfo? selectedPlan;
  
  /// 当前选中的周期
  final PlanPeriod selectedPeriod;
  
  /// 支付方式列表
  final List<PaymentMethod> paymentMethods;
  
  /// 当前选中的支付方式
  final PaymentMethod? selectedPaymentMethod;
  
  /// 优惠券信息
  final CouponInfo? appliedCoupon;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 错误信息
  final String? errorMessage;

  const PlanPurchasePageData({
    this.plans = const [],
    this.selectedPlan,
    this.selectedPeriod = PlanPeriod.monthly,
    this.paymentMethods = const [],
    this.selectedPaymentMethod,
    this.appliedCoupon,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'plans': plans.map((p) => {
        'id': p.id,
        'name': p.name,
        'description': p.description,
      }).toList(),
      'selectedPlan': selectedPlan?.id,
      'selectedPeriod': selectedPeriod.toString(),
      'paymentMethods': paymentMethods.map((pm) => {
        'id': pm.id,
        'name': pm.name,
      }).toList(),
      'selectedPaymentMethod': selectedPaymentMethod?.id,
      'appliedCoupon': appliedCoupon?.code,
      'isLoading': isLoading,
      'errorMessage': errorMessage,
    };
  }
  
  /// 计算总价
  int get totalPrice {
    if (selectedPlan == null) return 0;
    final basePrice = selectedPlan!.getPriceForPeriod(selectedPeriod);
    if (appliedCoupon == null) return basePrice;
    
    // 计算折扣
    if (appliedCoupon!.discountPercentage > 0) {
      return (basePrice * (1 - appliedCoupon!.discountPercentage / 100)).round();
    }
    if (appliedCoupon!.discountAmount > 0) {
      return (basePrice - appliedCoupon!.discountAmount).clamp(0, basePrice);
    }
    return basePrice;
  }
  
  /// 是否可以提交订单
  bool get canSubmit =>
      selectedPlan != null &&
      selectedPaymentMethod != null &&
      !isLoading;
}

/// 套餐购买页面回调
class PlanPurchasePageCallbacks implements CallbacksModel {
  /// 选择套餐
  final ValueCallback<PlanInfo> onSelectPlan;
  
  /// 选择周期
  final ValueCallback<PlanPeriod> onSelectPeriod;
  
  /// 选择支付方式
  final ValueCallback<PaymentMethod> onSelectPaymentMethod;
  
  /// 应用优惠码
  final Future<CouponInfo?> Function(String code) onApplyCoupon;
  
  /// 移除优惠码
  final VoidCallback onRemoveCoupon;
  
  /// 确认购买
  final AsyncCallback onConfirmPurchase;
  
  /// 查看套餐详情
  final ValueCallback<PlanInfo> onViewPlanDetails;

  const PlanPurchasePageCallbacks({
    required this.onSelectPlan,
    required this.onSelectPeriod,
    required this.onSelectPaymentMethod,
    required this.onApplyCoupon,
    required this.onRemoveCoupon,
    required this.onConfirmPurchase,
    required this.onViewPlanDetails,
  });
}

