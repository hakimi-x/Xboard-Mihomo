/// XBoard 统一异常类型
///
/// 用于封装 XBoard 模块中的所有错误，提供统一的错误处理机制
///
/// 使用示例：
/// ```dart
/// // 创建异常
/// throw XBoardException(
///   code: 'AUTH_FAILED',
///   message: '登录失败',
///   details: {'email': 'user@example.com'},
/// );
///
/// // 创建特定类型的异常
/// throw XBoardNetworkException(
///   message: '网络请求失败',
///   statusCode: 500,
/// );
/// ```
library;

/// XBoard 基础异常类
class XBoardException implements Exception {
  /// 错误码（用于程序判断）
  final String code;

  /// 错误消息（用于显示给用户）
  final String message;

  /// 详细信息（可选，用于调试）
  final Map<String, dynamic>? details;

  /// 原始错误对象（可选）
  final Object? originalError;

  /// 堆栈跟踪（可选）
  final StackTrace? stackTrace;

  XBoardException({
    required this.code,
    required this.message,
    this.details,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer('XBoardException($code: $message)');
    if (details != null && details!.isNotEmpty) {
      buffer.write('\n  Details: $details');
    }
    if (originalError != null) {
      buffer.write('\n  Original: $originalError');
    }
    return buffer.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is XBoardException &&
        other.code == code &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(code, message);
}

/// 网络相关异常
class XBoardNetworkException extends XBoardException {
  /// HTTP 状态码
  final int? statusCode;

  /// 请求 URL
  final String? url;

  XBoardNetworkException({
    String code = 'NETWORK_ERROR',
    required String message,
    this.statusCode,
    this.url,
    Map<String, dynamic>? details,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          details: details,
          originalError: originalError,
          stackTrace: stackTrace,
        );

  @override
  String toString() {
    final buffer = StringBuffer('XBoardNetworkException($code: $message)');
    if (statusCode != null) {
      buffer.write('\n  Status: $statusCode');
    }
    if (url != null) {
      buffer.write('\n  URL: $url');
    }
    if (details != null && details!.isNotEmpty) {
      buffer.write('\n  Details: $details');
    }
    return buffer.toString();
  }
}

/// 认证相关异常
class XBoardAuthException extends XBoardException {
  XBoardAuthException({
    String code = 'AUTH_ERROR',
    required String message,
    Map<String, dynamic>? details,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          details: details,
          originalError: originalError,
          stackTrace: stackTrace,
        );

  @override
  String toString() => 'XBoardAuthException($code: $message)';
}

/// 验证相关异常
class XBoardValidationException extends XBoardException {
  /// 验证失败的字段
  final String? field;

  XBoardValidationException({
    String code = 'VALIDATION_ERROR',
    required String message,
    this.field,
    Map<String, dynamic>? details,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          details: details,
          originalError: originalError,
          stackTrace: stackTrace,
        );

  @override
  String toString() {
    final buffer = StringBuffer('XBoardValidationException($code: $message)');
    if (field != null) {
      buffer.write('\n  Field: $field');
    }
    return buffer.toString();
  }
}

/// 业务逻辑异常
class XBoardBusinessException extends XBoardException {
  XBoardBusinessException({
    required String code,
    required String message,
    Map<String, dynamic>? details,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          details: details,
          originalError: originalError,
          stackTrace: stackTrace,
        );

  @override
  String toString() => 'XBoardBusinessException($code: $message)';
}

/// 数据解析异常
class XBoardParseException extends XBoardException {
  /// 解析失败的数据类型
  final String? dataType;

  XBoardParseException({
    String code = 'PARSE_ERROR',
    required String message,
    this.dataType,
    Map<String, dynamic>? details,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          details: details,
          originalError: originalError,
          stackTrace: stackTrace,
        );

  @override
  String toString() {
    final buffer = StringBuffer('XBoardParseException($code: $message)');
    if (dataType != null) {
      buffer.write('\n  DataType: $dataType');
    }
    return buffer.toString();
  }
}

/// 存储相关异常
class XBoardStorageException extends XBoardException {
  /// 操作类型（read, write, delete）
  final String? operation;

  /// 存储键名
  final String? key;

  XBoardStorageException({
    String code = 'STORAGE_ERROR',
    required String message,
    this.operation,
    this.key,
    Map<String, dynamic>? details,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          details: details,
          originalError: originalError,
          stackTrace: stackTrace,
        );

  @override
  String toString() {
    final buffer = StringBuffer('XBoardStorageException($code: $message)');
    if (operation != null) {
      buffer.write('\n  Operation: $operation');
    }
    if (key != null) {
      buffer.write('\n  Key: $key');
    }
    return buffer.toString();
  }
}

/// 配置相关异常
class XBoardConfigException extends XBoardException {
  XBoardConfigException({
    String code = 'CONFIG_ERROR',
    required String message,
    Map<String, dynamic>? details,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          details: details,
          originalError: originalError,
          stackTrace: stackTrace,
        );

  @override
  String toString() => 'XBoardConfigException($code: $message)';
}

/// 超时异常
class XBoardTimeoutException extends XBoardException {
  /// 超时时长（毫秒）
  final int? timeoutMs;

  XBoardTimeoutException({
    String code = 'TIMEOUT_ERROR',
    required String message,
    this.timeoutMs,
    Map<String, dynamic>? details,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          details: details,
          originalError: originalError,
          stackTrace: stackTrace,
        );

  @override
  String toString() {
    final buffer = StringBuffer('XBoardTimeoutException($code: $message)');
    if (timeoutMs != null) {
      buffer.write('\n  Timeout: ${timeoutMs}ms');
    }
    return buffer.toString();
  }
}

/// 未知异常
class XBoardUnknownException extends XBoardException {
  XBoardUnknownException({
    String code = 'UNKNOWN_ERROR',
    String message = '未知错误',
    Map<String, dynamic>? details,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          details: details,
          originalError: originalError,
          stackTrace: stackTrace,
        );

  @override
  String toString() => 'XBoardUnknownException($code: $message)';
}

/// 常用错误码定义
class XBoardErrorCodes {
  // 通用错误
  static const String unknown = 'UNKNOWN_ERROR';
  static const String timeout = 'TIMEOUT_ERROR';
  static const String cancelled = 'CANCELLED';

  // 网络错误
  static const String networkError = 'NETWORK_ERROR';
  static const String noInternet = 'NO_INTERNET';
  static const String serverError = 'SERVER_ERROR';
  static const String badRequest = 'BAD_REQUEST';
  static const String unauthorized = 'UNAUTHORIZED';
  static const String forbidden = 'FORBIDDEN';
  static const String notFound = 'NOT_FOUND';

  // 认证错误
  static const String authFailed = 'AUTH_FAILED';
  static const String tokenExpired = 'TOKEN_EXPIRED';
  static const String tokenInvalid = 'TOKEN_INVALID';
  static const String notLoggedIn = 'NOT_LOGGED_IN';

  // 验证错误
  static const String validationError = 'VALIDATION_ERROR';
  static const String invalidEmail = 'INVALID_EMAIL';
  static const String invalidPassword = 'INVALID_PASSWORD';
  static const String passwordMismatch = 'PASSWORD_MISMATCH';

  // 业务错误
  static const String userNotFound = 'USER_NOT_FOUND';
  static const String userAlreadyExists = 'USER_ALREADY_EXISTS';
  static const String insufficientBalance = 'INSUFFICIENT_BALANCE';
  static const String orderNotFound = 'ORDER_NOT_FOUND';
  static const String planNotFound = 'PLAN_NOT_FOUND';

  // 数据错误
  static const String parseError = 'PARSE_ERROR';
  static const String dataNotFound = 'DATA_NOT_FOUND';
  static const String dataCorrupted = 'DATA_CORRUPTED';

  // 存储错误
  static const String storageError = 'STORAGE_ERROR';
  static const String storageReadError = 'STORAGE_READ_ERROR';
  static const String storageWriteError = 'STORAGE_WRITE_ERROR';

  // 配置错误
  static const String configError = 'CONFIG_ERROR';
  static const String configNotInitialized = 'CONFIG_NOT_INITIALIZED';
  static const String configInvalid = 'CONFIG_INVALID';
}

