/// 控制台日志实现
///
/// 使用 Dart 原生 print 输出日志，不依赖任何外部包
library;

import 'logger_interface.dart';

/// 控制台日志实现
class ConsoleLogger implements LoggerInterface {
  static const String _prefix = '[XBoard]';

  @override
  LogLevel minLevel;

  /// 是否启用时间戳
  final bool enableTimestamp;

  /// 是否启用颜色（仅在支持 ANSI 的终端中有效）
  final bool enableColor;

  ConsoleLogger({
    this.minLevel = LogLevel.info,
    this.enableTimestamp = true,
    this.enableColor = false,
  });

  /// ANSI 颜色代码
  static const String _resetColor = '\x1B[0m';
  static const String _debugColor = '\x1B[36m'; // Cyan
  static const String _infoColor = '\x1B[32m'; // Green
  static const String _warningColor = '\x1B[33m'; // Yellow
  static const String _errorColor = '\x1B[31m'; // Red

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (minLevel.index <= LogLevel.debug.index) {
      _log('DEBUG', message, error, stackTrace, _debugColor);
    }
  }

  @override
  void info(String message, [Object? error, StackTrace? stackTrace]) {
    if (minLevel.index <= LogLevel.info.index) {
      _log('INFO', message, error, stackTrace, _infoColor);
    }
  }

  @override
  void warning(String message, [Object? error, StackTrace? stackTrace]) {
    if (minLevel.index <= LogLevel.warning.index) {
      _log('WARN', message, error, stackTrace, _warningColor);
    }
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (minLevel.index <= LogLevel.error.index) {
      _log('ERROR', message, error, stackTrace, _errorColor);
    }
  }

  void _log(
    String level,
    String message,
    Object? error,
    StackTrace? stackTrace,
    String colorCode,
  ) {
    final timestamp = enableTimestamp ? _getTimestamp() : '';
    final prefix = enableColor ? '$colorCode$_prefix' : _prefix;
    final levelStr = enableColor ? '[$level]' : '[$level]';
    final resetColor = enableColor ? _resetColor : '';

    // 构建日志消息
    final buffer = StringBuffer();
    buffer.write('$prefix$timestamp$levelStr $message$resetColor');

    // 输出主消息
    // ignore: avoid_print
    print(buffer.toString());

    // 输出错误信息
    if (error != null) {
      // ignore: avoid_print
      print('$_prefix[$level] Error: $error');
    }

    // 输出堆栈跟踪
    if (stackTrace != null) {
      // ignore: avoid_print
      print('$_prefix[$level] StackTrace:\n$stackTrace');
    }
  }

  String _getTimestamp() {
    final now = DateTime.now();
    return '[${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}]';
  }
}

