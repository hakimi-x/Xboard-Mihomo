import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_clash/l10n/l10n.dart';
import '../models/payment_step.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
import 'package:fl_clash/xboard/core/core.dart';
class PaymentWaitingOverlay extends StatefulWidget {
  final VoidCallback? onClose;
  final VoidCallback? onPaymentSuccess;
  final String? tradeNo;
  final String? paymentUrl;
  const PaymentWaitingOverlay({
    super.key,
    this.onClose,
    this.onPaymentSuccess,
    this.tradeNo,
    this.paymentUrl,
  });
  @override
  State<PaymentWaitingOverlay> createState() => _PaymentWaitingOverlayState();
}
class _PaymentWaitingOverlayState extends State<PaymentWaitingOverlay>
    with TickerProviderStateMixin {
  PaymentStep _currentStep = PaymentStep.cancelingOrders;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Timer? _paymentCheckTimer;
  String? _currentTradeNo;
  @override
  void initState() {
    super.initState();
    _currentTradeNo = widget.tradeNo;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
    _pulseController.repeat(reverse: true);
  }
  @override
  void dispose() {
    _paymentCheckTimer?.cancel();
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }
  void updateStep(PaymentStep step) {
    if (mounted) {
      setState(() {
        _currentStep = step;
      });
      if (step == PaymentStep.waitingPayment && _currentTradeNo != null) {
        _startPaymentStatusCheck();
      }
    }
  }
  void updateTradeNo(String tradeNo) {
    if (mounted) {
      setState(() {
        _currentTradeNo = tradeNo;
      });
    }
  }
  void updatePaymentUrl(String paymentUrl) {
    if (mounted) {
      setState(() {
      });
    }
  }
  void _startPaymentStatusCheck() {
    XBoardLogger.debug('[PaymentWaiting] 开始定时检测支付状态，订单号: $_currentTradeNo');
    _paymentCheckTimer?.cancel();
    _paymentCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (!mounted || _currentTradeNo == null) {
        timer.cancel();
        return;
      }
      try {
        XBoardLogger.debug('[PaymentWaiting] ===== 开始检测支付状态 =====');
        XBoardLogger.debug('[PaymentWaiting] 订单号: $_currentTradeNo');
        
        // 使用域名服务检查订单状态
        XBoardLogger.debug('[PaymentWaiting] 准备调用 XBoardSDK.getOrderByTradeNo');
        final orderData = await XBoardSDK.getOrderByTradeNo(_currentTradeNo!);
        XBoardLogger.debug('[PaymentWaiting] API 调用完成，结果: ${orderData != null ? '有数据' : '无数据'}');
        
        if (orderData != null) {
          XBoardLogger.debug('[PaymentWaiting] 订单详情 - 订单号: ${orderData.tradeNo}, 状态: ${orderData.status}');
          // 检查订单状态
          // 状态值: 0-等待中, 3-已完成, 其他-失败
          if (orderData.status == 3) {
            // 支付成功，立即执行成功回调
            XBoardLogger.debug('[PaymentWaiting] ===== 检测到支付成功！状态: ${orderData.status} =====');
            XBoardLogger.debug('[PaymentWaiting] 停止定时器');
            timer.cancel();
            if (mounted) {
              XBoardLogger.debug('[PaymentWaiting] 组件仍然挂载，开始更新UI状态');
              setState(() {
                _currentStep = PaymentStep.paymentSuccess;
              });
              XBoardLogger.debug('[PaymentWaiting] UI状态已更新为: $_currentStep');
              _pulseController.stop();
              XBoardLogger.debug('[PaymentWaiting] 脉动动画已停止');
              
              // 立即执行成功回调，不等待3秒
              if (widget.onPaymentSuccess != null) {
                XBoardLogger.debug('[PaymentWaiting] 准备调用 onPaymentSuccess 回调');
                widget.onPaymentSuccess?.call();
                XBoardLogger.debug('[PaymentWaiting] onPaymentSuccess 回调已调用');
              } else {
                XBoardLogger.debug('[PaymentWaiting] 警告：onPaymentSuccess 回调为 null');
              }
            } else {
              XBoardLogger.debug('[PaymentWaiting] 警告：组件已卸载，无法执行成功回调');
            }
          } else if (orderData.status == 0) {
            // 仍在等待支付
            XBoardLogger.debug('[PaymentWaiting] 支付仍在等待中...');
          } else {
            // 其他状态视为失败
            XBoardLogger.debug('[PaymentWaiting] 支付失败，状态: ${orderData.status}');
            timer.cancel();
            if (mounted) {
              widget.onClose?.call();
            }
          }
        } else {
          XBoardLogger.debug('[PaymentWaiting] 获取订单状态失败：订单不存在');
        }
      } catch (e) {
        XBoardLogger.debug('[PaymentWaiting] 检测支付状态异常: $e');
      }
    });
  }
  String _getStepTitle(PaymentStep step) {
    switch (step) {
      case PaymentStep.cancelingOrders:
        return '清理旧订单';
      case PaymentStep.createOrder:
        return AppLocalizations.of(context).xboardCreatingOrder;
      case PaymentStep.loadingPayment:
        return AppLocalizations.of(context).xboardLoadingPaymentPage;
      case PaymentStep.verifyPayment:
        return AppLocalizations.of(context).xboardPaymentMethodVerified;
      case PaymentStep.waitingPayment:
        return AppLocalizations.of(context).xboardWaitingPaymentCompletion;
      case PaymentStep.paymentSuccess:
        return AppLocalizations.of(context).xboardPaymentSuccess;
    }
  }
  String _getStepDescription(PaymentStep step) {
    switch (step) {
      case PaymentStep.cancelingOrders:
        return '正在清理之前的待支付订单...';
      case PaymentStep.createOrder:
        return AppLocalizations.of(context).xboardCreatingOrderPleaseWait;
      case PaymentStep.loadingPayment:
        return AppLocalizations.of(context).xboardPreparingPaymentPage;
      case PaymentStep.verifyPayment:
        return AppLocalizations.of(context).xboardPaymentMethodVerifiedPreparing;
      case PaymentStep.waitingPayment:
        return '支付页面已打开，支付链接已复制到剪贴板。如果没有自动跳转，请手动粘贴到浏览器打开。';
      case PaymentStep.paymentSuccess:
        return AppLocalizations.of(context).xboardCongratulationsSubscriptionActivated;
    }
  }
  Color _getStepColor(PaymentStep step) {
    switch (step) {
      case PaymentStep.cancelingOrders:
        return Colors.grey;
      case PaymentStep.createOrder:
        return Colors.orange;
      case PaymentStep.loadingPayment:
        return Colors.blue;
      case PaymentStep.verifyPayment:
        return Colors.green;
      case PaymentStep.waitingPayment:
        return Colors.purple;
      case PaymentStep.paymentSuccess:
        return Colors.green;
    }
  }
  IconData _getStepIcon(PaymentStep step) {
    switch (step) {
      case PaymentStep.cancelingOrders:
        return Icons.clear_all;
      case PaymentStep.createOrder:
        return Icons.receipt_long;
      case PaymentStep.loadingPayment:
        return Icons.payment;
      case PaymentStep.verifyPayment:
        return Icons.verified_user;
      case PaymentStep.waitingPayment:
        return Icons.access_time;
      case PaymentStep.paymentSuccess:
        return Icons.check_circle;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.all(24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: _getStepColor(_currentStep).withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _getStepColor(_currentStep),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          _getStepIcon(_currentStep),
                          size: 40,
                          color: _getStepColor(_currentStep),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  _getStepTitle(_currentStep),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  _getStepDescription(_currentStep),
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (_currentStep == PaymentStep.paymentSuccess)
                  Icon(
                    Icons.check_circle,
                    size: 48,
                    color: Colors.green,
                  )
                else
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getStepColor(_currentStep),
                      ),
                    ),
                  ),
              ],
            ),
            actions: () {
              if (_currentStep == PaymentStep.paymentSuccess && widget.onPaymentSuccess != null) {
                return [
                  ElevatedButton(
                    onPressed: widget.onPaymentSuccess,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(AppLocalizations.of(context).xboardConfirm),
                  ),
                ];
              } else if (_currentStep == PaymentStep.waitingPayment && widget.onClose != null) {
                return [
                  TextButton(
                    onPressed: widget.onClose,
                    child: Text(AppLocalizations.of(context).xboardHandleLater),
                  ),
                ];
              }
              return null;
            }(),
          ),
        ),
      ),
    );
  }
}
class PaymentWaitingManager {
  static OverlayEntry? _overlayEntry;
  static GlobalKey<_PaymentWaitingOverlayState>? _overlayKey;
  static VoidCallback? _onClose;
  static VoidCallback? _onPaymentSuccess;
  static void show(
    BuildContext context, {
    VoidCallback? onClose,
    VoidCallback? onPaymentSuccess,
    String? tradeNo,
  }) {
    XBoardLogger.debug('[PaymentWaitingManager.show] 准备显示支付等待弹窗');
    XBoardLogger.debug('[PaymentWaitingManager.show] onClose 是否为 null: ${onClose == null}');
    XBoardLogger.debug('[PaymentWaitingManager.show] onPaymentSuccess 是否为 null: ${onPaymentSuccess == null}');
    hide(); // 确保之前的overlay被清除
    _onClose = onClose;
    _onPaymentSuccess = onPaymentSuccess;
    XBoardLogger.debug('[PaymentWaitingManager.show] 静态变量已设置，_onPaymentSuccess 是否为 null: ${_onPaymentSuccess == null}');
    _overlayKey = GlobalKey<_PaymentWaitingOverlayState>();
    _overlayEntry = OverlayEntry(
      builder: (context) => PaymentWaitingOverlay(
        key: _overlayKey,
        onClose: () {
          hide();
          _onClose?.call();
        },
        onPaymentSuccess: () {
          XBoardLogger.debug('[PaymentWaitingManager] 收到支付成功通知，准备处理');
          // 先保存回调，再隐藏弹窗（因为hide()会清空回调）
          final callback = _onPaymentSuccess;
          XBoardLogger.debug('[PaymentWaitingManager] 保存的回调是否为 null: ${callback == null}');
          hide();
          XBoardLogger.debug('[PaymentWaitingManager] 弹窗已隐藏，准备调用外部回调');
          if (callback != null) {
            XBoardLogger.debug('[PaymentWaitingManager] 外部回调存在，开始调用');
            callback.call();
            XBoardLogger.debug('[PaymentWaitingManager] 外部回调调用完成');
          } else {
            XBoardLogger.debug('[PaymentWaitingManager] 警告：外部回调为 null');
          }
        },
        tradeNo: tradeNo,
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }
  static void updateStep(PaymentStep step) {
    _overlayKey?.currentState?.updateStep(step);
  }
  static void updateTradeNo(String tradeNo) {
    _overlayKey?.currentState?.updateTradeNo(tradeNo);
  }
  static void updatePaymentUrl(String paymentUrl) {
    _overlayKey?.currentState?.updatePaymentUrl(paymentUrl);
  }
  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _overlayKey = null;
    _onClose = null;
    _onPaymentSuccess = null;
  }
}