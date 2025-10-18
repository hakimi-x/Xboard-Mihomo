import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/auth/auth.dart';
import 'package:fl_clash/xboard/services/services.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
import 'package:fl_clash/xboard/features/profile/providers/profile_import_provider.dart';
final userInfoProvider = StateProvider<UserInfoData?>((ref) => null);
final subscriptionInfoProvider = StateProvider<SubscriptionData?>((ref) => null);
final userUIStateProvider = StateProvider<UIState>((ref) => const UIState());
class XBoardUserAuthNotifier extends Notifier<UserAuthState> {
  late final XBoardStorageService _storageService;
  
  @override
  UserAuthState build() {
    _storageService = ref.read(storageServiceProvider);
    return const UserAuthState();
  }
  Future<bool> quickAuth() async {
    try {
      commonPrint.log('快速认证检查：检查域名服务登录状态...');
      final hasToken = await XBoardSDK.isLoggedIn()
          .timeout(const Duration(seconds: 5), onTimeout: () {
        commonPrint.log('快速认证超时，假设无token');
        return false;
      });
      
      if (hasToken) {
        String? email;
        UserInfoData? userInfo;
        SubscriptionData? subscriptionInfo;
        try {
          final emailResult = await _storageService.getUserEmail()
              .timeout(const Duration(seconds: 2));
          email = emailResult.dataOrNull;
          
          final userInfoResult = await _storageService.getUserInfo()
              .timeout(const Duration(seconds: 2));
          userInfo = userInfoResult.dataOrNull;
          
          final subscriptionInfoResult = await _storageService.getSubscriptionInfo()
              .timeout(const Duration(seconds: 2));
          subscriptionInfo = subscriptionInfoResult.dataOrNull;
        } catch (e) {
          commonPrint.log('获取缓存数据失败，但继续进行认证: $e');
        }
        
        state = state.copyWith(
          isAuthenticated: true,
          isInitialized: true,
          email: email,
        );
        
        if (userInfo != null) {
          ref.read(userInfoProvider.notifier).state = userInfo;
        }
        if (subscriptionInfo != null) {
          ref.read(subscriptionInfoProvider.notifier).state = subscriptionInfo;
        }
        
        commonPrint.log('快速认证成功：已有token，直接进入主界面. isInitialized: ${state.isInitialized}');
        _backgroundTokenValidation();
        
        // 启动时自动导入订阅
        if (subscriptionInfo?.subscribeUrl?.isNotEmpty == true) {
          commonPrint.log('启动时自动导入订阅: ${subscriptionInfo!.subscribeUrl}');
          ref.read(profileImportProvider.notifier).importSubscription(subscriptionInfo.subscribeUrl!);
        }
        
        return true;
      } else {
        commonPrint.log('快速认证：无本地token，显示登录页面. isInitialized: ${state.isInitialized}');
        state = state.copyWith(isInitialized: true);
        return false;
      }
    } catch (e) {
      commonPrint.log('快速认证失败: $e');
      state = state.copyWith(isInitialized: true);
      commonPrint.log('快速认证失败: $e. isInitialized: ${state.isInitialized}');
      return false;
    } finally {
      if (!state.isInitialized) {
        commonPrint.log('强制设置初始化状态为true. isInitialized: ${state.isInitialized}');
        state = state.copyWith(isInitialized: true);
      }
    }
  }
  void _backgroundTokenValidation() {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      try {
        commonPrint.log('后台验证token有效性...');
        final isValid = await XBoardSDK.isLoggedIn();
        if (!isValid) {
          commonPrint.log('Token验证失败，显示登录过期提示');
          _showTokenExpiredDialog();
        } else {
          commonPrint.log('Token验证成功，静默更新用户数据');
          _silentUpdateUserData();
        }
      } catch (e) {
        commonPrint.log('后台token验证异常: $e');
      }
    });
  }
  Future<void> _silentUpdateUserData() async {
    try {
      // 使用域名服务获取订阅信息
      final subscriptionData = await XBoardSDK.getSubscription();

      try {
        // 使用域名服务获取用户信息
        final userInfoData = await XBoardSDK.getUserInfo();
        if (userInfoData != null) {
          await _storageService.saveUserInfo(userInfoData);
          ref.read(userInfoProvider.notifier).state = userInfoData;
        }
      } catch (e) {
        commonPrint.log('静默更新用户信息失败: $e');
      }

      if (subscriptionData != null) {
        await _storageService.saveSubscriptionInfo(subscriptionData);
        ref.read(subscriptionInfoProvider.notifier).state = subscriptionData;

        if (subscriptionData.subscribeUrl?.isNotEmpty == true) {
          ref.read(profileImportProvider.notifier).importSubscription(subscriptionData.subscribeUrl!);
        }
      }

      commonPrint.log('静默更新用户数据完成');
    } catch (e) {
      commonPrint.log('静默更新用户数据失败: $e');
    }
  }
  void _showTokenExpiredDialog() {
    state = state.copyWith(
      errorMessage: 'TOKEN_EXPIRED', // 特殊标记，UI层检测到后显示对话框
    );
  }
  void clearTokenExpiredError() {
    if (state.errorMessage == 'TOKEN_EXPIRED') {
      state = state.copyWith(errorMessage: null);
    }
  }
  Future<void> handleTokenExpired() async {
    commonPrint.log('处理token过期，清除认证状态');
    await XBoardSDK.logout();
    state = const UserAuthState(isInitialized: true);
  }
  Future<bool> autoAuth() async {
    return await quickAuth();
  }
  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      commonPrint.log('开始登录: $email');
      final success = await XBoardSDK.login(email: email, password: password);
      if (success) {
        commonPrint.log('登录成功，authData token已保存到TokenManager，立即获取用户信息');
        await _storageService.saveUserEmail(email);
        
        // 立即获取用户信息和订阅信息
        try {
          commonPrint.log('开始获取用户信息...');
          final userInfo = await XBoardSDK.getUserInfo();
          commonPrint.log('用户信息API调用完成: ${userInfo != null}');
          if (userInfo != null) {
            ref.read(userInfoProvider.notifier).state = userInfo;
            await _storageService.saveUserInfo(userInfo);
            commonPrint.log('用户信息已保存: ${userInfo.email}');
          } else {
            commonPrint.log('警告: getUserInfo返回null');
          }
          
          commonPrint.log('开始获取订阅信息...');
          final subscriptionInfo = await XBoardSDK.getSubscription();
          commonPrint.log('订阅信息API调用完成: ${subscriptionInfo != null}');
          if (subscriptionInfo != null) {
            ref.read(subscriptionInfoProvider.notifier).state = subscriptionInfo;
            await _storageService.saveSubscriptionInfo(subscriptionInfo);
            commonPrint.log('订阅信息已保存，subscribeUrl: ${subscriptionInfo.subscribeUrl}');
            
            // 如果订阅信息包含token，也保存它（用于订阅链接）
            if (subscriptionInfo.token != null) {
              commonPrint.log('保存订阅token用于订阅链接: ${subscriptionInfo.token?.substring(0, 10)}...');
            }
          } else {
            commonPrint.log('警告: getSubscription返回null');
          }
        } catch (e, stackTrace) {
          commonPrint.log('获取用户/订阅信息失败，但继续登录: $e');
          commonPrint.log('错误堆栈: $stackTrace');
        }
        
        commonPrint.log('准备更新状态...');
        final newState = state.copyWith(
          isAuthenticated: true,
          isInitialized: true,
          email: email,
          isLoading: false,
        );
        state = newState;
        commonPrint.log('===== 认证状态已更新! =====');
        commonPrint.log('isAuthenticated: ${state.isAuthenticated}');
        commonPrint.log('isInitialized: ${state.isInitialized}');
        commonPrint.log('email: ${state.email}');
        commonPrint.log('===========================');
        
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '登录失败',
        );
        return false;
      }
    } catch (e) {
      commonPrint.log('登录出错: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  Future<bool> register(String email, String password, String? inviteCode, String emailCode) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      commonPrint.log('开始注册: $email');
      final result = await XBoardSDK.register(
        email: email,
        password: password,
        inviteCode: inviteCode,
        emailCode: emailCode,
      );
      final success = result != null;
      if (success) {
        commonPrint.log('注册成功');
        await _storageService.saveUserEmail(email);
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '注册失败',
        );
        return false;
      }
    } catch (e) {
      commonPrint.log('注册出错: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  Future<bool> sendVerificationCode(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      commonPrint.log('发送验证码到: $email');
      // 域名服务暂时不支持发送验证码功能
      throw UnimplementedError('发送验证码功能暂时不可用');
    } catch (e) {
      commonPrint.log('发送验证码出错: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  Future<bool> resetPassword(String email, String password, String emailCode) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      commonPrint.log('重置密码: $email');
      // 使用域名服务的简化重置密码功能，只需要邮箱
      final result = await XBoardSDK.resetPassword(email: email, password: password, emailCode: emailCode);
      final success = result;
      if (success) {
        commonPrint.log('密码重置邮件发送成功');
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '密码重置失败',
        );
        return false;
      }
    } catch (e) {
      commonPrint.log('重置密码出错: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  Future<void> refreshSubscriptionInfoAfterPayment() async {
    if (!state.isAuthenticated) {
      return;
    }
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      commonPrint.log('刷新订阅信息...');
      final subscriptionData = await XBoardSDK.getSubscription();
      UserInfoData? userInfo;
      try {
        userInfo = await XBoardSDK.getUserInfo();
        if (userInfo != null) {
          await _storageService.saveUserInfo(userInfo);
          ref.read(userInfoProvider.notifier).state = userInfo;
        }
      } catch (e) {
        commonPrint.log('获取用户详细信息失败: $e');
      }

      if (subscriptionData != null) {
        await _storageService.saveSubscriptionInfo(subscriptionData);
        ref.read(subscriptionInfoProvider.notifier).state = subscriptionData;
      }

      state = state.copyWith(
        userInfo: userInfo,
        subscriptionInfo: subscriptionData,
        isLoading: false,
      );
      commonPrint.log('订阅信息已刷新');

      if (subscriptionData?.subscribeUrl?.isNotEmpty == true) {
        commonPrint.log('[支付成功] 开始重新导入订阅配置: ${subscriptionData!.subscribeUrl}');
        commonPrint.log('[支付成功] 使用强制刷新模式，跳过重复检测');
        ref.read(profileImportProvider.notifier).importSubscription(
          subscriptionData.subscribeUrl!,
          forceRefresh: true,
        );
      } else {
        commonPrint.log('[支付成功] 订阅链接为空，跳过重新导入');
      }
    } catch (e) {
      commonPrint.log('刷新订阅信息出错: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refreshSubscriptionInfo() async {
    if (!state.isAuthenticated) {
      return;
    }
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      commonPrint.log('刷新订阅信息...');
      final subscriptionData = await XBoardSDK.getSubscription();
      UserInfoData? userInfo;
      try {
        userInfo = await XBoardSDK.getUserInfo();
        if (userInfo != null) {
          await _storageService.saveUserInfo(userInfo);
          ref.read(userInfoProvider.notifier).state = userInfo;
        }
      } catch (e) {
        commonPrint.log('获取用户详细信息失败: $e');
      }

      if (subscriptionData != null) {
        await _storageService.saveSubscriptionInfo(subscriptionData);
        ref.read(subscriptionInfoProvider.notifier).state = subscriptionData;
      }

      state = state.copyWith(
        userInfo: userInfo,
        subscriptionInfo: subscriptionData,
        isLoading: false,
      );
      commonPrint.log('订阅信息已刷新');

      // 触发订阅导入流程（下载、解密、导入配置）
      if (subscriptionData?.subscribeUrl?.isNotEmpty == true) {
        commonPrint.log('[手动刷新] 开始导入订阅配置: ${subscriptionData!.subscribeUrl}');
        commonPrint.log('[手动刷新] 使用强制刷新模式，跳过重复检测');
        ref.read(profileImportProvider.notifier).importSubscription(
          subscriptionData.subscribeUrl!,
          forceRefresh: true,
        );
      } else {
        commonPrint.log('[手动刷新] 订阅链接为空，跳过导入');
      }
    } catch (e) {
      commonPrint.log('刷新订阅信息出错: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
  Future<void> refreshUserInfo() async {
    if (!state.isAuthenticated) {
      return;
    }
    try {
      commonPrint.log('刷新用户详细信息...');
      final userInfoData = await XBoardSDK.getUserInfo();
      if (userInfoData != null) {
        await _storageService.saveUserInfo(userInfoData);
        ref.read(userInfoProvider.notifier).state = userInfoData;
        state = state.copyWith(userInfo: userInfoData);
        commonPrint.log('用户详细信息已刷新');
      }
    } catch (e) {
      commonPrint.log('刷新用户详细信息出错: $e');
    }
  }
  Future<void> logout() async {
    commonPrint.log('用户登出');
    await XBoardSDK.logout();
    await _storageService.clearAuthData();
    state = const UserAuthState(
      isInitialized: true, // 登出后保持初始化状态，只重置认证信息
    );
  }
  String? get currentAuthToken => null; // Token管理已委托给域名服务
  bool get isAuthenticated => state.isAuthenticated;
  String? get currentEmail => state.email;
}
final xboardUserAuthProvider = NotifierProvider<XBoardUserAuthNotifier, UserAuthState>(
  XBoardUserAuthNotifier.new,
);
final xboardUserProvider = xboardUserAuthProvider;
extension UserInfoHelpers on WidgetRef {
  UserInfoData? get userInfo => read(userInfoProvider);
  SubscriptionData? get subscriptionInfo => read(subscriptionInfoProvider);
  UserAuthState get userAuthState => read(xboardUserAuthProvider);
  bool get isAuthenticated => read(xboardUserAuthProvider).isAuthenticated;
} 