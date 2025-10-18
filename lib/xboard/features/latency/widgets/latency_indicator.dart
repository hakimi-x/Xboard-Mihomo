import 'package:fl_clash/common/utils.dart';
import 'package:flutter/material.dart';
class LatencyIndicator extends StatelessWidget {
  final int? delayValue;
  final VoidCallback? onTap;
  final bool isCompact;
  final bool showIcon;
  const LatencyIndicator({
    super.key,
    required this.delayValue,
    this.onTap,
    this.isCompact = false,
    this.showIcon = true,
  });
  @override
  Widget build(BuildContext context) {
    if (delayValue == 0) {
      return _buildTestingState(context);
    }
    if (delayValue == null) {
      return _buildUntestedState(context);
    }
    return _buildTestedState(context);
  }
  Widget _buildTestingState(BuildContext context) {
    if (isCompact) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          if (!isCompact) ...[
            const SizedBox(width: 4),
            Text(
              '测试中',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
  Widget _buildUntestedState(BuildContext context) {
    if (isCompact) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.refresh,
            size: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              Icons.refresh,
              size: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            '自动测试中',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildTestedState(BuildContext context) {
    final displayText = delayValue! < 0 ? 'Timeout' : '${delayValue}ms';
    final color = utils.getDelayColor(delayValue!);
    if (isCompact) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: color?.withValues(alpha: 0.1) ?? Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color?.withValues(alpha: 0.3) ?? Colors.grey.withValues(alpha: 0.3)),
          ),
          child: Text(
            delayValue! < 0 ? '超时' : '$delayValue',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color?.withValues(alpha: 0.3) ?? Colors.grey.withValues(alpha: 0.3),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            displayText,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
class LatencyQuality {
  static const int excellent = 50;
  static const int good = 100;
  static const int fair = 200;
  static const int poor = 500;
  static String getQualityLevel(int delay) {
    if (delay < 0) return '超时';
    if (delay <= excellent) return '优秀';
    if (delay <= good) return '良好';
    if (delay <= fair) return '一般';
    if (delay <= poor) return '较差';
    return '很差';
  }
  static String getQualityDescription(int delay) {
    if (delay < 0) return '连接超时，请检查网络';
    if (delay <= excellent) return '网络质量优秀，适合所有应用';
    if (delay <= good) return '网络质量良好，适合大多数应用';
    if (delay <= fair) return '网络质量一般，可用于基本应用';
    if (delay <= poor) return '网络质量较差，可能影响体验';
    return '网络质量很差，建议更换节点';
  }
  static IconData getQualityIcon(int delay) {
    if (delay < 0) return Icons.signal_wifi_off;
    if (delay <= excellent) return Icons.signal_wifi_4_bar;
    if (delay <= good) return Icons.signal_wifi_4_bar;
    if (delay <= fair) return Icons.signal_wifi_4_bar;
    if (delay <= poor) return Icons.signal_wifi_bad;
    return Icons.signal_wifi_0_bar;
  }
}