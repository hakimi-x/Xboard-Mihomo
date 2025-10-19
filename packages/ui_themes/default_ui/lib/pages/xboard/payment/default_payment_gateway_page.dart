// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 支付网关页面
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class DefaultPaymentGatewayPage extends PaymentGatewayPageContract {
  const DefaultPaymentGatewayPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('支付'),
        automaticallyImplyLeading: !data.isCompleted,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                // 状态图标
                _buildStatusIcon(context),
                const SizedBox(height: 24),
                
                // 订单信息
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('订单信息', style: Theme.of(context).textTheme.titleMedium),
                        const Divider(),
                        _buildInfoRow('订单号', data.orderInfo.orderId),
                        _buildInfoRow('套餐', data.orderInfo.planName),
                        _buildInfoRow('周期', data.orderInfo.period),
                        _buildInfoRow('金额', data.formattedAmount),
                        if (data.countdown > 0)
                          _buildInfoRow('剩余时间', data.formattedCountdown),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // 根据状态显示不同内容
                if (data.paymentStatus == PaymentStatus.pending || data.paymentStatus == PaymentStatus.processing)
                  _buildPendingView(context)
                else if (data.paymentStatus == PaymentStatus.success)
                  _buildSuccessView(context)
                else if (data.canRetry)
                  _buildRetryView(context)
                else
                  _buildFailedView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(BuildContext context) {
    IconData icon;
    Color color;
    String text;
    
    switch (data.paymentStatus) {
      case PaymentStatus.success:
        icon = Icons.check_circle;
        color = Colors.green;
        text = '支付成功';
        break;
      case PaymentStatus.failed:
        icon = Icons.cancel;
        color = Colors.red;
        text = '支付失败';
        break;
      case PaymentStatus.cancelled:
        icon = Icons.block;
        color = Colors.orange;
        text = '已取消';
        break;
      case PaymentStatus.timeout:
        icon = Icons.access_time;
        color = Colors.grey;
        text = '支付超时';
        break;
      default:
        icon = Icons.payment;
        color = Theme.of(context).colorScheme.primary;
        text = '等待支付';
    }
    
    return Column(
      children: [
        Icon(icon, size: 80, color: color),
        const SizedBox(height: 16),
        Text(text, style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPendingView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (data.paymentUrl != null) ...[
          FilledButton(
            onPressed: callbacks.onOpenPaymentPage,
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('打开支付页面'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: callbacks.onCopyPaymentUrl,
            icon: const Icon(Icons.copy),
            label: const Text('复制支付链接'),
          ),
        ],
        const SizedBox(height: 12),
        FilledButton.tonal(
          onPressed: data.isCheckingStatus ? null : callbacks.onCheckPaymentStatus,
          child: data.isCheckingStatus
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('检查支付状态'),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: callbacks.onCancelOrder,
          child: const Text('取消订单'),
        ),
      ],
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          data.successMessage ?? '订单支付成功，感谢您的购买！',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: callbacks.onBackToHome,
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('返回首页'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: callbacks.onViewOrderDetails,
          child: const Text('查看订单详情'),
        ),
      ],
    );
  }

  Widget _buildRetryView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          data.errorMessage ?? '支付失败，请重试',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: callbacks.onRetryPayment,
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('重新支付'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: callbacks.onBackToHome,
          child: const Text('返回首页'),
        ),
      ],
    );
  }

  Widget _buildFailedView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          data.errorMessage ?? '支付已取消',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: callbacks.onBackToHome,
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('返回首页'),
        ),
      ],
    );
  }
}

