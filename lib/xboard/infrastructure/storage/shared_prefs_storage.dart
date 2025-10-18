/// SharedPreferences 存储实现
library;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_clash/xboard/core/core.dart';
import 'storage_interface.dart';

/// SharedPreferences 存储实现
class SharedPrefsStorage implements StorageInterface {
  final SharedPreferences _prefs;

  SharedPrefsStorage(this._prefs);

  /// 创建存储实例
  static Future<SharedPrefsStorage> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsStorage(prefs);
  }

  @override
  Future<Result<String?>> getString(String key) async {
    try {
      final value = _prefs.getString(key);
      return Result.success(value);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '读取字符串失败',
        operation: 'read',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<bool>> setString(String key, String value) async {
    try {
      final success = await _prefs.setString(key, value);
      return Result.success(success);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '保存字符串失败',
        operation: 'write',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<int?>> getInt(String key) async {
    try {
      final value = _prefs.getInt(key);
      return Result.success(value);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '读取整数失败',
        operation: 'read',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<bool>> setInt(String key, int value) async {
    try {
      final success = await _prefs.setInt(key, value);
      return Result.success(success);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '保存整数失败',
        operation: 'write',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<bool?>> getBool(String key) async {
    try {
      final value = _prefs.getBool(key);
      return Result.success(value);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '读取布尔值失败',
        operation: 'read',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<bool>> setBool(String key, bool value) async {
    try {
      final success = await _prefs.setBool(key, value);
      return Result.success(success);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '保存布尔值失败',
        operation: 'write',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<double?>> getDouble(String key) async {
    try {
      final value = _prefs.getDouble(key);
      return Result.success(value);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '读取 double 失败',
        operation: 'read',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<bool>> setDouble(String key, double value) async {
    try {
      final success = await _prefs.setDouble(key, value);
      return Result.success(success);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '保存 double 失败',
        operation: 'write',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<List<String>?>> getStringList(String key) async {
    try {
      final value = _prefs.getStringList(key);
      return Result.success(value);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '读取字符串列表失败',
        operation: 'read',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<bool>> setStringList(String key, List<String> value) async {
    try {
      final success = await _prefs.setStringList(key, value);
      return Result.success(success);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '保存字符串列表失败',
        operation: 'write',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<bool>> remove(String key) async {
    try {
      final success = await _prefs.remove(key);
      return Result.success(success);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '删除键失败',
        operation: 'delete',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<bool>> clear() async {
    try {
      final success = await _prefs.clear();
      return Result.success(success);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '清空存储失败',
        operation: 'clear',
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<bool>> containsKey(String key) async {
    try {
      final contains = _prefs.containsKey(key);
      return Result.success(contains);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '检查键失败',
        operation: 'contains',
        key: key,
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Result<Set<String>>> getKeys() async {
    try {
      final keys = _prefs.getKeys();
      return Result.success(keys);
    } catch (e, stackTrace) {
      return Result.failure(XBoardStorageException(
        message: '获取所有键失败',
        operation: 'getKeys',
        originalError: e,
        stackTrace: stackTrace,
      ));
    }
  }
}

