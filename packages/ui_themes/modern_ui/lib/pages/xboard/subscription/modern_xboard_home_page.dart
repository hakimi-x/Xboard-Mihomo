// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI XBoard首页
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class ModernXBoardHomePage extends XBoardHomePageContract {
  const ModernXBoardHomePage({super.key, required super.data, required super.callbacks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Theme.of(context).colorScheme.primary.withOpacity(0.1), Theme.of(context).colorScheme.tertiary.withOpacity(0.1)],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(data.userInfo.username),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(icon: const Icon(Icons.support_agent), onPressed: callbacks.onOnlineSupport),
                IconButton(icon: const Icon(Icons.person), onPressed: callbacks.onProfile),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildGlassCard(
                    context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('套餐状态', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                gradient: data.subscriptionStatus.isActive ? const LinearGradient(colors: [Colors.green, Colors.lightGreen]) : null,
                                color: data.subscriptionStatus.isActive ? null : Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(data.subscriptionStatus.isActive ? '已激活' : '未激活', style: const TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text('${data.subscriptionStatus.planName} · 剩余${data.subscriptionStatus.remainingDays}天', style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: ElevatedButton(onPressed: callbacks.onManageSubscription, style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text('订阅管理'))),
                            const SizedBox(width: 8),
                            Expanded(child: OutlinedButton(onPressed: callbacks.onPurchasePlan, style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text('购买套餐'))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildGlassCard(
                    context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('流量统计', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(value: data.trafficStats.usagePercentage / 100, minHeight: 12),
                        ),
                        const SizedBox(height: 8),
                        Text('${data.trafficStats.usagePercentage.toStringAsFixed(1)}% 已使用 · 剩余 ${data.trafficStats.formatBytes(data.trafficStats.totalTraffic - data.trafficStats.usedTraffic)}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildGlassCard(
                    context,
                    child: Column(
                      children: [
                        ListTile(leading: const Icon(Icons.card_giftcard), title: const Text('邀请好友'), trailing: const Icon(Icons.chevron_right), onTap: callbacks.onInvite),
                        const Divider(),
                        ListTile(leading: const Icon(Icons.support_agent), title: const Text('在线客服'), trailing: const Icon(Icons.chevron_right), onTap: callbacks.onOnlineSupport),
                        const Divider(),
                        ListTile(leading: const Icon(Icons.logout), title: const Text('退出登录'), onTap: callbacks.onLogout),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCard(BuildContext context, {required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }
}

