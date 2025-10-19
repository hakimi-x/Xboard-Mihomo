/// 支付网关页面契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

/// 支付网关页面契约
abstract class PaymentGatewayPageContract extends PageContract<PaymentGatewayPageData, PaymentGatewayPageCallbacks> {
  const PaymentGatewayPageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 支付状态
enum PaymentStatus {
  pending,    // 等待支付
  processing, // 支付处理中
  success,    // 支付成功
  failed,     // 支付失败
  cancelled,  // 已取消
  timeout,    // 超时
}

/// 订单信息
class OrderInfo {
  final String orderId;
  final String planName;
  final String period;
  final int amount;
  final DateTime createdAt;
  final DateTime? expireAt;

  const OrderInfo({
    required this.orderId,
    required this.planName,
    required this.period,
    required this.amount,
    required this.createdAt,
    this.expireAt,
  });
}

/// 支付网关页面数据
class PaymentGatewayPageData implements DataModel {
  /// 订单信息
  final OrderInfo orderInfo;
  
  /// 支付状态
  final PaymentStatus paymentStatus;
  
  /// 支付链接/二维码
  final String? paymentUrl;
  
  /// 是否正在检查支付状态
  final bool isCheckingStatus;
  
  /// 倒计时秒数
  final int countdown;
  
  /// 错误信息
  final String? errorMessage;
  
  /// 成功信息
  final String? successMessage;

  const PaymentGatewayPageData({
    required this.orderInfo,
    this.paymentStatus = PaymentStatus.pending,
    this.paymentUrl,
    this.isCheckingStatus = false,
    this.countdown = 0,
    this.errorMessage,
    this.successMessage,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'orderInfo': {
        'orderId': orderInfo.orderId,
        'planName': orderInfo.planName,
        'period': orderInfo.period,
        'amount': orderInfo.amount,
        'createdAt': orderInfo.createdAt.toIso8601String(),
        'expireAt': orderInfo.expireAt?.toIso8601String(),
      },
      'paymentStatus': paymentStatus.toString(),
      'paymentUrl': paymentUrl,
      'isCheckingStatus': isCheckingStatus,
      'countdown': countdown,
      'errorMessage': errorMessage,
      'successMessage': successMessage,
    };
  }
  
  /// 格式化金额
  String get formattedAmount {
    return '¥${(orderInfo.amount / 100).toStringAsFixed(2)}';
  }
  
  /// 格式化倒计时
  String get formattedCountdown {
    final minutes = countdown ~/ 60;
    final seconds = countdown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  
  /// 是否可以重试
  bool get canRetry =>
      paymentStatus == PaymentStatus.failed ||
      paymentStatus == PaymentStatus.timeout;
  
  /// 是否完成（成功或失败）
  bool get isCompleted =>
      paymentStatus == PaymentStatus.success ||
      paymentStatus == PaymentStatus.failed ||
      paymentStatus == PaymentStatus.cancelled ||
      paymentStatus == PaymentStatus.timeout;
}

/// 支付网关页面回调
class PaymentGatewayPageCallbacks implements CallbacksModel {
  /// 打开支付页面（浏览器/应用）
  final AsyncCallback onOpenPaymentPage;
  
  /// 检查支付状态
  final AsyncCallback onCheckPaymentStatus;
  
  /// 取消订单
  final AsyncCallback onCancelOrder;
  
  /// 重试支付
  final AsyncCallback onRetryPayment;
  
  /// 返回首页
  final VoidCallback onBackToHome;
  
  /// 查看订单详情
  final VoidCallback onViewOrderDetails;
  
  /// 复制支付链接
  final VoidCallback onCopyPaymentUrl;

  const PaymentGatewayPageCallbacks({
    required this.onOpenPaymentPage,
    required this.onCheckPaymentStatus,
    required this.onCancelOrder,
    required this.onRetryPayment,
    required this.onBackToHome,
    required this.onViewOrderDetails,
    required this.onCopyPaymentUrl,
  });
}

