// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 邀请页面
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class DefaultInvitePage extends InvitePageContract {
  const DefaultInvitePage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('邀请好友'),
        actions: [
          IconButton(icon: const Icon(Icons.help_outline), onPressed: callbacks.onViewInviteRules),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: callbacks.onRefresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 佣金统计卡片
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('可用佣金', style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(
                      data.commissionStats.formatAmount(data.commissionStats.availableCommission),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(context, '总佣金', data.commissionStats.formatAmount(data.commissionStats.totalCommission)),
                        _buildStatItem(context, '待确认', data.commissionStats.formatAmount(data.commissionStats.pendingCommission)),
                        _buildStatItem(context, '已提现', data.commissionStats.formatAmount(data.commissionStats.withdrawnCommission)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: callbacks.onWithdraw,
                      style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                      child: const Text('申请提现'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 邀请统计
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(context, '总邀请', '${data.commissionStats.totalInvites}人'),
                    _buildStatItem(context, '有效邀请', '${data.commissionStats.activeInvites}人'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 邀请方式
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('邀请方式', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    TextField(
                      readOnly: true,
                      controller: TextEditingController(text: data.inviteCode),
                      decoration: InputDecoration(
                        labelText: '邀请码',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: callbacks.onCopyInviteCode,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      readOnly: true,
                      controller: TextEditingController(text: data.inviteUrl),
                      decoration: InputDecoration(
                        labelText: '邀请链接',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: callbacks.onCopyInviteUrl,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: callbacks.onGenerateQrCode,
                            icon: const Icon(Icons.qr_code),
                            label: const Text('生成二维码'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: callbacks.onShareInvite,
                            icon: const Icon(Icons.share),
                            label: const Text('分享'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 邀请历史
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('邀请历史', style: Theme.of(context).textTheme.titleMedium),
                TextButton(
                  onPressed: callbacks.onViewCommissionHistory,
                  child: const Text('佣金记录'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (data.inviteRecords.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(child: Text('暂无邀请记录', style: Theme.of(context).textTheme.bodyLarge)),
                ),
              )
            else
              ...data.inviteRecords.take(10).map((record) => Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text(record.username[0].toUpperCase())),
                  title: Text(record.username),
                  subtitle: Text('加入时间：${record.inviteDate.toString().substring(0, 10)}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        data.commissionStats.formatAmount(record.earnedCommission),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Chip(
                        label: Text(record.isActive ? '活跃' : '未活跃', style: const TextStyle(fontSize: 10)),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ),
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

