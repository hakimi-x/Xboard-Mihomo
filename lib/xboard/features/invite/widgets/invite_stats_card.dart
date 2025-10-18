import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/invite/providers/invite_provider.dart';
import 'package:fl_clash/xboard/features/invite/widgets/stat_item_widget.dart';

class InviteStatsCard extends ConsumerWidget {
  const InviteStatsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inviteState = ref.watch(inviteProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.inviteStats,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (inviteState.isLoading && !inviteState.hasInviteData)
              const Center(child: CircularProgressIndicator())
            else
              Row(
                children: [
                  Expanded(
                    child: StatItemWidget(
                      title: appLocalizations.totalInvites, 
                      value: '${inviteState.totalInvites}', 
                      icon: Icons.people,
                    ),
                  ),
                  Expanded(
                    child: StatItemWidget(
                      title: appLocalizations.totalInvites,
                      value: '${inviteState.validInvites}',
                      icon: Icons.people_alt,
                    ),
                  ),
                  Expanded(
                    child: StatItemWidget(
                      title: appLocalizations.totalCommission, 
                      value: inviteState.formattedCommission, 
                      icon: Icons.monetization_on,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}