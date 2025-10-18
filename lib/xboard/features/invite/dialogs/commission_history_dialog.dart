import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/invite/providers/invite_provider.dart';

class CommissionHistoryDialog extends ConsumerStatefulWidget {
  const CommissionHistoryDialog({super.key});

  @override
  ConsumerState<CommissionHistoryDialog> createState() => _CommissionHistoryDialogState();
}

class _CommissionHistoryDialogState extends ConsumerState<CommissionHistoryDialog> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final inviteState = ref.read(inviteProvider);
      if (inviteState.hasMoreHistory && !inviteState.isLoadingHistory) {
        ref.read(inviteProvider.notifier).loadNextHistoryPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final inviteState = ref.watch(inviteProvider);
    
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(appLocalizations.commissionHistory),
          IconButton(
            onPressed: () => ref.read(inviteProvider.notifier).refreshCommissionHistory(),
            icon: const Icon(Icons.refresh),
            tooltip: appLocalizations.refresh,
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.totalRecords(inviteState.commissionHistory.length),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    appLocalizations.pageNumber(inviteState.currentHistoryPage),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: inviteState.commissionHistory.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.history, size: 48, color: Colors.grey),
                          const SizedBox(height: 8),
                          Text(appLocalizations.noCommissionRecord, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: inviteState.commissionHistory.length + (inviteState.hasMoreHistory ? 1 : 0),
                      itemBuilder: (buildContext, index) {
                        if (index >= inviteState.commissionHistory.length) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: inviteState.isLoadingHistory
                                  ? Column(
                                      children: [
                                        const CircularProgressIndicator(),
                                        const SizedBox(height: 8),
                                        Text(appLocalizations.loading, style: const TextStyle(color: Colors.grey)),
                                      ],
                                    )
                                  : TextButton.icon(
                                      onPressed: () => ref.read(inviteProvider.notifier).loadNextHistoryPage(),
                                      icon: const Icon(Icons.expand_more),
                                      label: Text(appLocalizations.loadMore),
                                    ),
                            ),
                          );
                        }
                        
                        final commission = inviteState.commissionHistory[index];
                        return _buildCommissionItem(commission);
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.close),
        ),
      ],
    );
  }

  Widget _buildCommissionItem(CommissionDetailData commission) {
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
}