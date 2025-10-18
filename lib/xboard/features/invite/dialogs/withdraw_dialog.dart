import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/invite/providers/invite_provider.dart';
import 'package:fl_clash/xboard/config/xboard_config.dart';

class WithdrawDialog extends ConsumerWidget {
  const WithdrawDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inviteState = ref.read(inviteProvider);
    
    return AlertDialog(
      title: Text(appLocalizations.withdrawCommission),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.web,
            size: 64,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          Text(
            appLocalizations.withdrawableAmount(inviteState.formattedCommission),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            appLocalizations.visitWebVersion,
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            appLocalizations.completeWithdrawal,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await _openWebPage(context);
          },
          child: Text(appLocalizations.goToWeb),
        ),
      ],
    );
  }

  Future<void> _openWebPage(BuildContext context) async {
    final baseUrl = _getSdkBaseUrl();
    if (baseUrl.isNotEmpty) {
      final webUrl = '$baseUrl/#/dashboard';
      try {
        final uri = Uri.parse(webUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(appLocalizations.cannotOpenBrowser)),
            );
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(appLocalizations.openWebFailed)),
          );
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.cannotGetWebUrl)),
        );
      }
    }
  }

  String _getSdkBaseUrl() {
    try {
      return XBoardConfig.panelUrl ?? '';
    } catch (e) {
      return '';
    }
  }
}