import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/profile/profile.dart';
import 'package:fl_clash/xboard/features/profile/services/profile_import_service.dart';
class ProfileImportNotifier extends StateNotifier<ImportState> {
  final Ref _ref;
  
  ProfileImportNotifier(this._ref) : super(const ImportState());
  
  Future<bool> importSubscription(String url, {bool forceRefresh = false}) async {
    commonPrint.log('ProfileImport: 开始导入订阅: $url, forceRefresh: $forceRefresh');
    
    state = state.copyWith(
      status: ImportStatus.downloading,
      isImporting: true,
      progress: 0.0,
      message: '开始导入订阅',
      currentUrl: url,
    );
    
    try {
      // 使用实际的导入服务
      final importService = _ref.read(xboardProfileImportServiceProvider);
      
      final result = await importService.importSubscription(
        url,
        onProgress: (status, progress, message) {
          state = state.copyWith(
            status: status,
            progress: progress,
            message: message,
          );
        },
      );
        
      state = state.copyWith(
        status: result.isSuccess ? ImportStatus.success : ImportStatus.failed,
        isImporting: false,
        progress: result.isSuccess ? 1.0 : 0.0,
        message: result.isSuccess ? '导入成功' : result.errorMessage ?? '导入失败',
        lastSuccessTime: result.isSuccess ? DateTime.now() : null,
        lastResult: result,
      );
      
      return result.isSuccess;
    } catch (e) {
      state = state.copyWith(
        status: ImportStatus.failed,
        isImporting: false,
        progress: 0.0,
        message: '导入失败: $e',
      );
      return false;
    }
  }
  Future<bool> retryLastImport() async {
    final url = state.currentUrl;
    if (url == null || url.isEmpty) {
      commonPrint.log('ProfileImport: 没有可重试的导入URL');
      return false;
    }
    commonPrint.log('ProfileImport: 重试导入: $url');
    return await importSubscription(url);
  }
  void cancelImport() {
    if (state.isImporting) {
      state = state.copyWith(
        status: ImportStatus.idle,
        isImporting: false,
        message: '导入已取消',
      );
    }
    commonPrint.log('ProfileImport: 请求取消导入操作');
  }
  void clearState() {
    state = const ImportState();
    commonPrint.log('ProfileImport: 请求清除导入状态');
  }
  void clearError() {
    if (state.lastResult?.isSuccess == false) {
      state = state.copyWith(
        status: ImportStatus.idle,
        message: null,
        lastResult: null,
      );
    }
  }
  bool get hasError => state.lastResult?.isSuccess == false;
  String? get errorMessage => state.lastResult?.errorMessage;
  ImportErrorType? get errorType => state.lastResult?.errorType;
  bool get canRetry => hasError && state.currentUrl?.isNotEmpty == true;
}
final profileImportProvider = StateNotifierProvider<ProfileImportNotifier, ImportState>((ref) {
  return ProfileImportNotifier(ref);
});
extension ProfileImportProviderExtension on WidgetRef {
  ImportState get importState => watch(profileImportProvider);
  ProfileImportNotifier get importNotifier => read(profileImportProvider.notifier);
  bool get isImporting => watch(profileImportProvider.select((state) => state.isImporting));
  double get importProgress => watch(profileImportProvider.select((state) => state.progress));
  String get importStatusText => watch(profileImportProvider.select((state) => state.statusText));
  bool get hasImportError => watch(profileImportProvider.select((state) => state.lastResult?.isSuccess == false));
} 