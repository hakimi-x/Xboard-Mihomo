import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';

/// 配置数据Provider
/// 获取系统配置信息，如邮箱验证、邀请码等设置
final configProvider = FutureProvider<ConfigData?>((ref) async {
  try {
    return await XBoardSDK.getConfig();
  } catch (e) {
    // 如果获取配置失败，返回null，注册页面会使用默认行为
    return null;
  }
});

/// 配置状态Provider  
/// 提供配置的加载状态和错误信息
final configStateProvider = StateNotifierProvider<ConfigStateNotifier, ConfigState>((ref) {
  return ConfigStateNotifier();
});

class ConfigState {
  final ConfigData? data;
  final bool isLoading;
  final String? error;

  const ConfigState({
    this.data,
    this.isLoading = false,
    this.error,
  });

  ConfigState copyWith({
    ConfigData? data,
    bool? isLoading,
    String? error,
  }) {
    return ConfigState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ConfigStateNotifier extends StateNotifier<ConfigState> {
  ConfigStateNotifier() : super(const ConfigState(isLoading: false)) {
    // 自动加载配置
    loadConfig();
  }

  Future<void> loadConfig() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final config = await XBoardSDK.getConfig();
      state = state.copyWith(
        data: config,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refreshConfig() async {
    await loadConfig();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}