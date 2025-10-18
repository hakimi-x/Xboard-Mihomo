/// 域名状态枚举
enum DomainStatus {
  /// 正在检查域名
  checking,
  /// 域名可用
  success,
  /// 域名不可用
  failed,
}

/// 域名状态数据模型
class DomainStatusState {
  final DomainStatus status;
  final String? currentDomain;
  final String? errorMessage;
  final DateTime? lastChecked;
  final int? latency;
  final List<String> availableDomains;
  final bool isInitialized;

  const DomainStatusState({
    this.status = DomainStatus.checking,
    this.currentDomain,
    this.errorMessage,
    this.lastChecked,
    this.latency,
    this.availableDomains = const [],
    this.isInitialized = false,
  });

  DomainStatusState copyWith({
    DomainStatus? status,
    String? currentDomain,
    String? errorMessage,
    DateTime? lastChecked,
    int? latency,
    List<String>? availableDomains,
    bool? isInitialized,
  }) {
    return DomainStatusState(
      status: status ?? this.status,
      currentDomain: currentDomain ?? this.currentDomain,
      errorMessage: errorMessage ?? this.errorMessage,
      lastChecked: lastChecked ?? this.lastChecked,
      latency: latency ?? this.latency,
      availableDomains: availableDomains ?? this.availableDomains,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  /// 域名是否就绪（可以进行登录等操作）
  bool get isReady => status == DomainStatus.success && currentDomain != null;

  /// 是否有错误
  bool get hasError => errorMessage != null;

  @override
  String toString() {
    return 'DomainStatusState('
        'status: $status, '
        'currentDomain: $currentDomain, '
        'isReady: $isReady, '
        'latency: $latency, '
        'availableDomains: ${availableDomains.length}, '
        'hasError: $hasError'
        ')';
  }
}