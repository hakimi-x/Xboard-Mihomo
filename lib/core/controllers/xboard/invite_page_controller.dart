/// 邀请页面控制器
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvitePageController extends ConsumerWidget {
  const InvitePageController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: 从Provider获取邀请数据
    final data = InvitePageData(
      inviteCode: 'DEMO123',
      inviteUrl: 'https://example.com/invite/DEMO123',
      commissionStats: const CommissionStats(
        totalCommission: 10000,
        availableCommission: 5000,
        pendingCommission: 3000,
        withdrawnCommission: 2000,
        totalInvites: 10,
        activeInvites: 5,
      ),
      walletInfo: const WalletInfo(
        balance: 5000,
        frozenBalance: 1000,
        totalWithdrawn: 2000,
      ),
      inviteRecords: const [],
      commissionRecords: const [],
    );
    
    final callbacks = InvitePageCallbacks(
      onCopyInviteCode: () { /* TODO: 复制邀请码 */ },
      onCopyInviteUrl: () { /* TODO: 复制邀请链接 */ },
      onGenerateQrCode: () { /* TODO: 生成二维码 */ },
      onShareInvite: () { /* TODO: 分享邀请 */ },
      onViewCommissionHistory: () { /* TODO: 查看佣金记录 */ },
      onViewInviteRules: () { /* TODO: 查看邀请规则 */ },
      onWithdraw: () async { /* TODO: 提现申请 */ },
      onRefresh: () async { /* TODO: 刷新数据 */ },
    );
    
    return UIRegistry().buildPage<InvitePageContract>(data: data, callbacks: callbacks);
  }
}

