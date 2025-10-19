/// XBoard 首页契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

/// XBoard 首页契约
abstract class XBoardHomePageContract extends PageContract<XBoardHomePageData, XBoardHomePageCallbacks> {
  const XBoardHomePageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 用户信息
class UserInfo {
  final String username;
  final String email;
  final String? avatar;
  final int userId;

  const UserInfo({
    required this.username,
    required this.email,
    this.avatar,
    required this.userId,
  });
}

/// 订阅状态
class SubscriptionStatus {
  final String planName;
  final DateTime? expireDate;
  final int remainingDays;
  final bool isExpired;
  final bool isActive;

  const SubscriptionStatus({
    required this.planName,
    this.expireDate,
    required this.remainingDays,
    required this.isExpired,
    required this.isActive,
  });
  
  String get formattedExpireDate {
    if (expireDate == null) return '未订阅';
    return '${expireDate!.year}-${expireDate!.month.toString().padLeft(2, '0')}-${expireDate!.day.toString().padLeft(2, '0')}';
  }
}

/// 流量统计
class TrafficStats {
  final int usedTraffic;    // 已使用（字节）
  final int totalTraffic;   // 总流量（字节）
  final int uploadTraffic;  // 上传（字节）
  final int downloadTraffic; // 下载（字节）
  final double usagePercentage; // 使用百分比

  const TrafficStats({
    required this.usedTraffic,
    required this.totalTraffic,
    required this.uploadTraffic,
    required this.downloadTraffic,
    required this.usagePercentage,
  });
  
  String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}

/// 公告信息
class NoticeInfo {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  final bool isRead;

  const NoticeInfo({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.isRead,
  });
}

/// XBoard 首页数据
class XBoardHomePageData implements DataModel {
  /// 用户信息
  final UserInfo userInfo;
  
  /// 订阅状态
  final SubscriptionStatus subscriptionStatus;
  
  /// 流量统计
  final TrafficStats trafficStats;
  
  /// 公告列表
  final List<NoticeInfo> notices;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 是否正在刷新
  final bool isRefreshing;
  
  /// 错误信息
  final String? errorMessage;

  const XBoardHomePageData({
    required this.userInfo,
    required this.subscriptionStatus,
    required this.trafficStats,
    this.notices = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.errorMessage,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'userInfo': {
        'username': userInfo.username,
        'email': userInfo.email,
        'avatar': userInfo.avatar,
        'userId': userInfo.userId,
      },
      'subscriptionStatus': {
        'planName': subscriptionStatus.planName,
        'expireDate': subscriptionStatus.expireDate?.toIso8601String(),
        'remainingDays': subscriptionStatus.remainingDays,
        'isExpired': subscriptionStatus.isExpired,
        'isActive': subscriptionStatus.isActive,
      },
      'trafficStats': {
        'usedTraffic': trafficStats.usedTraffic,
        'totalTraffic': trafficStats.totalTraffic,
        'uploadTraffic': trafficStats.uploadTraffic,
        'downloadTraffic': trafficStats.downloadTraffic,
        'usagePercentage': trafficStats.usagePercentage,
      },
      'notices': notices.map((n) => {
        'id': n.id,
        'title': n.title,
        'content': n.content,
        'createdAt': n.createdAt.toIso8601String(),
        'isRead': n.isRead,
      }).toList(),
      'isLoading': isLoading,
      'isRefreshing': isRefreshing,
      'errorMessage': errorMessage,
    };
  }
}

/// XBoard 首页回调
class XBoardHomePageCallbacks implements CallbacksModel {
  /// 刷新数据
  final AsyncCallback onRefresh;
  
  /// 订阅管理
  final VoidCallback onManageSubscription;
  
  /// 购买套餐
  final VoidCallback onPurchasePlan;
  
  /// 个人中心
  final VoidCallback onProfile;
  
  /// 在线客服
  final VoidCallback onOnlineSupport;
  
  /// 邀请好友
  final VoidCallback onInvite;
  
  /// 查看公告详情
  final ValueCallback<NoticeInfo> onViewNotice;
  
  /// 退出登录
  final AsyncCallback onLogout;

  const XBoardHomePageCallbacks({
    required this.onRefresh,
    required this.onManageSubscription,
    required this.onPurchasePlan,
    required this.onProfile,
    required this.onOnlineSupport,
    required this.onInvite,
    required this.onViewNotice,
    required this.onLogout,
  });
}

