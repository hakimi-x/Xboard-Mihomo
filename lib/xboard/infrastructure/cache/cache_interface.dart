/// 缓存接口
///
/// 提供统一的缓存抽象
library;

/// 缓存接口
abstract interface class CacheInterface<K, V> {
  /// 获取缓存值
  V? get(K key);

  /// 设置缓存值
  void set(K key, V value, {Duration? ttl});

  /// 删除缓存
  void remove(K key);

  /// 清空所有缓存
  void clear();

  /// 检查键是否存在
  bool containsKey(K key);

  /// 获取所有键
  Iterable<K> get keys;

  /// 获取缓存大小
  int get size;
}

