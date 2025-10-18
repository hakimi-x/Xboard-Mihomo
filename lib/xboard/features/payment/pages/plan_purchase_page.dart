import 'package:fl_clash/widgets/widgets.dart';

import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
import 'package:fl_clash/xboard/core/core.dart';
import 'package:fl_clash/xboard/features/auth/providers/xboard_user_provider.dart';
import 'package:fl_clash/xboard/features/payment/providers/xboard_payment_provider.dart';

import '../widgets/payment_waiting_overlay.dart';
import '../models/payment_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_clash/l10n/l10n.dart';
class PlanPurchasePage extends ConsumerStatefulWidget {
  final PlanData plan;
  const PlanPurchasePage({
    super.key,
    required this.plan,
  });
  @override
  ConsumerState<PlanPurchasePage> createState() => _PlanPurchasePageState();
}
class _PlanPurchasePageState extends ConsumerState<PlanPurchasePage> {
  String? _selectedPeriod;
  String? _couponCode;
  final _couponController = TextEditingController();
  bool _isCouponValidating = false;
  bool? _isCouponValid;
  String? _couponErrorMessage;
  double? _discountAmount;
  double? _finalPrice;
  double? _userBalance;
  bool _isLoadingBalance = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final periods = _getAvailablePeriods(context);
      if (periods.isNotEmpty && _selectedPeriod == null) {  
        setState(() {
          _selectedPeriod = periods.first['period'];
        });
      }
      _loadUserBalance();
    });
  }
  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }
  String _formatTraffic(double transferEnable) {
    if (transferEnable >= 1024) {
      return '${(transferEnable / 1024).toStringAsFixed(1)}TB';
    }
    return '${transferEnable.toStringAsFixed(0)}GB';
  }
  String _formatPrice(double? price) {
    if (price == null) return '-';
    return '¥${price.toStringAsFixed(2)}';
  }
  Future<void> _loadUserBalance() async {
    setState(() {
      _isLoadingBalance = true;
    });
    try {
      final userInfo = await XBoardSDK.getUserInfo();
      setState(() {
        _userBalance = userInfo?.balanceInYuan;
      });
    } catch (e) {
      setState(() {
        _userBalance = null;
      });
    } finally {
      setState(() {
        _isLoadingBalance = false;
      });
    }
  }
  List<Map<String, dynamic>> _getAvailablePeriods(BuildContext context) {
    final List<Map<String, dynamic>> periods = [];
    if (widget.plan.monthPrice != null) {
      periods.add({
        'period': 'month_price',
        'label': AppLocalizations.of(context).xboardMonthlyPayment,
        'price': widget.plan.monthPrice!,
        'description': AppLocalizations.of(context).xboardMonthlyRenewal,
      });
    }
    if (widget.plan.quarterPrice != null) {
      periods.add({
        'period': 'quarter_price',
        'label': AppLocalizations.of(context).xboardQuarterlyPayment,
        'price': widget.plan.quarterPrice!,
        'description': AppLocalizations.of(context).xboardThreeMonthCycle,
      });
    }
    if (widget.plan.halfYearPrice != null) {
      periods.add({
        'period': 'half_year_price',
        'label': AppLocalizations.of(context).xboardHalfYearlyPayment,
        'price': widget.plan.halfYearPrice!,
        'description': AppLocalizations.of(context).xboardSixMonthCycle,
      });
    }
    if (widget.plan.yearPrice != null) {
      periods.add({
        'period': 'year_price',
        'label': AppLocalizations.of(context).xboardYearlyPayment,
        'price': widget.plan.yearPrice!,
        'description': AppLocalizations.of(context).xboardTwelveMonthCycle,
      });
    }
    if (widget.plan.twoYearPrice != null) {
      periods.add({
        'period': 'two_year_price',
        'label': AppLocalizations.of(context).xboardTwoYearPayment,
        'price': widget.plan.twoYearPrice!,
        'description': AppLocalizations.of(context).xboardTwentyFourMonthCycle,
      });
    }
    if (widget.plan.threeYearPrice != null) {
      periods.add({
        'period': 'three_year_price',
        'label': AppLocalizations.of(context).xboardThreeYearPayment,
        'price': widget.plan.threeYearPrice!,
        'description': AppLocalizations.of(context).xboardThirtySixMonthCycle,
      });
    }
    if (widget.plan.onetimePrice != null) {
      periods.add({
        'period': 'onetime_price',
        'label': AppLocalizations.of(context).xboardOneTimePayment,
        'price': widget.plan.onetimePrice!,
        'description': AppLocalizations.of(context).xboardBuyoutPlan,
      });
    }
    return periods;
  }
  Future<void> _proceedToPurchase() async {
    if (_selectedPeriod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).xboardPleaseSelectPaymentPeriod)),
      );
      return;
    }
    try {
      String? tradeNo;
      XBoardLogger.debug('[FlClash] [确认购买] 开始购买流程，套餐ID: ${widget.plan.id}, 周期: $_selectedPeriod');
      if (mounted) {
        XBoardLogger.debug('[FlClash] [确认购买] 立即显示支付等待页面');
        PaymentWaitingManager.show(
          context,
          onClose: () {
            Navigator.of(context).pop();
          },
          onPaymentSuccess: () {
            XBoardLogger.debug('[支付成功] ===== 收到支付成功回调 =====');
            XBoardLogger.debug('[支付成功] 当前页面是否已挂载: $mounted');
            XBoardLogger.debug('[支付成功] 开始刷新订阅信息');
            
            try {
              final userProvider = ref.read(xboardUserProvider.notifier);
              XBoardLogger.debug('[支付成功] 获取到 xboardUserProvider: $userProvider');
              userProvider.refreshSubscriptionInfoAfterPayment();
              XBoardLogger.debug('[支付成功] 订阅信息刷新请求已发送');
            } catch (e) {
              XBoardLogger.debug('[支付成功] 刷新订阅信息时出错: $e');
            }
            
            XBoardLogger.debug('[支付成功] 准备延迟300ms后导航');
            Future.delayed(const Duration(milliseconds: 300), () {
              XBoardLogger.debug('[支付成功] 延迟结束，检查页面挂载状态: $mounted');
              if (mounted) {
                XBoardLogger.debug('[支付成功] 开始导航回首页，当前路由栈深度: ${Navigator.of(context).canPop()}');
                try {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  XBoardLogger.debug('[支付成功] 导航完成，已返回首页');
                } catch (e) {
                  XBoardLogger.debug('[支付成功] 导航时出错: $e');
                }
              } else {
                XBoardLogger.debug('[支付成功] 页面已卸载，无法导航');
              }
            });
          },
          tradeNo: null, // 初始时还没有订单号
        );
        PaymentWaitingManager.updateStep(PaymentStep.cancelingOrders);
      }
      XBoardLogger.debug('[FlClash] [确认购买] 步骤1: 开始创建订单');
      PaymentWaitingManager.updateStep(PaymentStep.createOrder);
      XBoardLogger.debug('[FlClash] [确认购买] 调用 createOrder 接口');
      final paymentNotifier = ref.read(xboardPaymentProvider.notifier);
      tradeNo = await paymentNotifier.createOrder(
        planId: widget.plan.id,
        period: _selectedPeriod!,
        couponCode: _couponCode,
      );
      XBoardLogger.debug('[FlClash] [确认购买] createOrder 返回结果: $tradeNo');
      if (tradeNo == null) {
        final errorMessage = ref.read(userUIStateProvider).errorMessage;
        XBoardLogger.debug('[FlClash] [确认购买] 订单创建失败: $errorMessage');
        throw Exception('${AppLocalizations.of(context).xboardOrderCreationFailed}: ${errorMessage ?? AppLocalizations.of(context).xboardOperationFailed}');
      }
      XBoardLogger.debug('[FlClash] [确认购买] 订单创建成功，订单号: $tradeNo');
      PaymentWaitingManager.updateTradeNo(tradeNo);
      XBoardLogger.debug('[FlClash] [确认购买] 步骤2: 开始加载支付页面');
      PaymentWaitingManager.updateStep(PaymentStep.loadingPayment);
      XBoardLogger.debug('[FlClash] [确认购买] 获取支付方式列表');
      final paymentMethods = await XBoardSDK.getPaymentMethods();
      XBoardLogger.debug('[FlClash] 支付方式获取响应: 获取到 ${paymentMethods.length} 个支付方式');
      if (paymentMethods.isEmpty) {
        throw Exception('暂无可用的支付方式');
      }
      final firstPaymentMethod = paymentMethods.first;
      XBoardLogger.debug('[FlClash] 支付方式获取成功，数量: ${paymentMethods.length}');
      XBoardLogger.debug('[FlClash] 选择第一个支付方式: ID=${firstPaymentMethod.id}, Name=${firstPaymentMethod.name}');
      XBoardLogger.debug('[FlClash] [确认购买] 步骤3: 验证支付方式');
      PaymentWaitingManager.updateStep(PaymentStep.verifyPayment);
      XBoardLogger.debug('[FlClash] [确认购买] 检查订单状态...');
      try {
        final orderStatus = await XBoardSDK.getOrderByTradeNo(tradeNo);
        if (orderStatus != null) {
          XBoardLogger.debug('[FlClash] [确认购买] 订单状态检查: status=${orderStatus.status}, trade_no=${orderStatus.tradeNo}');
        } else {
          XBoardLogger.debug('[FlClash] [确认购买] 警告: 无法找到订单状态信息');
        }
      } catch (e) {
        XBoardLogger.debug('[FlClash] [确认购买] 订单状态检查失败: $e');
      }
      XBoardLogger.debug('[FlClash] [确认购买] 开始创建支付网关，订单号: $tradeNo, 支付方式: ${firstPaymentMethod.id}');
      XBoardLogger.debug('[FlClash] [确认购买] 使用 PaymentProvider 提交支付');
      XBoardLogger.debug('[FlClash] [确认购买] 支付方式ID类型: ${firstPaymentMethod.id.runtimeType}, 值: ${firstPaymentMethod.id}');
      final paymentUrl = await paymentNotifier.submitPayment(
        tradeNo: tradeNo,
        method: firstPaymentMethod.id.toString(),
      );
      XBoardLogger.debug('[FlClash] [确认购买] 支付提交完成，支付链接: $paymentUrl');
      if (mounted) {
        XBoardLogger.debug('[FlClash] [确认购买] 处理支付结果');
        if (paymentUrl != null && paymentUrl.isNotEmpty) {
          // 支付提交成功，打开支付链接
          PaymentWaitingManager.updateStep(PaymentStep.waitingPayment);
          XBoardLogger.debug('[FlClash] [确认购买] 支付链接获取成功，准备打开浏览器');
          
          // 打开支付链接
          await _launchPaymentUrl(paymentUrl, tradeNo);
          
          XBoardLogger.debug('[FlClash] [确认购买] 支付链接已打开，等待用户完成支付');
        } else {
          throw Exception('支付失败: 未获取到支付链接');
        }
      }
    } catch (e) {
      XBoardLogger.error('购买流程出错: $e');
      // Error handling for domain service exceptions
      XBoardLogger.error('支付错误详情: $e');
      if (mounted) {
        PaymentWaitingManager.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('操作失败: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  Future<void> _launchPaymentUrl(String url, String tradeNo) async {
    try {
      if (mounted) {
        await Clipboard.setData(ClipboardData(text: url));
        final uri = Uri.parse(url);
        if (!await canLaunchUrl(uri)) {
          throw Exception('无法打开支付链接');
        }
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (!launched) {
          throw Exception('无法启动外部浏览器');
        }
        XBoardLogger.debug('[FlClash] 支付页面已在浏览器中打开，订单号: $tradeNo');
        XBoardLogger.debug('[FlClash] 支付链接已复制到剪贴板');
      }
    } catch (e) {
      if (mounted) {
        PaymentWaitingManager.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('打开支付页面失败: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  Widget _buildPeriodSelector() {
    final periods = _getAvailablePeriods(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).xboardSelectPaymentPeriod,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...periods.map((period) {
              final isSelected = _selectedPeriod == period['period'];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedPeriod = period['period'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected ? Colors.blue.shade50 : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                          color: isSelected ? Colors.blue : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                period['label'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.blue.shade800 : null,
                                ),
                              ),
                              Text(
                                period['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (isSelected && _finalPrice != null) ...[
                              Text(
                                _formatPrice(period['price']),
                                style: TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red.shade400,
                                  decorationThickness: 2.0,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                _formatPrice(_finalPrice!),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ] else
                              Text(
                                _formatPrice(period['price']),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.blue.shade800 : Colors.green.shade700,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
  Future<void> _validateCoupon() async {
    if (_couponController.text.trim().isEmpty) {
      if (mounted) {
        setState(() {
          _isCouponValid = null;
          _couponErrorMessage = null;
          _discountAmount = null;
          _finalPrice = null;
          _couponCode = null;
        });
      }
      return;
    }
    if (mounted) {
      setState(() {
        _isCouponValidating = true;
        _isCouponValid = null;
        _couponErrorMessage = null;
      });
    }
    try {
      final couponCode = _couponController.text.trim();
      final isValid = await XBoardSDK.checkCoupon(
        code: couponCode,
        planId: widget.plan.id,
      );
      if (isValid) {
        // TODO: 需要从SDK获取完整的优惠券数据以计算折扣
        // 目前API只返回是否有效，无法计算具体折扣金额
        // 暂时只标记为有效，不计算折扣
        if (mounted) {
          setState(() {
            _isCouponValid = true;
            _couponCode = couponCode;
            // 无法计算折扣金额，暂时设为null
            _discountAmount = null;
            _finalPrice = null;
            _couponErrorMessage = null;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isCouponValid = false;
            _couponErrorMessage = AppLocalizations.of(context).xboardInvalidOrExpiredCoupon;
            _discountAmount = null;
            _finalPrice = null;
            _couponCode = null;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCouponValid = false;
          _couponErrorMessage = '${AppLocalizations.of(context).xboardValidationFailed}: ${e.toString()}';
          _discountAmount = null;
          _finalPrice = null;
          _couponCode = null;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCouponValidating = false;
        });
      }
    }
  }
  // ignore: unused_element
  double _getCurrentPrice() {
    if (_selectedPeriod == null) return 0.0;
    final periods = _getAvailablePeriods(context);
    final selectedPeriod = periods.firstWhere(
      (period) => period['period'] == _selectedPeriod,
      orElse: () => {},
    );
    return selectedPeriod['price']?.toDouble() ?? 0.0;
  }
  Widget _buildBalanceTip() {
    if (_isLoadingBalance || _userBalance == null) {
      return const SizedBox.shrink(); // 加载中或失败时不显示
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _userBalance! > 0 ? Colors.blue.shade50 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _userBalance! > 0 ? Colors.blue.shade200 : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.account_balance_wallet,
            color: _userBalance! > 0 ? Colors.blue.shade600 : Colors.grey.shade600,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            '${AppLocalizations.of(context).xboardAccountBalance}: ${_formatPrice(_userBalance!)}',
            style: TextStyle(
              fontSize: 14,
              color: _userBalance! > 0 ? Colors.blue.shade800 : Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCouponSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_offer, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context).xboardCouponOptional,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_isCouponValid == true) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green.shade700, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '-¥${_discountAmount?.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _isCouponValid == false 
                            ? Colors.red.shade300 
                            : _isCouponValid == true 
                                ? Colors.green.shade300 
                                : Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: TextField(
                      controller: _couponController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context).xboardEnterCouponCode,
                        prefixIcon: Icon(
                          Icons.local_offer,
                          color: _isCouponValid == false 
                              ? Colors.red.shade400 
                              : _isCouponValid == true 
                                  ? Colors.green.shade400 
                                  : Colors.grey.shade400,
                        ),
                        suffixIcon: _isCouponValid != null
                            ? Icon(
                                _isCouponValid! ? Icons.check_circle : Icons.cancel,
                                color: _isCouponValid! ? Colors.green : Colors.red,
                              )
                            : null,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      onChanged: (value) {
                        if (_isCouponValid != null) {
                          setState(() {
                            _isCouponValid = null;
                            _couponErrorMessage = null;
                            _discountAmount = null;
                            _finalPrice = null;
                            _couponCode = null;
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isCouponValidating ? null : _validateCoupon,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: _isCouponValidating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context).xboardVerify,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            if (_couponErrorMessage != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red.shade600, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _couponErrorMessage!,
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: AppLocalizations.of(context).xboardPurchaseSubscription,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.plan.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.data_usage, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          '${AppLocalizations.of(context).xboardTraffic}: ${_formatTraffic(widget.plan.transferEnable)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 24),
                        if ((widget.plan.speedLimit ?? 0) > 0) ...[
                          const Icon(Icons.speed, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            '${AppLocalizations.of(context).xboardSpeedLimit}: ${widget.plan.speedLimit}Mbps',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildPeriodSelector(),
            const SizedBox(height: 16),
            _buildCouponSection(),
            const SizedBox(height: 24),
            _buildBalanceTip(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: Consumer(
                builder: (context, ref, child) {
                  final paymentState = ref.watch(userUIStateProvider);
                  return ElevatedButton(
                    onPressed: paymentState.isLoading 
                        ? null 
                        : () => _proceedToPurchase(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: paymentState.isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(AppLocalizations.of(context).xboardProcessing),
                            ],
                          )
                        : Text(
                            AppLocalizations.of(context).xboardConfirmPurchase,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 