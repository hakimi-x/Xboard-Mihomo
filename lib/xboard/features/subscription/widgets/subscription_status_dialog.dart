import 'package:flutter/material.dart';
import '../services/subscription_status_service.dart';
import 'package:fl_clash/l10n/l10n.dart';
class SubscriptionStatusDialog extends StatelessWidget {
  final SubscriptionStatusResult statusResult;
  final VoidCallback? onPurchase;
  final VoidCallback? onRefresh;
  const SubscriptionStatusDialog({
    super.key,
    required this.statusResult,
    this.onPurchase,
    this.onRefresh,
  });
  static Future<String?> show(
    BuildContext context,
    SubscriptionStatusResult statusResult, {
    VoidCallback? onPurchase,
    VoidCallback? onRefresh,
  }) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // 防止点击外部关闭
      builder: (context) => SubscriptionStatusDialog(
        statusResult: statusResult,
        onPurchase: onPurchase,
        onRefresh: onRefresh,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      icon: _buildIcon(),
      title: Text(
        _getTitle(context),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statusResult.getDetailMessage(context) ?? statusResult.getMessage(context),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
            if (_shouldShowFeatureList()) ...[
              const SizedBox(height: 16),
              _buildFeatureList(context),
            ],
          ],
        ),
      ),
      actions: _buildActions(context),
    );
  }
  Widget _buildIcon() {
    Color iconColor;
    IconData iconData;
    Color backgroundColor;
    switch (statusResult.type) {
      case SubscriptionStatusType.noSubscription:
        iconColor = Colors.blue.shade600;
        iconData = Icons.card_giftcard;
        backgroundColor = Colors.blue.withValues(alpha: 0.1);
        break;
      case SubscriptionStatusType.expired:
        iconColor = Colors.red.shade600;
        iconData = Icons.schedule;
        backgroundColor = Colors.red.withValues(alpha: 0.1);
        break;
      case SubscriptionStatusType.exhausted:
        iconColor = Colors.orange.shade600;
        iconData = Icons.data_usage;
        backgroundColor = Colors.orange.withValues(alpha: 0.1);
        break;
      default:
        iconColor = Colors.green.shade600;
        iconData = Icons.check_circle;
        backgroundColor = Colors.green.withValues(alpha: 0.1);
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 32,
      ),
    );
  }
  String _getTitle(BuildContext context) {
    switch (statusResult.type) {
      case SubscriptionStatusType.noSubscription:
        return AppLocalizations.of(context).xboardNoAvailablePlan;
      case SubscriptionStatusType.expired:
        return AppLocalizations.of(context).xboardSubscriptionHasExpired;
      case SubscriptionStatusType.exhausted:
        return AppLocalizations.of(context).xboardTrafficUsedUp;
      default:
        return AppLocalizations.of(context).xboardSubscriptionStatus;
    }
  }
  bool _shouldShowFeatureList() {
    return statusResult.type == SubscriptionStatusType.noSubscription;
  }
  Widget _buildFeatureList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).xboardAfterPurchasingPlan,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            context,
            Icons.speed,
            AppLocalizations.of(context).xboardHighSpeedNetwork,
            AppLocalizations.of(context).xboardEnjoyFastNetworkExperience,
          ),
          const SizedBox(height: 8),
          _buildFeatureItem(
            context,
            Icons.security,
            AppLocalizations.of(context).xboardSecureEncryption,
            AppLocalizations.of(context).xboardProtectNetworkPrivacy,
          ),
          const SizedBox(height: 8),
          _buildFeatureItem(
            context,
            Icons.public,
            AppLocalizations.of(context).xboardGlobalNodes,
            AppLocalizations.of(context).xboardConnectGlobalQualityNodes,
          ),
          const SizedBox(height: 8),
          _buildFeatureItem(
            context,
            Icons.support_agent,
            AppLocalizations.of(context).xboardProfessionalSupport,
            AppLocalizations.of(context).xboard24HourCustomerService,
          ),
        ],
      ),
    );
  }
  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];
    if (statusResult.type == SubscriptionStatusType.expired ||
        statusResult.type == SubscriptionStatusType.exhausted) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop('refresh');
            onRefresh?.call();
          },
          child: Text(
            AppLocalizations.of(context).xboardRefreshStatus,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      );
    }
    actions.add(
      TextButton(
        onPressed: () => Navigator.of(context).pop('later'),
        child: Text(
          AppLocalizations.of(context).xboardHandleLater,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
    actions.add(
      FilledButton(
        onPressed: () {
          Navigator.of(context).pop('purchase');
          onPurchase?.call();
        },
        style: FilledButton.styleFrom(
          backgroundColor: _getPrimaryButtonColor(),
          foregroundColor: Colors.white,
        ),
        child: Text(_getPrimaryButtonText(context)),
      ),
    );
    return actions;
  }
  Color _getPrimaryButtonColor() {
    switch (statusResult.type) {
      case SubscriptionStatusType.noSubscription:
        return Colors.blue.shade600;
      case SubscriptionStatusType.expired:
        return Colors.red.shade600;
      case SubscriptionStatusType.exhausted:
        return Colors.orange.shade600;
      default:
        return Colors.green.shade600;
    }
  }
  String _getPrimaryButtonText(BuildContext context) {
    switch (statusResult.type) {
      case SubscriptionStatusType.noSubscription:
        return AppLocalizations.of(context).xboardPurchasePlan;
      case SubscriptionStatusType.expired:
        return AppLocalizations.of(context).xboardRenewPlan;
      case SubscriptionStatusType.exhausted:
        return AppLocalizations.of(context).xboardPurchaseTraffic;
      default:
        return AppLocalizations.of(context).xboardConfirmAction;
    }
  }
}