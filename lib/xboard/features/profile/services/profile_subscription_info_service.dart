import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart' as xboard;

/// Profile 订阅信息服务
///
/// 统一处理从 XBoard API 获取订阅信息并创建 SubscriptionInfo 的逻辑
class ProfileSubscriptionInfoService {
  static const ProfileSubscriptionInfoService _instance = ProfileSubscriptionInfoService._();

  const ProfileSubscriptionInfoService._();

  static ProfileSubscriptionInfoService get instance => _instance;

  /// 获取并创建 SubscriptionInfo
  ///
  /// 首先尝试从 XBoard API 获取详细订阅数据，失败则回退到解析订阅头信息
  ///
  /// [subscriptionUserInfo] 可选的订阅头信息字符串，用作回退
  ///
  /// 返回创建的 SubscriptionInfo，如果获取失败则返回空的 SubscriptionInfo
  Future<SubscriptionInfo> getSubscriptionInfo({
    String? subscriptionUserInfo,
  }) async {
    try {
      // 尝试从 XBoard API 获取详细的订阅数据
      final subscriptionData = await xboard.XBoardSDK.getSubscription();

      if (subscriptionData != null) {
        // 使用 XBoard 订阅数据创建 SubscriptionInfo (Profile模型)
        return SubscriptionInfo(
          upload: subscriptionData.u ?? 0,
          download: subscriptionData.d ?? 0,
          total: subscriptionData.transferEnable ?? 0,
          expire: subscriptionData.expiredAt != null
            ? (subscriptionData.expiredAt!.millisecondsSinceEpoch / 1000).round()
            : 0,
        );
      }

      // 回退到解析 subscription-userinfo 头（如果有）
      if (subscriptionUserInfo != null) {
        return SubscriptionInfo.formHString(subscriptionUserInfo);
      }

      // 都没有的情况下返回空的 SubscriptionInfo
      return const SubscriptionInfo();

    } catch (e) {
      // 获取失败时回退到解析 subscription-userinfo 头
      if (subscriptionUserInfo != null) {
        return SubscriptionInfo.formHString(subscriptionUserInfo);
      }

      // 最终回退到空的 SubscriptionInfo
      return const SubscriptionInfo();
    }
  }
}