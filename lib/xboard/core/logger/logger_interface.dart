/// XBoard 日志接口
///
/// 定义统一的日志接口，允许主应用注入自己的日志实现
///
/// 使用示例：
/// ```dart
/// // 使用默认实现
/// final logger = ConsoleLogger();
/// logger.debug('调试信息');
///
/// // 或注入自定义实现
/// class MyCustomLogger implements LoggerInterface {
///   @override
///   void debug(String message, [Object? error, StackTrace? stackTrace]) {
///     // 自定义实现...
///   }
/// }
/// ```
library;

/// 日志级别
enum LogLevel {
  /// 调试级别
  debug,

  /// 信息级别
  info,

  /// 警告级别
  warning,

  /// 错误级别
  error,
}

/// 日志接口
abstract class LoggerInterface {
  /// 日志级别（最低级别，低于此级别的日志不会输出）
  LogLevel get minLevel;

  /// 设置日志级别
  set minLevel(LogLevel level);

  /// 记录调试日志
  ///
  /// [message] 日志消息
  /// [error] 可选的错误对象
  /// [stackTrace] 可选的堆栈跟踪
  void debug(String message, [Object? error, StackTrace? stackTrace]);

  /// 记录信息日志
  ///
  /// [message] 日志消息
  /// [error] 可选的错误对象
  /// [stackTrace] 可选的堆栈跟踪
  void info(String message, [Object? error, StackTrace? stackTrace]);

  /// 记录警告日志
  ///
  /// [message] 日志消息
  /// [error] 可选的错误对象
  /// [stackTrace] 可选的堆栈跟踪
  void warning(String message, [Object? error, StackTrace? stackTrace]);

  /// 记录错误日志
  ///
  /// [message] 日志消息
  /// [error] 可选的错误对象
  /// [stackTrace] 可选的堆栈跟踪
  void error(String message, [Object? error, StackTrace? stackTrace]);
}

/// 空日志实现（不输出任何日志）
class NoOpLogger implements LoggerInterface {
  @override
  LogLevel minLevel = LogLevel.error;

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) {}

  @override
  void info(String message, [Object? error, StackTrace? stackTrace]) {}

  @override
  void warning(String message, [Object? error, StackTrace? stackTrace]) {}

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {}
}

