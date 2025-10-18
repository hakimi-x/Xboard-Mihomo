/// 内存缓存实现
library;

import 'cache_interface.dart';

/// 缓存条目
class _CacheEntry<V> {
  final V value;
  final DateTime createdAt;
  final Duration? ttl;

  _CacheEntry(this.value, {this.ttl}) : createdAt = DateTime.now();

  /// 是否已过期
  bool get isExpired {
    if (ttl == null) return false;
    return DateTime.now().difference(createdAt) > ttl!;
  }
}

/// 内存缓存实现
class MemoryCache<K, V> implements CacheInterface<K, V> {
  final Map<K, _CacheEntry<V>> _cache = {};
  final int? maxSize;

  MemoryCache({this.maxSize});

  @override
  V? get(K key) {
    final entry = _cache[key];
    if (entry == null) return null;

    // 检查是否过期
    if (entry.isExpired) {
      _cache.remove(key);
      return null;
    }

    return entry.value;
  }

  @override
  void set(K key, V value, {Duration? ttl}) {
    // 如果达到最大容量，移除最旧的条目
    if (maxSize != null && _cache.length >= maxSize! && !_cache.containsKey(key)) {
      final oldestKey = _cache.keys.first;
      _cache.remove(oldestKey);
    }

    _cache[key] = _CacheEntry(value, ttl: ttl);
  }

  @override
  void remove(K key) {
    _cache.remove(key);
  }

  @override
  void clear() {
    _cache.clear();
  }

  @override
  bool containsKey(K key) {
    final entry = _cache[key];
    if (entry == null) return false;

    // 检查是否过期
    if (entry.isExpired) {
      _cache.remove(key);
      return false;
    }

    return true;
  }

  @override
  Iterable<K> get keys => _cache.keys;

  @override
  int get size => _cache.length;

  /// 清理所有过期的条目
  void cleanExpired() {
    final expiredKeys = _cache.entries
        .where((entry) => entry.value.isExpired)
        .map((entry) => entry.key)
        .toList();

    for (final key in expiredKeys) {
      _cache.remove(key);
    }
  }
}

