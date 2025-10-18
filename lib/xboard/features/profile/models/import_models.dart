import 'package:fl_clash/models/models.dart';
enum ImportStatus {
  idle,        // 空闲状态
  cleaning,    // 清理旧配置
  downloading, // 下载配置
  validating,  // 验证配置
  adding,      // 添加配置
  success,     // 成功完成
  failed,      // 导入失败
}
enum ImportErrorType {
  networkError,     // 网络错误
  downloadError,    // 下载失败
  validationError,  // 配置验证失败
  storageError,     // 存储错误
  unknownError,     // 未知错误
}
class ImportResult {
  final bool isSuccess;
  final String? errorMessage;
  final ImportErrorType? errorType;
  final Profile? profile;
  final Duration? duration;
  const ImportResult({
    required this.isSuccess,
    this.errorMessage,
    this.errorType,
    this.profile,
    this.duration,
  });
  factory ImportResult.success({
    Profile? profile,
    Duration? duration,
  }) {
    return ImportResult(
      isSuccess: true,
      profile: profile,
      duration: duration,
    );
  }
  factory ImportResult.failure({
    required String errorMessage,
    required ImportErrorType errorType,
    Duration? duration,
  }) {
    return ImportResult(
      isSuccess: false,
      errorMessage: errorMessage,
      errorType: errorType,
      duration: duration,
    );
  }
}
class ImportState {
  final ImportStatus status;
  final String? message;
  final double progress; // 0.0 - 1.0
  final String? currentUrl;
  final ImportResult? lastResult;
  final bool isImporting;
  final DateTime? lastSuccessTime; // 最后成功导入的时间
  const ImportState({
    this.status = ImportStatus.idle,
    this.message,
    this.progress = 0.0,
    this.currentUrl,
    this.lastResult,
    this.isImporting = false,
    this.lastSuccessTime,
  });
  ImportState copyWith({
    ImportStatus? status,
    String? message,
    double? progress,
    String? currentUrl,
    ImportResult? lastResult,
    bool? isImporting,
    DateTime? lastSuccessTime,
  }) {
    return ImportState(
      status: status ?? this.status,
      message: message ?? this.message,
      progress: progress ?? this.progress,
      currentUrl: currentUrl ?? this.currentUrl,
      lastResult: lastResult ?? this.lastResult,
      isImporting: isImporting ?? this.isImporting,
      lastSuccessTime: lastSuccessTime ?? this.lastSuccessTime,
    );
  }
  String get statusText {
    switch (status) {
      case ImportStatus.idle:
        return '准备导入';
      case ImportStatus.cleaning:
        return '清理旧配置';
      case ImportStatus.downloading:
        return '下载配置文件';
      case ImportStatus.validating:
        return '验证配置格式';
      case ImportStatus.adding:
        return '添加到配置列表';
      case ImportStatus.success:
        return '导入成功';
      case ImportStatus.failed:
        return '导入失败';
    }
  }
  String? get errorTypeMessage {
    if (lastResult?.errorType == null) return null;
    switch (lastResult!.errorType!) {
      case ImportErrorType.networkError:
        return '网络连接失败，请检查网络设置';
      case ImportErrorType.downloadError:
        return '配置文件下载失败，请检查订阅链接';
      case ImportErrorType.validationError:
        return '配置文件格式错误，请联系服务提供商';
      case ImportErrorType.storageError:
        return '保存配置失败，请检查存储空间';
      case ImportErrorType.unknownError:
        return '未知错误，请重试';
    }
  }
} 