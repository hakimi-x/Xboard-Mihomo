import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';

class InviteState {
  final InviteData? inviteData;
  final List<CommissionDetailData> commissionHistory;
  final UserInfoData? userInfo;
  final bool isLoading;
  final bool isGenerating;
  final bool isLoadingHistory;
  final String? errorMessage;
  final int currentHistoryPage;
  final bool hasMoreHistory;
  final int historyPageSize;

  const InviteState({
    this.inviteData,
    this.commissionHistory = const [],
    this.userInfo,
    this.isLoading = false,
    this.isGenerating = false,
    this.isLoadingHistory = false,
    this.errorMessage,
    this.currentHistoryPage = 1,
    this.hasMoreHistory = true,
    this.historyPageSize = 10,
  });

  InviteState copyWith({
    InviteData? inviteData,
    List<CommissionDetailData>? commissionHistory,
    UserInfoData? userInfo,
    bool? isLoading,
    bool? isGenerating,
    bool? isLoadingHistory,
    String? errorMessage,
    int? currentHistoryPage,
    bool? hasMoreHistory,
    int? historyPageSize,
  }) {
    return InviteState(
      inviteData: inviteData ?? this.inviteData,
      commissionHistory: commissionHistory ?? this.commissionHistory,
      userInfo: userInfo ?? this.userInfo,
      isLoading: isLoading ?? this.isLoading,
      isGenerating: isGenerating ?? this.isGenerating,
      isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
      errorMessage: errorMessage,
      currentHistoryPage: currentHistoryPage ?? this.currentHistoryPage,
      hasMoreHistory: hasMoreHistory ?? this.hasMoreHistory,
      historyPageSize: historyPageSize ?? this.historyPageSize,
    );
  }

  bool get hasInviteData => inviteData != null;
  bool get hasActiveCodes => inviteData?.codes.any((code) => code.isActive) ?? false;
  int get totalInvites => inviteData?.totalInvites ?? 0;
  int get validInvites => inviteData?.validInvites ?? 0;
  int get totalCommission => inviteData?.totalCommission ?? 0;
  int get walletBalance => (userInfo?.balance ?? 0).toInt();
  String get formattedCommission => _formatCommissionAmount(totalCommission);
  String get formattedWalletBalance => _formatCommissionAmount(walletBalance);

  String _formatCommissionAmount(int amount) {
    final value = amount / 100.0;
    if (value >= 1000) {
      return '¥${(value / 1000).toStringAsFixed(1)}k';
    } else {
      return '¥${value.toStringAsFixed(2)}';
    }
  }
}

class InviteNotifier extends Notifier<InviteState> {
  @override
  InviteState build() {
    return const InviteState();
  }

  Future<void> loadInviteData() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      commonPrint.log('加载邀请信息...');
      final inviteData = await XBoardSDK.getInviteInfo();

      state = state.copyWith(
        inviteData: inviteData,
        isLoading: false,
      );

      commonPrint.log('邀请信息加载成功: ${inviteData.toString()}');
    } catch (e) {
      commonPrint.log('加载邀请信息失败: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadCommissionHistory({int page = 1, bool append = false}) async {
    if (state.isLoadingHistory) return;

    state = state.copyWith(isLoadingHistory: true);

    try {
      commonPrint.log('加载佣金历史... 页码: $page');
      final newHistory = await XBoardSDK.getCommissionHistory(
        current: page,
        pageSize: state.historyPageSize,
      );

      List<CommissionDetailData> updatedHistory;
      if (append && newHistory.isNotEmpty) {
        // 追加到现有列表
        updatedHistory = [...state.commissionHistory, ...newHistory];
      } else {
        // 替换整个列表
        updatedHistory = newHistory;
      }

      state = state.copyWith(
        commissionHistory: updatedHistory,
        currentHistoryPage: page,
        hasMoreHistory: newHistory.length >= state.historyPageSize,
        isLoadingHistory: false,
      );

      commonPrint.log('佣金历史加载成功: 第$page页，${newHistory.length} 条记录');
    } catch (e) {
      commonPrint.log('加载佣金历史失败: $e');
      state = state.copyWith(isLoadingHistory: false);
    }
  }
  
  Future<void> loadNextHistoryPage() async {
    if (!state.hasMoreHistory || state.isLoadingHistory) return;
    await loadCommissionHistory(page: state.currentHistoryPage + 1, append: true);
  }
  
  Future<void> refreshCommissionHistory() async {
    await loadCommissionHistory(page: 1, append: false);
  }

  Future<void> loadUserInfo() async {
    try {
      commonPrint.log('加载用户信息...');
      final userInfo = await XBoardSDK.getUserInfo();

      state = state.copyWith(userInfo: userInfo);
      commonPrint.log('用户信息加载成功: 钱包余额 ¥${(userInfo?.balance ?? 0) / 100.0}');
    } catch (e) {
      commonPrint.log('加载用户信息失败: $e');
    }
  }

  Future<InviteCodeData?> generateInviteCode() async {
    if (state.isGenerating) return null;

    state = state.copyWith(isGenerating: true, errorMessage: null);

    try {
      commonPrint.log('生成邀请码...');
      final newCode = await XBoardSDK.generateInviteCode();

      await loadInviteData();

      state = state.copyWith(isGenerating: false);
      commonPrint.log('邀请码生成成功: ${newCode?.code}');
      return newCode;
    } catch (e) {
      commonPrint.log('生成邀请码失败: $e');
      state = state.copyWith(
        isGenerating: false,
        errorMessage: e.toString(),
      );
      return null;
    }
  }

  Future<WithdrawResultData?> withdrawCommission(String amount, String method) async {
    if (state.isLoading) return null;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      commonPrint.log('提现佣金: ¥$amount, 方式: $method');
      final result = await XBoardSDK.withdrawCommission(
        amount: double.tryParse(amount) ?? 0.0,
        withdrawAccount: method,  // method是提现账号
      );

      await loadInviteData();
      await refreshCommissionHistory();

      state = state.copyWith(isLoading: false);
      commonPrint.log('提现申请提交成功');
      return result;
    } catch (e) {
      commonPrint.log('提现申请失败: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return null;
    }
  }

  Future<TransferResultData?> transferCommission(int amount) async {
    if (state.isLoading) return null;
    
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      commonPrint.log('划转佣金到钱包: ¥$amount');
      final result = await XBoardSDK.transferCommissionToBalance(amount.toDouble());
      
      await Future.wait([
        loadInviteData(),
        loadUserInfo(),
      ]);
      
      state = state.copyWith(isLoading: false);
      commonPrint.log('划转成功');
      return result;
    } catch (e) {
      commonPrint.log('划转失败: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return null;
    }
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(errorMessage: null);
    }
  }

  Future<void> refresh() async {
    await Future.wait([
      loadInviteData(),
      refreshCommissionHistory(),
      loadUserInfo(),
    ]);
  }
}

final inviteProvider = NotifierProvider<InviteNotifier, InviteState>(
  InviteNotifier.new,
);

extension InviteHelpers on WidgetRef {
  InviteState get inviteState => read(inviteProvider);
  InviteNotifier get inviteNotifier => read(inviteProvider.notifier);
}