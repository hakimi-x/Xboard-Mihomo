// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 套餐购买页面
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class DefaultPlanPurchasePage extends PlanPurchasePageContract {
  const DefaultPlanPurchasePage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('购买套餐')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 套餐列表
                Text('选择套餐', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                ...data.plans.map((plan) => _buildPlanCard(context, plan)),
                
                // 周期选择
                if (data.selectedPlan != null) ...[
                  const SizedBox(height: 24),
                  Text('选择周期', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: PlanPeriod.values.map((period) {
                      final isSelected = data.selectedPeriod == period;
                      return ChoiceChip(
                        label: Text('${data.selectedPlan!.getPeriodLabel(period)} - ¥${data.selectedPlan!.getPriceForPeriod(period) / 100}'),
                        selected: isSelected,
                        onSelected: (_) => callbacks.onSelectPeriod(period),
                      );
                    }).toList(),
                  ),
                ],
                
                // 支付方式
                if (data.selectedPlan != null) ...[
                  const SizedBox(height: 24),
                  Text('支付方式', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  ...data.paymentMethods.map((method) => RadioListTile<PaymentMethod>(
                    value: method,
                    groupValue: data.selectedPaymentMethod,
                    onChanged: method.isEnabled ? (v) => callbacks.onSelectPaymentMethod(v!) : null,
                    title: Text(method.name),
                    secondary: const Icon(Icons.payment),
                  )),
                ],
                
                // 优惠码
                if (data.selectedPlan != null) ...[
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: '优惠码',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton.tonal(
                        onPressed: () {/* Apply coupon */},
                        child: const Text('使用'),
                      ),
                    ],
                  ),
                  if (data.appliedCoupon != null) ...[
                    const SizedBox(height: 8),
                    Chip(
                      label: Text('已使用：${data.appliedCoupon!.description}'),
                      onDeleted: callbacks.onRemoveCoupon,
                    ),
                  ],
                ],
              ],
            ),
          ),
          
          // 底部结算
          if (data.selectedPlan != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('总计'),
                      Text('¥${data.totalPrice / 100}', style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: data.canSubmit ? callbacks.onConfirmPurchase : null,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: data.isLoading
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('确认购买'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, PlanInfo plan) {
    final isSelected = data.selectedPlan?.id == plan.id;
    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: () => callbacks.onSelectPlan(plan),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(plan.name, style: Theme.of(context).textTheme.titleMedium)),
                  if (plan.isRecommended) const Chip(label: Text('推荐')),
                  if (plan.isPopular) const Chip(label: Text('热门')),
                ],
              ),
              const SizedBox(height: 8),
              Text(plan.description, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.data_usage, size: 16),
                      const SizedBox(width: 4),
                      Text('${plan.trafficLimit}GB', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.devices, size: 16),
                      const SizedBox(width: 4),
                      Text('${plan.deviceLimit}台设备', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              if (plan.features.isNotEmpty) ...[
                const SizedBox(height: 12),
                ...plan.features.take(3).map((f) => Row(
                  children: [
                    const Icon(Icons.check, size: 16, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(f, style: const TextStyle(fontSize: 12)),
                  ],
                )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

