import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/invite/providers/invite_provider.dart';
import 'package:fl_clash/xboard/features/invite/dialogs/withdraw_dialog.dart';
import 'package:fl_clash/xboard/features/invite/dialogs/commission_history_dialog.dart';

class CommissionHistoryCard extends ConsumerWidget {
  const CommissionHistoryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inviteState = ref.watch(inviteProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.commissionHistory,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (inviteState.totalCommission > 0)
                  TextButton.icon(
                    onPressed: () => _showWithdrawDialog(context),
                    icon: const Icon(Icons.payment),
                    label: Text(appLocalizations.withdraw),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (inviteState.commissionHistory.isEmpty)
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.history,
                      size: 48,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      appLocalizations.noCommissionRecord,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...inviteState.commissionHistory.take(5).map((commission) => 
                _buildCommissionItem(context, commission)
              ),
            if (inviteState.commissionHistory.length >= 5)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () => _showCommissionHistoryDialog(context),
                    icon: const Icon(Icons.history),
                    label: Text(appLocalizations.viewHistory),
                  ),
                  if (inviteState.commissionHistory.length >= 5)
                    TextButton.icon(
                      onPressed: () => ref.read(inviteProvider.notifier).loadNextHistoryPage(),
                      icon: inviteState.isLoadingHistory 
                        ? const SizedBox(
                            width: 16, 
                            height: 16, 
                            child: CircularProgressIndicator(strokeWidth: 2)
                          )
                        : const Icon(Icons.refresh),
                      label: Text(inviteState.isLoadingHistory ? appLocalizations.loading : appLocalizations.loadMore),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommissionItem(BuildContext context, CommissionDetailData commission) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.monetization_on,
            color: Colors.green[600],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¥${commission.getAmountInYuan.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  appLocalizations.orderNumber(commission.tradeNo),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${commission.createdAt.year}-${commission.createdAt.month.toString().padLeft(2, '0')}-${commission.createdAt.day.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                appLocalizations.orderAmount('¥${commission.orderAmountInYuan.toStringAsFixed(2)}'),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const WithdrawDialog(),
    );
  }

  void _showCommissionHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CommissionHistoryDialog(),
    );
  }
}