/// 订阅管理页面契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

/// 订阅管理页面契约
abstract class SubscriptionPageContract extends PageContract<SubscriptionPageData, SubscriptionPageCallbacks> {
  const SubscriptionPageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 订阅信息
class SubscriptionInfo {
  final String id;
  final String name;
  final String url;
  final int totalTraffic;
  final int usedTraffic;
  final DateTime? expireDate;
  final bool isActive;
  final int nodeCount;
  final DateTime? lastUpdate;

  const SubscriptionInfo({
    required this.id,
    required this.name,
    required this.url,
    required this.totalTraffic,
    required this.usedTraffic,
    this.expireDate,
    required this.isActive,
    required this.nodeCount,
    this.lastUpdate,
  });
  
  double get usagePercentage {
    if (totalTraffic == 0) return 0;
    return (usedTraffic / totalTraffic * 100).clamp(0, 100);
  }
  
  int get remainingTraffic => totalTraffic - usedTraffic;
  
  String formatBytes(int bytes) {
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}

/// 节点信息
class NodeInfo {
  final String name;
  final String type;
  final String location;
  final int? latency;
  final bool isOnline;

  const NodeInfo({
    required this.name,
    required this.type,
    required this.location,
    this.latency,
    required this.isOnline,
  });
}

/// 订阅管理页面数据
class SubscriptionPageData implements DataModel {
  /// 订阅列表
  final List<SubscriptionInfo> subscriptions;
  
  /// 当前选中的订阅
  final SubscriptionInfo? currentSubscription;
  
  /// 节点列表
  final List<NodeInfo> nodes;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 是否正在更新订阅
  final String? updatingSubscriptionId;
  
  /// 错误信息
  final String? errorMessage;

  const SubscriptionPageData({
    this.subscriptions = const [],
    this.currentSubscription,
    this.nodes = const [],
    this.isLoading = false,
    this.updatingSubscriptionId,
    this.errorMessage,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'subscriptions': subscriptions.map((s) => {
        'id': s.id,
        'name': s.name,
        'url': s.url,
        'totalTraffic': s.totalTraffic,
        'usedTraffic': s.usedTraffic,
        'expireDate': s.expireDate?.toIso8601String(),
        'isActive': s.isActive,
        'nodeCount': s.nodeCount,
        'lastUpdate': s.lastUpdate?.toIso8601String(),
      }).toList(),
      'currentSubscription': currentSubscription != null ? {
        'id': currentSubscription!.id,
        'name': currentSubscription!.name,
      } : null,
      'nodes': nodes.map((n) => {
        'name': n.name,
        'type': n.type,
        'location': n.location,
        'latency': n.latency,
        'isOnline': n.isOnline,
      }).toList(),
      'isLoading': isLoading,
      'updatingSubscriptionId': updatingSubscriptionId,
      'errorMessage': errorMessage,
    };
  }
}

/// 订阅管理页面回调
class SubscriptionPageCallbacks implements CallbacksModel {
  /// 切换订阅
  final ValueCallback<SubscriptionInfo> onSwitchSubscription;
  
  /// 复制订阅链接
  final ValueCallback<SubscriptionInfo> onCopySubscriptionUrl;
  
  /// 更新订阅
  final ValueCallback<SubscriptionInfo> onUpdateSubscription;
  
  /// 查看节点详情
  final VoidCallback onViewNodes;
  
  /// 测试节点延迟
  final VoidCallback onTestLatency;
  
  /// 刷新数据
  final AsyncCallback onRefresh;
  
  /// 添加订阅
  final VoidCallback onAddSubscription;
  
  /// 删除订阅
  final ValueCallback<SubscriptionInfo> onDeleteSubscription;

  const SubscriptionPageCallbacks({
    required this.onSwitchSubscription,
    required this.onCopySubscriptionUrl,
    required this.onUpdateSubscription,
    required this.onViewNodes,
    required this.onTestLatency,
    required this.onRefresh,
    required this.onAddSubscription,
    required this.onDeleteSubscription,
  });
}

