/// 邀请页面契约
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

/// 邀请页面契约
abstract class InvitePageContract extends PageContract<InvitePageData, InvitePageCallbacks> {
  const InvitePageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 佣金统计
class CommissionStats {
  final int totalCommission;       // 总佣金（分）
  final int availableCommission;   // 可用佣金（分）
  final int pendingCommission;     // 待确认佣金（分）
  final int withdrawnCommission;   // 已提现佣金（分）
  final int totalInvites;          // 总邀请人数
  final int activeInvites;         // 有效邀请人数

  const CommissionStats({
    required this.totalCommission,
    required this.availableCommission,
    required this.pendingCommission,
    required this.withdrawnCommission,
    required this.totalInvites,
    required this.activeInvites,
  });
  
  String formatAmount(int cents) {
    return '¥${(cents / 100).toStringAsFixed(2)}';
  }
}

/// 邀请历史记录
class InviteRecord {
  final String userId;
  final String username;
  final DateTime inviteDate;
  final bool isActive;
  final int earnedCommission;  // 从该用户获得的佣金（分）
  final DateTime? lastPurchase;

  const InviteRecord({
    required this.userId,
    required this.username,
    required this.inviteDate,
    required this.isActive,
    required this.earnedCommission,
    this.lastPurchase,
  });
}

/// 佣金记录
class CommissionRecord {
  final String id;
  final String type;           // 'invite', 'purchase', 'withdraw'
  final int amount;            // 分
  final String description;
  final DateTime createdAt;
  final String status;         // 'pending', 'completed', 'rejected'

  const CommissionRecord({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.status,
  });
}

/// 钱包信息
class WalletInfo {
  final int balance;           // 余额（分）
  final int frozenBalance;     // 冻结余额（分）
  final int totalWithdrawn;    // 总提现（分）

  const WalletInfo({
    required this.balance,
    required this.frozenBalance,
    required this.totalWithdrawn,
  });
  
  String formatAmount(int cents) {
    return '¥${(cents / 100).toStringAsFixed(2)}';
  }
}

/// 邀请页面数据
class InvitePageData implements DataModel {
  /// 邀请码
  final String inviteCode;
  
  /// 邀请链接
  final String inviteUrl;
  
  /// 佣金统计
  final CommissionStats commissionStats;
  
  /// 钱包信息
  final WalletInfo walletInfo;
  
  /// 邀请历史
  final List<InviteRecord> inviteRecords;
  
  /// 佣金记录
  final List<CommissionRecord> commissionRecords;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 错误信息
  final String? errorMessage;

  const InvitePageData({
    required this.inviteCode,
    required this.inviteUrl,
    required this.commissionStats,
    required this.walletInfo,
    this.inviteRecords = const [],
    this.commissionRecords = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'inviteCode': inviteCode,
      'inviteUrl': inviteUrl,
      'commissionStats': {
        'totalCommission': commissionStats.totalCommission,
        'availableCommission': commissionStats.availableCommission,
        'pendingCommission': commissionStats.pendingCommission,
        'withdrawnCommission': commissionStats.withdrawnCommission,
        'totalInvites': commissionStats.totalInvites,
        'activeInvites': commissionStats.activeInvites,
      },
      'walletInfo': {
        'balance': walletInfo.balance,
        'frozenBalance': walletInfo.frozenBalance,
        'totalWithdrawn': walletInfo.totalWithdrawn,
      },
      'inviteRecords': inviteRecords.map((r) => {
        'userId': r.userId,
        'username': r.username,
        'inviteDate': r.inviteDate.toIso8601String(),
        'isActive': r.isActive,
        'earnedCommission': r.earnedCommission,
      }).toList(),
      'commissionRecords': commissionRecords.map((r) => {
        'id': r.id,
        'type': r.type,
        'amount': r.amount,
        'description': r.description,
        'createdAt': r.createdAt.toIso8601String(),
        'status': r.status,
      }).toList(),
      'isLoading': isLoading,
      'errorMessage': errorMessage,
    };
  }
}

/// 邀请页面回调
class InvitePageCallbacks implements CallbacksModel {
  /// 复制邀请码
  final VoidCallback onCopyInviteCode;
  
  /// 复制邀请链接
  final VoidCallback onCopyInviteUrl;
  
  /// 生成二维码
  final VoidCallback onGenerateQrCode;
  
  /// 分享邀请
  final VoidCallback onShareInvite;
  
  /// 查看佣金记录
  final VoidCallback onViewCommissionHistory;
  
  /// 查看邀请规则
  final VoidCallback onViewInviteRules;
  
  /// 提现申请
  final AsyncCallback onWithdraw;
  
  /// 刷新数据
  final AsyncCallback onRefresh;

  const InvitePageCallbacks({
    required this.onCopyInviteCode,
    required this.onCopyInviteUrl,
    required this.onGenerateQrCode,
    required this.onShareInvite,
    required this.onViewCommissionHistory,
    required this.onViewInviteRules,
    required this.onWithdraw,
    required this.onRefresh,
  });
}

