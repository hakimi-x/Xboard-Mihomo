// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 支付网关页面
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class ModernPaymentGatewayPage extends PaymentGatewayPageContract {
  const ModernPaymentGatewayPage({super.key, required super.data, required super.callbacks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, title: const Text('支付')),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).colorScheme.primary.withOpacity(0.1), Theme.of(context).colorScheme.tertiary.withOpacity(0.1)])),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    constraints: const BoxConstraints(maxWidth: 400),
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(32)),
                    child: Column(
                      children: [
                        _buildStatusIcon(context),
                        const SizedBox(height: 24),
                        Text(data.formattedAmount, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('订单号：${data.orderInfo.orderId}', style: Theme.of(context).textTheme.bodySmall),
                        if (data.countdown > 0) Text('剩余：${data.formattedCountdown}', style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 32),
                        if (data.paymentStatus == PaymentStatus.success)
                          Container(
                            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green, Colors.lightGreen]), borderRadius: BorderRadius.circular(20)),
                            child: ElevatedButton(onPressed: callbacks.onBackToHome, style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, minimumSize: const Size(double.infinity, 64), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text('返回首页', style: TextStyle(fontSize: 18, color: Colors.white))),
                          )
                        else if (data.paymentStatus == PaymentStatus.pending)
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(gradient: LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]), borderRadius: BorderRadius.circular(20)),
                                child: ElevatedButton(onPressed: callbacks.onOpenPaymentPage, style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, minimumSize: const Size(double.infinity, 64), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text('打开支付页面', style: TextStyle(fontSize: 18, color: Colors.white))),
                              ),
                              const SizedBox(height: 12),
                              OutlinedButton(onPressed: callbacks.onCheckPaymentStatus, style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text('检查支付状态')),
                            ],
                          )
                        else if (data.canRetry)
                          Container(
                            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange, Colors.deepOrange]), borderRadius: BorderRadius.circular(20)),
                            child: ElevatedButton(onPressed: callbacks.onRetryPayment, style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, minimumSize: const Size(double.infinity, 64), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text('重新支付', style: TextStyle(fontSize: 18, color: Colors.white))),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(BuildContext context) {
    IconData icon;
    Color color;
    switch (data.paymentStatus) {
      case PaymentStatus.success: icon = Icons.check_circle; color = Colors.green; break;
      case PaymentStatus.failed: icon = Icons.cancel; color = Colors.red; break;
      default: icon = Icons.payment; color = Theme.of(context).colorScheme.primary;
    }
    return Icon(icon, size: 80, color: color);
  }
}

