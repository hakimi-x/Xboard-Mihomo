/// 存储接口 - 提供统一的存储抽象
///
/// 用于解耦具体的存储实现，便于测试和替换
///
/// 使用示例：
/// ```dart
/// class MyStorage implements StorageInterface {
///   @override
///   Future<Result<String?>> getString(String key) async {
///     // 具体实现
///   }
/// }
/// ```
library;

import 'package:fl_clash/xboard/core/core.dart';

/// 存储接口
abstract interface class StorageInterface {
  /// 获取字符串值
  Future<Result<String?>> getString(String key);

  /// 保存字符串值
  Future<Result<bool>> setString(String key, String value);

  /// 获取整数值
  Future<Result<int?>> getInt(String key);

  /// 保存整数值
  Future<Result<bool>> setInt(String key, int value);

  /// 获取布尔值
  Future<Result<bool?>> getBool(String key);

  /// 保存布尔值
  Future<Result<bool>> setBool(String key, bool value);

  /// 获取 double 值
  Future<Result<double?>> getDouble(String key);

  /// 保存 double 值
  Future<Result<bool>> setDouble(String key, double value);

  /// 获取字符串列表
  Future<Result<List<String>?>> getStringList(String key);

  /// 保存字符串列表
  Future<Result<bool>> setStringList(String key, List<String> value);

  /// 删除指定键
  Future<Result<bool>> remove(String key);

  /// 清空所有数据
  Future<Result<bool>> clear();

  /// 检查键是否存在
  Future<Result<bool>> containsKey(String key);

  /// 获取所有键
  Future<Result<Set<String>>> getKeys();
}

