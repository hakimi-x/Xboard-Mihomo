// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 套餐购买页面
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class ModernPlanPurchasePage extends PlanPurchasePageContract {
  const ModernPlanPurchasePage({super.key, required super.data, required super.callbacks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, title: const Text('购买套餐')),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).colorScheme.primary.withOpacity(0.1), Theme.of(context).colorScheme.tertiary.withOpacity(0.1)])),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
                children: [
                  Text('选择套餐', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ...data.plans.map((plan) {
                    final isSelected = data.selectedPlan?.id == plan.id;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: InkWell(
                            onTap: () => callbacks.onSelectPlan(plan),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: isSelected ? LinearGradient(colors: [Theme.of(context).colorScheme.primary.withOpacity(0.3), Theme.of(context).colorScheme.secondary.withOpacity(0.3)]) : null,
                                color: isSelected ? null : Theme.of(context).colorScheme.surface.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white.withOpacity(0.2), width: 2),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text(plan.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
                                      if (plan.isRecommended) const Chip(label: Text('推荐'), backgroundColor: Colors.orange),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(plan.description),
                                  const SizedBox(height: 8),
                                  Text('${plan.trafficLimit}GB流量 · ${plan.deviceLimit}台设备', style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  if (data.selectedPlan != null) ...[
                    const SizedBox(height: 16),
                    Text('选择周期', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Wrap(spacing: 8, runSpacing: 8, children: PlanPeriod.values.map((period) => ChoiceChip(label: Text('${data.selectedPlan!.getPeriodLabel(period)} ¥${data.selectedPlan!.getPriceForPeriod(period) / 100}'), selected: data.selectedPeriod == period, onSelected: (_) => callbacks.onSelectPeriod(period))).toList()),
                  ],
                ],
              ),
            ),
            if (data.selectedPlan != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                      border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outline.withOpacity(0.2))),
                    ),
                    child: Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('总计', style: TextStyle(fontSize: 18)), Text('¥${data.totalPrice / 100}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))]),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(gradient: LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]), borderRadius: BorderRadius.circular(20)),
                          child: ElevatedButton(
                            onPressed: data.canSubmit ? callbacks.onConfirmPurchase : null,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, minimumSize: const Size(double.infinity, 64), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            child: const Text('确认购买', style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

