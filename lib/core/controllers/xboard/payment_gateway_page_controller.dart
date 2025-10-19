/// 支付网关页面控制器
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentGatewayPageController extends ConsumerStatefulWidget {
  final String orderId;
  
  const PaymentGatewayPageController({super.key, required this.orderId});

  @override
  ConsumerState<PaymentGatewayPageController> createState() => _PaymentGatewayPageControllerState();
}

class _PaymentGatewayPageControllerState extends ConsumerState<PaymentGatewayPageController> {
  PaymentStatus _paymentStatus = PaymentStatus.pending;
  bool _isCheckingStatus = false;
  int _countdown = 300; // 5分钟

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _startAutoCheck();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _countdown > 0 && _paymentStatus == PaymentStatus.pending) {
        setState(() { _countdown--; });
        _startCountdown();
      }
    });
  }

  void _startAutoCheck() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _paymentStatus == PaymentStatus.pending) {
        _checkPaymentStatus();
      }
    });
  }

  Future<void> _checkPaymentStatus() async {
    setState(() { _isCheckingStatus = true; });
    try {
      // TODO: 调用API检查支付状态
      await Future.delayed(const Duration(seconds: 1));
      // 根据结果更新状态
    } finally {
      if (mounted) {
        setState(() { _isCheckingStatus = false; });
        if (_paymentStatus == PaymentStatus.pending) {
          _startAutoCheck();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = PaymentGatewayPageData(
      orderInfo: OrderInfo(
        orderId: widget.orderId,
        planName: '基础套餐',
        period: '月付',
        amount: 1000,
        createdAt: DateTime.now(),
      ),
      paymentStatus: _paymentStatus,
      paymentUrl: 'https://example.com/pay/${widget.orderId}',
      isCheckingStatus: _isCheckingStatus,
      countdown: _countdown,
    );
    
    final callbacks = PaymentGatewayPageCallbacks(
      onOpenPaymentPage: () async { /* TODO: 打开支付页面 */ },
      onCheckPaymentStatus: _checkPaymentStatus,
      onCancelOrder: () async { /* TODO: 取消订单 */ },
      onRetryPayment: () async { /* TODO: 重新支付 */ },
      onBackToHome: () => Navigator.pushNamedAndRemoveUntil(context, '/xboard_home', (route) => false),
      onViewOrderDetails: () { /* TODO: 查看订单详情 */ },
      onCopyPaymentUrl: () { /* TODO: 复制支付链接 */ },
    );
    
    return UIRegistry().buildPage<PaymentGatewayPageContract>(data: data, callbacks: callbacks);
  }
}

