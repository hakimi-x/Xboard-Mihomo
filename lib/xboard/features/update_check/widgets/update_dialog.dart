import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_clash/common/common.dart';
import '../models/update_check_state.dart';
class UpdateDialog extends ConsumerWidget {
  final UpdateCheckState state;
  const UpdateDialog({super.key, required this.state});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            state.forceUpdate ? Icons.warning : Icons.system_update,
            color: state.forceUpdate 
                ? Colors.red 
                : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              state.forceUpdate 
                  ? appLocalizations.updateCheckForceUpdate(state.latestVersion ?? '')
                  : appLocalizations.updateCheckNewVersionFound(state.latestVersion ?? ''),
              style: TextStyle(
                color: state.forceUpdate ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 8),
                Text(
                  appLocalizations.updateCheckCurrentVersion(state.currentVersion ?? ''),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (state.releaseNotes != null && state.releaseNotes!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              appLocalizations.updateCheckReleaseNotes,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxHeight: 120),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Text(
                  state.releaseNotes!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
      actions: [
        if (!state.forceUpdate)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(appLocalizations.updateCheckUpdateLater),
          ),
        ElevatedButton.icon(
          onPressed: () {
            if (state.updateUrl != null) {
              _launchUrl(state.updateUrl!);
            }
            if (!state.forceUpdate) {
              Navigator.of(context).pop();
            }
          },
          icon: const Icon(Icons.download, size: 18),
          label: Text(state.forceUpdate ? appLocalizations.updateCheckMustUpdate : appLocalizations.updateCheckUpdateNow),
          style: state.forceUpdate 
              ? ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                )
              : null,
        ),
      ],
    );
  }
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}