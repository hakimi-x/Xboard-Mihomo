import 'service_locator.dart';
import 'config_settings.dart';
import '../fetchers/remote_config_manager.dart';
import '../parsers/configuration_parser.dart';
import '../internal/xboard_config_accessor.dart';
import '../services/online_support_service.dart';
import '../../core/core.dart';

/// 模块初始化器（内部类）
/// 
/// 负责初始化所有模块和依赖注入
/// 注意：这个类不应该被外部直接使用，请使用XBoardConfig
class ModuleInitializer {
  static bool _isInitialized = false;

  /// 初始化模块
  static Future<void> initialize({ConfigSettings? settings}) async {
    if (_isInitialized) {
      ConfigLogger.warning('Module already initialized');
      return;
    }

    final config = settings ?? const ConfigSettings();
    
    try {
      // 验证配置
      if (!config.validate()) {
        final errors = config.getValidationErrors();
        throw Exception('Invalid configuration: ${errors.join(', ')}');
      }

      // 配置日志
      _configureLogger(config.log);

      ConfigLogger.info('Initializing XBoard Config Module V2');
      ConfigLogger.info('Current provider: ${config.currentProvider}');

      // 注册服务
      await _registerServices(config);

      // 标记为已初始化
      ServiceLocator.markInitialized();
      _isInitialized = true;

      ConfigLogger.info('Module initialization completed');
    } catch (e) {
      ConfigLogger.error('Module initialization failed', e);
      rethrow;
    }
  }

  /// 重置模块
  static void reset() {
    ConfigLogger.info('Resetting module');
    ServiceLocator.reset();
    _isInitialized = false;
  }

  /// 检查是否已初始化
  static bool get isInitialized => _isInitialized;

  /// 获取初始化状态
  static Map<String, dynamic> getInitializationStatus() {
    return {
      'initialized': _isInitialized,
      'serviceLocator': ServiceLocator.getStats(),
    };
  }

  /// 配置日志
  static void _configureLogger(LogSettings logSettings) {
    // 注意：新的XBoardLogger不再需要setEnabled和setMinLevel
    // 日志始终启用，通过LoggerInterface控制输出
    // 可以通过XBoardLogger.setLogger()来替换日志实现
    ConfigLogger.debug('Logger配置：${logSettings.level}');
  }

  /// 注册服务
  static Future<void> _registerServices(ConfigSettings config) async {
    ConfigLogger.debug('Registering services');

    // 注册配置设置
    ServiceLocator.registerSingleton<ConfigSettings>(config);

    // 注册远程配置管理器
    ServiceLocator.registerLazySingleton<RemoteConfigManager>(() {
      ConfigLogger.info('Creating RemoteConfigManager with ${config.remoteConfig.sources.length} sources');
      return RemoteConfigManager.fromSettings(config.remoteConfig);
    });

    // 本地配置功能已移除，只使用远程数据

    // 缓存功能已移除，使用实时数据

    // 注册配置解析器
    ServiceLocator.registerLazySingleton<ConfigurationParser>(() {
      return ConfigurationParser();
    });

    // 注册配置访问器
    ServiceLocator.registerLazySingleton<XBoardConfigAccessor>(() {
      return XBoardConfigAccessor(
        remoteManager: ServiceLocator.get<RemoteConfigManager>(),
        parser: ServiceLocator.get<ConfigurationParser>(),
        currentProvider: config.currentProvider,
      );
    });

    // 注册在线客服服务
    ServiceLocator.registerLazySingleton<OnlineSupportService>(() {
      try {
        final accessor = ServiceLocator.get<XBoardConfigAccessor>();
        final configs = accessor.getOnlineSupportConfigs();
        return OnlineSupportService(configs);
      } catch (e) {
        ServiceLogger.warning('Failed to initialize OnlineSupportService, using empty config', e);
        return OnlineSupportService([]);
      }
    });

    ConfigLogger.debug('Services registered successfully');
  }

  /// 预热服务
  static Future<void> warmUp() async {
    if (!_isInitialized) {
      throw StateError('Module not initialized');
    }

    ConfigLogger.info('Warming up services');

    try {
      // 预热配置访问器
      final accessor = ServiceLocator.get<XBoardConfigAccessor>();
      await accessor.refreshConfiguration();

      ConfigLogger.info('Services warmed up successfully');
    } catch (e) {
      ConfigLogger.warning('Service warm-up failed', e);
      // 不抛出异常，允许模块继续工作
    }
  }

  /// 创建配置访问器实例
  static Future<XBoardConfigAccessor> createConfigAccessor({
    ConfigSettings? settings,
    bool autoWarmUp = true,
  }) async {
    await initialize(settings: settings);
    
    final accessor = ServiceLocator.get<XBoardConfigAccessor>();
    
    if (autoWarmUp) {
      await accessor.refreshConfiguration();
    }
    
    return accessor;
  }
}