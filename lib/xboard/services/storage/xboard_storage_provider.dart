/// XBoard Storage Service Provider
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/xboard/infrastructure/infrastructure.dart';
import 'package:fl_clash/xboard/core/core.dart';
import 'xboard_storage_service.dart';

/// Storage 接口 FutureProvider
/// 提供默认的 SharedPreferences 实现
/// 如需自定义实现，可在应用初始化时使用ProviderScope.overrides覆盖此provider
final storageProvider = FutureProvider<StorageInterface>((ref) async {
  return await SharedPrefsStorage.create();
});

/// XBoard Storage Service Provider
final storageServiceProvider = Provider<XBoardStorageService>((ref) {
  final storageAsync = ref.watch(storageProvider);
  // 如果存储还未初始化，使用一个临时的空实现
  final storage = storageAsync.maybeWhen(
    data: (storage) => storage,
    orElse: () => _PlaceholderStorage(),
  );
  return XBoardStorageService(storage);
});

/// 占位符存储实现，用于存储未初始化时的临时使用
class _PlaceholderStorage implements StorageInterface {
  @override
  Future<Result<String?>> getString(String key) async => Result.success(null);
  
  @override
  Future<Result<bool>> setString(String key, String value) async => Result.success(false);
  
  @override
  Future<Result<int?>> getInt(String key) async => Result.success(null);
  
  @override
  Future<Result<bool>> setInt(String key, int value) async => Result.success(false);
  
  @override
  Future<Result<bool?>> getBool(String key) async => Result.success(null);
  
  @override
  Future<Result<bool>> setBool(String key, bool value) async => Result.success(false);
  
  @override
  Future<Result<double?>> getDouble(String key) async => Result.success(null);
  
  @override
  Future<Result<bool>> setDouble(String key, double value) async => Result.success(false);
  
  @override
  Future<Result<List<String>?>> getStringList(String key) async => Result.success(null);
  
  @override
  Future<Result<bool>> setStringList(String key, List<String> value) async => Result.success(false);
  
  @override
  Future<Result<bool>> remove(String key) async => Result.success(false);
  
  @override
  Future<Result<bool>> clear() async => Result.success(false);
  
  @override
  Future<Result<bool>> containsKey(String key) async => Result.success(false);
  
  @override
  Future<Result<Set<String>>> getKeys() async => Result.success({});
}

