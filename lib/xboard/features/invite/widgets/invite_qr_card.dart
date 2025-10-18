import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/invite/providers/invite_provider.dart';
import 'package:fl_clash/xboard/config/xboard_config.dart';
import 'package:fl_clash/xboard/features/invite/widgets/qr_code_widget.dart';

class InviteQrCard extends ConsumerWidget {
  const InviteQrCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inviteState = ref.watch(inviteProvider);
    
    final firstCode = inviteState.hasInviteData && inviteState.inviteData!.codes.isNotEmpty
        ? inviteState.inviteData!.codes.first
        : null;
    
    final baseUrl = _getSdkBaseUrl();
    final inviteUrl = firstCode != null && baseUrl.isNotEmpty 
        ? '$baseUrl/#/register?code=${firstCode.code}'
        : '';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              appLocalizations.myInviteQr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            if (firstCode != null) ...[
              QrCodeWidget(
                data: inviteUrl,
                size: 200,
              ),
              const SizedBox(height: 20),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _saveQrCode(context, inviteUrl),
                    icon: const Icon(Icons.save_alt),
                    label: Text(appLocalizations.saveQr),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _copyToClipboard(context, inviteUrl),
                    icon: const Icon(Icons.link),
                    label: Text(appLocalizations.copyInviteLink),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ] else if (inviteState.isLoading || inviteState.isGenerating) ...[
              Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      appLocalizations.generatingInviteCode,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      appLocalizations.inviteCodeGenFailed,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      appLocalizations.checkNetwork,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(appLocalizations.copiedToClipboard)),
    );
  }

  void _saveQrCode(BuildContext context, String inviteUrl) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(appLocalizations.saveQrCodeFeature)),
    );
  }

  String _getSdkBaseUrl() {
    try {
      return XBoardConfig.panelUrl ?? '';
    } catch (e) {
      return '';
    }
  }
}