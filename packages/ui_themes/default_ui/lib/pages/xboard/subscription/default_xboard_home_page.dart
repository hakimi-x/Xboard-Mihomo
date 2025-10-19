// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI XBoard首页
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class DefaultXBoardHomePage extends XBoardHomePageContract {
  const DefaultXBoardHomePage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XBoard'),
        actions: [
          IconButton(icon: const Icon(Icons.support_agent), onPressed: callbacks.onOnlineSupport),
          IconButton(icon: const Icon(Icons.person), onPressed: callbacks.onProfile),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: callbacks.onRefresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 用户信息卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: data.userInfo.avatar != null ? NetworkImage(data.userInfo.avatar!) : null,
                      child: data.userInfo.avatar == null ? const Icon(Icons.person, size: 32) : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.userInfo.username, style: Theme.of(context).textTheme.titleLarge),
                          Text(data.userInfo.email, style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 订阅状态卡片
            Card(
              color: data.subscriptionStatus.isActive ? Theme.of(context).colorScheme.primaryContainer : null,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('套餐状态', style: Theme.of(context).textTheme.titleMedium),
                        Chip(
                          label: Text(data.subscriptionStatus.isActive ? '已激活' : '未激活'),
                          backgroundColor: data.subscriptionStatus.isActive ? Colors.green : Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('套餐名称：${data.subscriptionStatus.planName}'),
                    Text('到期时间：${data.subscriptionStatus.formattedExpireDate}'),
                    if (!data.subscriptionStatus.isExpired)
                      Text('剩余天数：${data.subscriptionStatus.remainingDays}天'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: callbacks.onManageSubscription,
                            child: const Text('订阅管理'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: callbacks.onPurchasePlan,
                            child: const Text('购买套餐'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 流量统计卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('流量统计', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: data.trafficStats.usagePercentage / 100,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${data.trafficStats.usagePercentage.toStringAsFixed(1)}% 已使用'),
                        Text(data.trafficStats.formatBytes(data.trafficStats.totalTraffic - data.trafficStats.usedTraffic)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Icon(Icons.upload, color: Colors.green),
                              Text(data.trafficStats.formatBytes(data.trafficStats.uploadTraffic)),
                              const Text('上传', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Icon(Icons.download, color: Colors.blue),
                              Text(data.trafficStats.formatBytes(data.trafficStats.downloadTraffic)),
                              const Text('下载', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 快速操作
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.card_giftcard),
                    title: const Text('邀请好友'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: callbacks.onInvite,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.support_agent),
                    title: const Text('在线客服'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: callbacks.onOnlineSupport,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('退出登录'),
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('确认退出'),
                          content: const Text('确定要退出登录吗？'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
                            TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('确定')),
                          ],
                        ),
                      );
                      if (confirm == true) callbacks.onLogout();
                    },
                  ),
                ],
              ),
            ),
            
            // 公告列表
            if (data.notices.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('公告', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...data.notices.take(5).map((notice) => Card(
                child: ListTile(
                  title: Text(notice.title),
                  subtitle: Text(notice.createdAt.toString().substring(0, 10)),
                  trailing: notice.isRead ? null : const Badge(),
                  onTap: () => callbacks.onViewNotice(notice),
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }
}

