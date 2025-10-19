// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 订阅管理页面
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class ModernSubscriptionPage extends SubscriptionPageContract {
  const ModernSubscriptionPage({super.key, required super.data, required super.callbacks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('订阅管理'),
        actions: [IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: callbacks.onAddSubscription)],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).colorScheme.primary.withOpacity(0.1), Colors.transparent],
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: callbacks.onRefresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.subscriptions.length,
              itemBuilder: (context, i) {
                final sub = data.subscriptions[i];
                final isCurrent = sub.id == data.currentSubscription?.id;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: isCurrent ? LinearGradient(colors: [Theme.of(context).colorScheme.primary.withOpacity(0.3), Theme.of(context).colorScheme.secondary.withOpacity(0.3)]) : null,
                          color: isCurrent ? null : Theme.of(context).colorScheme.surface.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: isCurrent ? Theme.of(context).colorScheme.primary : Colors.white.withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(sub.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
                                if (isCurrent) Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                                  child: const Text('使用中', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(value: sub.usagePercentage / 100, minHeight: 8),
                            ),
                            const SizedBox(height: 8),
                            Text('${sub.formatBytes(sub.usedTraffic)} / ${sub.formatBytes(sub.totalTraffic)} · ${sub.nodeCount}节点', style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                if (!isCurrent) Expanded(child: ElevatedButton(onPressed: () => callbacks.onSwitchSubscription(sub), style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text('切换'))),
                                if (!isCurrent) const SizedBox(width: 8),
                                Expanded(child: OutlinedButton.icon(onPressed: () => callbacks.onUpdateSubscription(sub), icon: const Icon(Icons.refresh), label: const Text('更新'), style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))))),
                                IconButton(icon: const Icon(Icons.copy), onPressed: () => callbacks.onCopySubscriptionUrl(sub)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: callbacks.onAddSubscription,
        icon: const Icon(Icons.add),
        label: const Text('添加订阅'),
      ),
    );
  }
}

