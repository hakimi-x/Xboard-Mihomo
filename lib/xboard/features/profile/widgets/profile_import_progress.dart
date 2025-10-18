import 'package:fl_clash/xboard/features/profile/providers/profile_import_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/xboard/features/profile/profile.dart';
class ProfileImportProgressCard extends ConsumerWidget {
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  const ProfileImportProgressCard({
    super.key,
    this.onRetry,
    this.onDismiss,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final importState = ref.watch(profileImportProvider);
    final importNotifier = ref.read(profileImportProvider.notifier);
    if (importState.status == ImportStatus.idle && !importNotifier.hasError) {
      return const SizedBox.shrink();
    }
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, importState, importNotifier),
            const SizedBox(height: 12),
            _buildContent(context, importState, importNotifier),
          ],
        ),
      ),
    );
  }
  Widget _buildHeader(BuildContext context, ImportState state, ProfileImportNotifier notifier) {
    return Row(
      children: [
        _buildStatusIcon(state),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            _getHeaderText(state),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (state.isImporting)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => notifier.cancelImport(),
            tooltip: '取消导入',
          ),
        if (notifier.hasError && onDismiss != null)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onDismiss,
            tooltip: '关闭',
          ),
      ],
    );
  }
  Widget _buildStatusIcon(ImportState state) {
    switch (state.status) {
      case ImportStatus.idle:
      case ImportStatus.cleaning:
      case ImportStatus.downloading:
      case ImportStatus.validating:
      case ImportStatus.adding:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case ImportStatus.success:
        return const Icon(Icons.check_circle, color: Colors.green, size: 20);
      case ImportStatus.failed:
        return const Icon(Icons.error, color: Colors.red, size: 20);
    }
  }
  String _getHeaderText(ImportState state) {
    switch (state.status) {
      case ImportStatus.idle:
        return '准备导入配置';
      case ImportStatus.cleaning:
      case ImportStatus.downloading:
      case ImportStatus.validating:
      case ImportStatus.adding:
        return '正在导入配置';
      case ImportStatus.success:
        return '配置导入成功';
      case ImportStatus.failed:
        return '配置导入失败';
    }
  }
  Widget _buildContent(BuildContext context, ImportState state, ProfileImportNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.isImporting) ...[
          LinearProgressIndicator(
            value: state.progress,
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(height: 8),
        ],
        if (state.message != null) ...[
          Text(
            state.message!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: _getMessageColor(context, state),
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (notifier.hasError) ...[
          if (state.errorTypeMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red[600], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      state.errorTypeMessage!,
                      style: TextStyle(color: Colors.red[800]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => notifier.clearError(),
                child: const Text('清除错误'),
              ),
              const SizedBox(width: 8),
              if (notifier.canRetry)
                                 ElevatedButton.icon(
                   onPressed: () async {
                     await notifier.retryLastImport();
                     onRetry?.call();
                   },
                  icon: const Icon(Icons.refresh),
                  label: const Text('重试'),
                ),
            ],
          ),
        ],
        if (state.status == ImportStatus.success) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green[600], size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '配置已成功导入并添加到配置列表',
                    style: TextStyle(color: Colors.green[800]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => notifier.clearState(),
                child: const Text('确定'),
              ),
            ],
          ),
        ],
      ],
    );
  }
  Color? _getMessageColor(BuildContext context, ImportState state) {
    switch (state.status) {
      case ImportStatus.failed:
        return Colors.red[700];
      case ImportStatus.success:
        return Colors.green[700];
      default:
        return Theme.of(context).textTheme.bodyMedium?.color;
    }
  }
}
class ImportStatusIndicator extends ConsumerWidget {
  const ImportStatusIndicator({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isImporting = ref.watch(profileImportProvider.select((state) => state.isImporting));
    final progress = ref.watch(profileImportProvider.select((state) => state.progress));
    final statusText = ref.watch(profileImportProvider.select((state) => state.statusText));
    if (!isImporting) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 8),
          Text(
            statusText,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(width: 8),
          Text(
            '${(progress * 100).toInt()}%',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
} 