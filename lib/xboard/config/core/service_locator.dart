/// 服务工厂函数类型
typedef ServiceFactory<T> = T Function();

/// 简单的服务定位器
/// 
/// 提供基础的依赖注入功能
class ServiceLocator {
  static final Map<Type, dynamic> _services = {};
  static final Map<Type, ServiceFactory> _factories = {};
  static bool _isInitialized = false;

  /// 注册单例服务
  static void registerSingleton<T>(T service) {
    _services[T] = service;
  }

  /// 注册工厂服务
  static void registerFactory<T>(ServiceFactory<T> factory) {
    _factories[T] = factory;
  }

  /// 注册懒加载单例
  static void registerLazySingleton<T>(ServiceFactory<T> factory) {
    _factories[T] = () {
      final service = factory();
      _services[T] = service;
      _factories.remove(T);
      return service;
    };
  }

  /// 获取服务
  static T get<T>() {
    // 首先检查单例服务
    if (_services.containsKey(T)) {
      return _services[T] as T;
    }

    // 然后检查工厂服务
    if (_factories.containsKey(T)) {
      final factory = _factories[T] as ServiceFactory<T>;
      return factory();
    }

    throw Exception('Service of type $T is not registered');
  }

  /// 检查服务是否已注册
  static bool isRegistered<T>() {
    return _services.containsKey(T) || _factories.containsKey(T);
  }

  /// 移除服务
  static void unregister<T>() {
    _services.remove(T);
    _factories.remove(T);
  }

  /// 清空所有服务
  static void reset() {
    _services.clear();
    _factories.clear();
    _isInitialized = false;
  }

  /// 获取所有已注册的服务类型
  static List<Type> getRegisteredTypes() {
    final types = <Type>[];
    types.addAll(_services.keys);
    types.addAll(_factories.keys);
    return types;
  }

  /// 标记为已初始化
  static void markInitialized() {
    _isInitialized = true;
  }

  /// 检查是否已初始化
  static bool get isInitialized => _isInitialized;

  /// 获取服务统计信息
  static Map<String, dynamic> getStats() {
    return {
      'singletons': _services.length,
      'factories': _factories.length,
      'total': _services.length + _factories.length,
      'initialized': _isInitialized,
      'types': getRegisteredTypes().map((t) => t.toString()).toList(),
    };
  }
}