import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/invite/providers/invite_provider.dart';

class InviteRulesCard extends ConsumerWidget {
  const InviteRulesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(inviteProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.rule, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  appLocalizations.inviteRules,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '• ${appLocalizations.inviteRegisterReward}\n'
              '• ${appLocalizations.friendInviteReward}\n'
              '• ${appLocalizations.commissionSettled}\n'
              '• ${appLocalizations.withdrawalAvailable}',
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}