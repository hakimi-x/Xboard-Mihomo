/// 订阅管理页面控制器
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubscriptionPageController extends ConsumerWidget {
  const SubscriptionPageController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: 从Provider获取订阅数据
    final data = const SubscriptionPageData(
      subscriptions: [],
      nodes: [],
    );
    
    final callbacks = SubscriptionPageCallbacks(
      onSwitchSubscription: (sub) { /* TODO: 切换订阅 */ },
      onCopySubscriptionUrl: (sub) { /* TODO: 复制链接 */ },
      onUpdateSubscription: (sub) { /* TODO: 更新订阅 */ },
      onViewNodes: () { /* TODO: 查看节点 */ },
      onTestLatency: () { /* TODO: 测试延迟 */ },
      onRefresh: () async { /* TODO: 刷新数据 */ },
      onAddSubscription: () { /* TODO: 添加订阅 */ },
      onDeleteSubscription: (sub) { /* TODO: 删除订阅 */ },
    );
    
    return UIRegistry().buildPage<SubscriptionPageContract>(data: data, callbacks: callbacks);
  }
}

