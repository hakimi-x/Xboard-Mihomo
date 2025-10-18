import 'package:flutter/material.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
import 'package:fl_clash/models/models.dart' as fl_models;
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/xboard/features/auth/auth.dart';
enum SubscriptionStatusType {
  valid,
  noSubscription,
  expired,
  exhausted,
  notLoggedIn,
}
class SubscriptionStatusResult {
  final SubscriptionStatusType type;
  final String Function(BuildContext) messageBuilder;
  final String? Function(BuildContext)? detailMessageBuilder;
  final DateTime? expiredAt;
  final int? remainingDays;
  final bool needsDialog;
  const SubscriptionStatusResult({
    required this.type,
    required this.messageBuilder,
    this.detailMessageBuilder,
    this.expiredAt,
    this.remainingDays,
    this.needsDialog = false,
  });
  String getMessage(BuildContext context) => messageBuilder(context);
  String? getDetailMessage(BuildContext context) => detailMessageBuilder?.call(context);
  bool get shouldShowDialog => needsDialog;
}
class SubscriptionStatusService {
  static const SubscriptionStatusService _instance = SubscriptionStatusService._internal();
  factory SubscriptionStatusService() => _instance;
  const SubscriptionStatusService._internal();
  SubscriptionStatusResult checkSubscriptionStatus({
    required UserAuthState userState,
    fl_models.SubscriptionInfo? profileSubscriptionInfo,
  }) {
    if (!userState.isAuthenticated) {
      return SubscriptionStatusResult(
        type: SubscriptionStatusType.notLoggedIn,
        messageBuilder: (context) => AppLocalizations.of(context).subscriptionNotLoggedIn,
        detailMessageBuilder: (context) => AppLocalizations.of(context).subscriptionNotLoggedInDetail,
        needsDialog: false,
      );
    }
    final subscriptionInfo = userState.subscriptionInfo;
    if (subscriptionInfo == null) {
      return SubscriptionStatusResult(
        type: SubscriptionStatusType.noSubscription,
        messageBuilder: (context) => AppLocalizations.of(context).subscriptionNoSubscription,
        detailMessageBuilder: (context) => AppLocalizations.of(context).subscriptionNoSubscriptionDetail,
        needsDialog: true,
      );
    }
    final expiredAt = _getEffectiveExpiredAt(subscriptionInfo, profileSubscriptionInfo);
    if (expiredAt != null) {
      final now = DateTime.now();
      final isExpired = now.isAfter(expiredAt);
      final remainingDays = expiredAt.difference(now).inDays;
      if (isExpired || remainingDays < 0) {
        return SubscriptionStatusResult(
          type: SubscriptionStatusType.expired,
          messageBuilder: (context) => AppLocalizations.of(context).subscriptionExpired,
          detailMessageBuilder: (context) => AppLocalizations.of(context).subscriptionExpiredDetail(_formatDate(expiredAt)),
          expiredAt: expiredAt,
          remainingDays: remainingDays,
          needsDialog: true,
        );
      }
      if (remainingDays == 0) {
        return SubscriptionStatusResult(
          type: SubscriptionStatusType.expired,
          messageBuilder: (context) => AppLocalizations.of(context).subscriptionExpiresToday,
          detailMessageBuilder: (context) => AppLocalizations.of(context).subscriptionExpiresTodayDetail,
          expiredAt: expiredAt,
          remainingDays: remainingDays,
          needsDialog: true,
        );
      }
      if (remainingDays <= 3) {
        return SubscriptionStatusResult(
          type: SubscriptionStatusType.valid,
          messageBuilder: (context) => AppLocalizations.of(context).subscriptionExpiringInDays,
          detailMessageBuilder: (context) => AppLocalizations.of(context).subscriptionExpiringInDaysDetail(remainingDays),
          expiredAt: expiredAt,
          remainingDays: remainingDays,
          needsDialog: false, // 即将过期不强制弹窗
        );
      }
    }
    final trafficStatus = _checkTrafficStatus(subscriptionInfo, profileSubscriptionInfo);
    if (trafficStatus != null) {
      return trafficStatus;
    }
    final remainingDays = expiredAt?.difference(DateTime.now()).inDays;
    return SubscriptionStatusResult(
      type: SubscriptionStatusType.valid,
      messageBuilder: (context) => AppLocalizations.of(context).subscriptionValid,
      detailMessageBuilder: remainingDays != null 
        ? (context) => AppLocalizations.of(context).subscriptionValidDetail(remainingDays)
        : null,
      expiredAt: expiredAt,
      remainingDays: remainingDays,
      needsDialog: false,
    );
  }
  DateTime? _getEffectiveExpiredAt(
    SubscriptionData subscriptionInfo,
    fl_models.SubscriptionInfo? profileSubscriptionInfo,
  ) {
    if (profileSubscriptionInfo?.expire != null && profileSubscriptionInfo!.expire != 0) {
      return DateTime.fromMillisecondsSinceEpoch(profileSubscriptionInfo.expire * 1000);
    }
    return subscriptionInfo.expiredAt;
  }
  SubscriptionStatusResult? _checkTrafficStatus(
    SubscriptionData subscriptionInfo,
    fl_models.SubscriptionInfo? profileSubscriptionInfo,
  ) {
    double usedTraffic = 0;
    double totalTraffic = 0;
    if (profileSubscriptionInfo != null && profileSubscriptionInfo.total > 0) {
      usedTraffic = (profileSubscriptionInfo.upload + profileSubscriptionInfo.download).toDouble();
      totalTraffic = profileSubscriptionInfo.total.toDouble();
    } else if (subscriptionInfo.transferEnable != null && subscriptionInfo.transferEnable! > 0) {
      totalTraffic = subscriptionInfo.transferEnable!.toDouble();
      usedTraffic = (subscriptionInfo.u ?? 0).toDouble() + (subscriptionInfo.d ?? 0).toDouble();
    }
    if (totalTraffic <= 0) return null;
    final usageRatio = usedTraffic / totalTraffic;
    if (usageRatio >= 0.95) {
      return SubscriptionStatusResult(
        type: SubscriptionStatusType.exhausted,
        messageBuilder: (context) => AppLocalizations.of(context).subscriptionTrafficExhausted,
        detailMessageBuilder: (context) => AppLocalizations.of(context).subscriptionTrafficExhaustedDetail,
        needsDialog: true,
      );
    }
    return null;
  }
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
  bool shouldShowStartupDialog(SubscriptionStatusResult result) {
    return result.shouldShowDialog && (
      result.type == SubscriptionStatusType.noSubscription ||
      result.type == SubscriptionStatusType.expired ||
      result.type == SubscriptionStatusType.exhausted
    );
  }
}
final subscriptionStatusService = SubscriptionStatusService();