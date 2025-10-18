/// XBoard 数据存储服务
///
/// 提供XBoard相关数据的存储和读取
library;

import 'dart:convert';
import 'package:fl_clash/xboard/core/core.dart';
import 'package:fl_clash/xboard/infrastructure/infrastructure.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';

/// XBoard 存储服务
///
/// 负责存储和读取XBoard相关数据，如用户信息、订阅信息等
class XBoardStorageService {
  final StorageInterface _storage;
  
  XBoardStorageService(this._storage);

  // 存储键定义
  static const String _userEmailKey = 'xboard_user_email';
  static const String _userInfoKey = 'xboard_user_info';
  static const String _subscriptionInfoKey = 'xboard_subscription_info';
  static const String _tunFirstUseKey = 'xboard_tun_first_use_shown';
  static const String _savedEmailKey = 'xboard_saved_email';
  static const String _savedPasswordKey = 'xboard_saved_password';
  static const String _rememberPasswordKey = 'xboard_remember_password';

  // ===== 用户邮箱 =====

  Future<Result<bool>> saveUserEmail(String email) async {
    return await _storage.setString(_userEmailKey, email);
  }

  Future<Result<String?>> getUserEmail() async {
    return await _storage.getString(_userEmailKey);
  }

  // ===== 用户信息 =====

  Future<Result<bool>> saveUserInfo(UserInfoData userInfo) async {
    try {
      final userInfoJson = jsonEncode(userInfo.toJson());
      return await _storage.setString(_userInfoKey, userInfoJson);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '保存用户信息失败',
        operation: 'write',
        key: _userInfoKey,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  Future<Result<UserInfoData?>> getUserInfo() async {
    final result = await _storage.getString(_userInfoKey);
    return result.when(
      success: (userInfoJson) {
        if (userInfoJson == null) return Result.success(null);
        try {
          final Map<String, dynamic> userInfoMap = jsonDecode(userInfoJson);
          return Result.success(UserInfoData.fromJson(userInfoMap));
        } catch (e, stackTrace) {
          return Result.failure(XBoardParseException(
            message: '解析用户信息失败',
            dataType: 'UserInfo',
            originalError: e,
            stackTrace: stackTrace,
          ));
        }
      },
      failure: (error) => Result.failure(error),
    );
  }

  // ===== 订阅信息 =====

  Future<Result<bool>> saveSubscriptionInfo(SubscriptionData subscriptionInfo) async {
    try {
      final subscriptionInfoJson = jsonEncode(subscriptionInfo.toJson());
      return await _storage.setString(_subscriptionInfoKey, subscriptionInfoJson);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '保存订阅信息失败',
        operation: 'write',
        key: _subscriptionInfoKey,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  Future<Result<SubscriptionData?>> getSubscriptionInfo() async {
    final result = await _storage.getString(_subscriptionInfoKey);
    return result.when(
      success: (subscriptionInfoJson) {
        if (subscriptionInfoJson == null) return Result.success(null);
        try {
          final Map<String, dynamic> subscriptionInfoMap = jsonDecode(subscriptionInfoJson);
          return Result.success(SubscriptionData.fromJson(subscriptionInfoMap));
        } catch (e, stackTrace) {
          return Result.failure(XBoardParseException(
            message: '解析订阅信息失败',
            dataType: 'SubscriptionInfo',
            originalError: e,
            stackTrace: stackTrace,
          ));
        }
      },
      failure: (error) => Result.failure(error),
    );
  }

  // ===== 认证数据清理 =====

  Future<Result<bool>> clearAuthData() async {
    final results = await Future.wait([
      _storage.remove(_userEmailKey),
      _storage.remove(_userInfoKey),
      _storage.remove(_subscriptionInfoKey),
    ]);
    
    final allSuccess = results.every((r) => r.dataOrNull == true);
    return Result.success(allSuccess);
  }

  // ===== TUN 首次使用标记 =====

  Future<Result<bool>> hasTunFirstUseShown() async {
    final result = await _storage.getBool(_tunFirstUseKey);
    return result.map((value) => value ?? false);
  }

  Future<Result<bool>> markTunFirstUseShown() async {
    return await _storage.setBool(_tunFirstUseKey, true);
  }

  // ===== 登录凭据 =====

  Future<Result<bool>> saveCredentials(
    String email,
    String password,
    bool rememberPassword,
  ) async {
    final results = await Future.wait([
      _storage.setString(_savedEmailKey, email),
      _storage.setString(_savedPasswordKey, rememberPassword ? password : ''),
      _storage.setBool(_rememberPasswordKey, rememberPassword),
    ]);
    
    final allSuccess = results.every((r) => r.dataOrNull == true);
    return Result.success(allSuccess);
  }

  Future<Result<Map<String, dynamic>>> getSavedCredentials() async {
    final emailResult = await _storage.getString(_savedEmailKey);
    final passwordResult = await _storage.getString(_savedPasswordKey);
    final rememberResult = await _storage.getBool(_rememberPasswordKey);
    
    return Result.success({
      'email': emailResult.dataOrNull,
      'password': passwordResult.dataOrNull,
      'rememberPassword': rememberResult.dataOrNull ?? false,
    });
  }

  // 便捷方法：获取单个保存的凭据字段
  Future<String?> getSavedEmail() async {
    final result = await _storage.getString(_savedEmailKey);
    return result.dataOrNull;
  }

  Future<String?> getSavedPassword() async {
    final result = await _storage.getString(_savedPasswordKey);
    return result.dataOrNull;
  }

  Future<bool> getRememberPassword() async {
    final result = await _storage.getBool(_rememberPasswordKey);
    return result.dataOrNull ?? false;
  }

  Future<Result<bool>> clearSavedCredentials() async {
    final results = await Future.wait([
      _storage.remove(_savedEmailKey),
      _storage.remove(_savedPasswordKey),
      _storage.remove(_rememberPasswordKey),
    ]);
    
    final allSuccess = results.every((r) => r.dataOrNull == true);
    return Result.success(allSuccess);
  }
}

