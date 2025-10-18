/// 支付处理状态
class PaymentProcessState {
  final bool isProcessingPayment;
  final String? currentOrderTradeNo;

  const PaymentProcessState({
    this.isProcessingPayment = false,
    this.currentOrderTradeNo,
  });

  PaymentProcessState copyWith({
    bool? isProcessingPayment,
    String? currentOrderTradeNo,
  }) {
    return PaymentProcessState(
      isProcessingPayment: isProcessingPayment ?? this.isProcessingPayment,
      currentOrderTradeNo: currentOrderTradeNo ?? this.currentOrderTradeNo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaymentProcessState &&
        other.isProcessingPayment == isProcessingPayment &&
        other.currentOrderTradeNo == currentOrderTradeNo;
  }

  @override
  int get hashCode {
    return isProcessingPayment.hashCode ^ currentOrderTradeNo.hashCode;
  }
}

