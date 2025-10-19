// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 订阅管理页面
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class DefaultSubscriptionPage extends SubscriptionPageContract {
  const DefaultSubscriptionPage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('订阅管理'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: callbacks.onAddSubscription),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: callbacks.onRefresh,
        child: data.subscriptions.isEmpty
            ? Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inbox, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('暂无订阅'),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: callbacks.onAddSubscription,
                    icon: const Icon(Icons.add),
                    label: const Text('添加订阅'),
                  ),
                ],
              ))
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 当前订阅
                  if (data.currentSubscription != null) ...[
                    Text('当前订阅', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    _buildSubscriptionCard(context, data.currentSubscription!, true),
                    const SizedBox(height: 24),
                  ],
                  
                  // 其他订阅
                  if (data.subscriptions.where((s) => s.id != data.currentSubscription?.id).isNotEmpty) ...[
                    Text('其他订阅', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    ...data.subscriptions
                        .where((s) => s.id != data.currentSubscription?.id)
                        .map((sub) => _buildSubscriptionCard(context, sub, false)),
                  ],
                  
                  // 节点列表
                  if (data.nodes.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('节点列表 (${data.nodes.length})', style: Theme.of(context).textTheme.titleMedium),
                        TextButton.icon(
                          onPressed: callbacks.onTestLatency,
                          icon: const Icon(Icons.speed),
                          label: const Text('测速'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Card(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.nodes.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          final node = data.nodes[i];
                          return ListTile(
                            leading: Icon(
                              node.isOnline ? Icons.check_circle : Icons.cancel,
                              color: node.isOnline ? Colors.green : Colors.red,
                            ),
                            title: Text(node.name),
                            subtitle: Text('${node.type} · ${node.location}'),
                            trailing: node.latency != null ? Text('${node.latency}ms') : null,
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Widget _buildSubscriptionCard(BuildContext context, SubscriptionInfo sub, bool isCurrent) {
    final isUpdating = data.updatingSubscriptionId == sub.id;
    
    return Card(
      elevation: isCurrent ? 4 : 1,
      color: isCurrent ? Theme.of(context).colorScheme.primaryContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sub.name, style: Theme.of(context).textTheme.titleMedium),
                      if (isCurrent) const Text('当前使用', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                if (isCurrent) const Chip(label: Text('激活')),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: sub.usagePercentage / 100,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('已使用 ${sub.formatBytes(sub.usedTraffic)}'),
                Text('总计 ${sub.formatBytes(sub.totalTraffic)}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.dns, size: 16, color: Theme.of(context).textTheme.bodySmall?.color),
                const SizedBox(width: 4),
                Text('${sub.nodeCount} 节点', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(width: 16),
                if (sub.expireDate != null) ...[
                  Icon(Icons.calendar_today, size: 16, color: Theme.of(context).textTheme.bodySmall?.color),
                  const SizedBox(width: 4),
                  Text('到期 ${sub.expireDate!.toString().substring(0, 10)}', style: Theme.of(context).textTheme.bodySmall),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (!isCurrent)
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: () => callbacks.onSwitchSubscription(sub),
                      child: const Text('切换'),
                    ),
                  ),
                if (!isCurrent) const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isUpdating ? null : () => callbacks.onUpdateSubscription(sub),
                    icon: isUpdating ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.refresh),
                    label: const Text('更新'),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () => callbacks.onCopySubscriptionUrl(sub),
                  tooltip: '复制链接',
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('确认删除'),
                        content: Text('确定要删除订阅"${sub.name}"吗？'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
                          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('删除')),
                        ],
                      ),
                    );
                    if (confirm == true) callbacks.onDeleteSubscription(sub);
                  },
                  tooltip: '删除',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

