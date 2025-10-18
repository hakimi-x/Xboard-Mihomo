/// XBoard 日志模块
///
/// 提供统一的日志接口和默认实现，支持自定义日志实现
library;

export 'logger_interface.dart';
export 'console_logger.dart';
export 'module_loggers.dart';

import 'logger_interface.dart';
import 'console_logger.dart';

/// XBoard 日志管理器
///
/// 提供全局日志实例，支持自定义日志实现
class XBoardLogger {
  static LoggerInterface _instance = ConsoleLogger();

  /// 获取当前日志实例
  static LoggerInterface get instance => _instance;

  /// 设置自定义日志实现
  ///
  /// 允许主应用注入自己的日志实现
  static void setLogger(LoggerInterface logger) {
    _instance = logger;
  }

  /// 重置为默认日志实现
  static void reset() {
    _instance = ConsoleLogger();
  }

  // 便捷方法

  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _instance.debug(message, error, stackTrace);
  }

  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    _instance.info(message, error, stackTrace);
  }

  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _instance.warning(message, error, stackTrace);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _instance.error(message, error, stackTrace);
  }
}

