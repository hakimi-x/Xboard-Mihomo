import 'package:fl_clash/xboard/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/domain_status_state.dart';
import '../services/domain_status_service.dart';

/// 域名状态服务提供者
final domainStatusServiceProvider = Provider<DomainStatusService>((ref) {
  return DomainStatusService();
});

/// 域名状态提供者
final domainStatusProvider = StateNotifierProvider<DomainStatusNotifier, DomainStatusState>((ref) {
  final service = ref.watch(domainStatusServiceProvider);
  return DomainStatusNotifier(service: service);
});

/// 域名就绪状态提供者
final domainReadyProvider = Provider<bool>((ref) {
  final domainStatus = ref.watch(domainStatusProvider);
  return domainStatus.isReady;
});

/// 当前域名提供者
final currentDomainProvider = Provider<String?>((ref) {
  final domainStatus = ref.watch(domainStatusProvider);
  return domainStatus.currentDomain;
});

/// 域名状态通知器
class DomainStatusNotifier extends StateNotifier<DomainStatusState> {
  final DomainStatusService _service;

  DomainStatusNotifier({
    required DomainStatusService service,
  }) : _service = service,
       super(const DomainStatusState()) {
    _initialize();
  }

  /// 初始化
  Future<void> _initialize() async {
    try {
      await _service.initialize();
      state = state.copyWith(isInitialized: true);
      XBoardLogger.info('初始化完成');
    } catch (e) {
      XBoardLogger.error('初始化失败', e);
      state = state.copyWith(
        status: DomainStatus.failed,
        errorMessage: '域名服务初始化失败: $e',
        isInitialized: true,
      );
    }
  }

  /// 检查域名状态
  Future<void> checkDomain() async {
    if (!state.isInitialized) {
      await _initialize();
    }

    state = state.copyWith(
      status: DomainStatus.checking,
      errorMessage: null,
    );

    try {
      XBoardLogger.info('开始检查域名');
      
      final result = await _service.checkDomainStatus();
      
      if (!mounted) return;

      if (result['success'] == true) {
        state = state.copyWith(
          status: DomainStatus.success,
          currentDomain: result['domain'] as String?,
          latency: result['latency'] as int?,
          availableDomains: (result['availableDomains'] as List<dynamic>?)
              ?.map((e) => e.toString()).toList() ?? [],
          lastChecked: DateTime.now(),
          errorMessage: null,
        );
        XBoardLogger.info('域名检查成功: ${state.currentDomain}');
      } else {
        state = state.copyWith(
          status: DomainStatus.failed,
          errorMessage: result['message'] as String? ?? '域名检查失败',
          lastChecked: DateTime.now(),
        );
        XBoardLogger.error('域名检查失败: ${state.errorMessage}');
      }
    } catch (e) {
      if (!mounted) return;
      
      XBoardLogger.error('域名检查异常', e);
      state = state.copyWith(
        status: DomainStatus.failed,
        errorMessage: '域名检查异常: $e',
        lastChecked: DateTime.now(),
      );
    }
  }

  /// 刷新域名状态
  Future<void> refresh() async {
    try {
      XBoardLogger.info('刷新域名状态');
      await _service.refreshDomainCache();
      await checkDomain();
    } catch (e) {
      XBoardLogger.error('刷新失败', e);
      if (mounted) {
        state = state.copyWith(
          errorMessage: '刷新失败: $e',
        );
      }
    }
  }

  /// 验证特定域名
  Future<bool> validateDomain(String domain) async {
    try {
      return await _service.validateDomain(domain);
    } catch (e) {
      XBoardLogger.error('域名验证失败', e);
      return false;
    }
  }

  /// 获取统计信息
  Map<String, dynamic> getStatistics() {
    return _service.getStatistics();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}