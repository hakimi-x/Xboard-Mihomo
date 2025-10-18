import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';

/// 通用UI状态
class UIState {
  final bool isLoading;
  final String? errorMessage;
  final DateTime? lastUpdated;

  const UIState({
    this.isLoading = false,
    this.errorMessage,
    this.lastUpdated,
  });

  UIState copyWith({
    bool? isLoading,
    String? errorMessage,
    DateTime? lastUpdated,
  }) {
    return UIState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  UIState clearError() {
    return copyWith(errorMessage: null);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UIState &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        errorMessage.hashCode ^
        lastUpdated.hashCode;
  }
}

/// 用户认证状态
class UserAuthState {
  final bool isAuthenticated;
  final bool isInitialized;
  final String? email;
  final bool isLoading;
  final String? errorMessage;
  final UserInfoData? userInfo;
  final SubscriptionData? subscriptionInfo;

  const UserAuthState({
    this.isAuthenticated = false,
    this.isInitialized = false,
    this.email,
    this.isLoading = false,
    this.errorMessage,
    this.userInfo,
    this.subscriptionInfo,
  });

  UserAuthState copyWith({
    bool? isAuthenticated,
    bool? isInitialized,
    String? email,
    bool? isLoading,
    String? errorMessage,
    UserInfoData? userInfo,
    SubscriptionData? subscriptionInfo,
  }) {
    return UserAuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isInitialized: isInitialized ?? this.isInitialized,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userInfo: userInfo ?? this.userInfo,
      subscriptionInfo: subscriptionInfo ?? this.subscriptionInfo,
    );
  }

  UserAuthState clearError() {
    return copyWith(errorMessage: null);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserAuthState &&
        other.isAuthenticated == isAuthenticated &&
        other.isInitialized == isInitialized &&
        other.email == email &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage &&
        other.userInfo == userInfo &&
        other.subscriptionInfo == subscriptionInfo;
  }

  @override
  int get hashCode {
    return isAuthenticated.hashCode ^
        isInitialized.hashCode ^
        email.hashCode ^
        isLoading.hashCode ^
        errorMessage.hashCode ^
        userInfo.hashCode ^
        subscriptionInfo.hashCode;
  }
}

