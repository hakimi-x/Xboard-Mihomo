enum PaymentStep {
  cancelingOrders,
  createOrder,
  loadingPayment,
  verifyPayment,
  waitingPayment,
  paymentSuccess,
}
extension PaymentStepExtension on PaymentStep {
  String get description {
    switch (this) {
      case PaymentStep.cancelingOrders:
        return '正在取消旧订单...';
      case PaymentStep.createOrder:
        return '正在创建订单...';
      case PaymentStep.loadingPayment:
        return '正在加载支付信息...';
      case PaymentStep.verifyPayment:
        return '正在验证支付...';
      case PaymentStep.waitingPayment:
        return '等待支付...';
      case PaymentStep.paymentSuccess:
        return '支付成功';
    }
  }
  bool get isFinal {
    return this == PaymentStep.paymentSuccess;
  }
}