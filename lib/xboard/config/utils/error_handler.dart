import '../../core/core.dart';

/// 错误类型
enum ErrorType {
  network,
  parsing,
  validation,
  cache,
  unknown,
}

/// 错误处理结果
class ErrorHandleResult<T> {
  final bool success;
  final T? data;
  final String? error;
  final ErrorType errorType;

  const ErrorHandleResult({
    required this.success,
    this.data,
    this.error,
    required this.errorType,
  });

  factory ErrorHandleResult.success(T data) {
    return ErrorHandleResult(
      success: true,
      data: data,
      errorType: ErrorType.unknown,
    );
  }

  factory ErrorHandleResult.failure(String error, ErrorType type) {
    return ErrorHandleResult(
      success: false,
      error: error,
      errorType: type,
    );
  }
}

/// 错误处理工具
class ErrorHandler {
  /// 处理网络错误
  static ErrorHandleResult<T> handleNetworkError<T>(dynamic error) {
    String errorMessage;
    
    if (error.toString().contains('SocketException')) {
      errorMessage = 'Network connection failed';
    } else if (error.toString().contains('TimeoutException')) {
      errorMessage = 'Request timeout';
    } else if (error.toString().contains('HandshakeException')) {
      errorMessage = 'SSL/TLS handshake failed';
    } else {
      errorMessage = 'Network error: ${error.toString()}';
    }

    NetworkLogger.error('Network error occurred', error);
    
    return ErrorHandleResult.failure(errorMessage, ErrorType.network);
  }

  /// 处理解析错误
  static ErrorHandleResult<T> handleParsingError<T>(dynamic error) {
    String errorMessage;
    
    if (error.toString().contains('FormatException')) {
      errorMessage = 'Invalid JSON format';
    } else if (error.toString().contains('type')) {
      errorMessage = 'Data type mismatch';
    } else {
      errorMessage = 'Parsing error: ${error.toString()}';
    }

    ConfigLogger.error('Parsing error occurred', error);
    
    return ErrorHandleResult.failure(errorMessage, ErrorType.parsing);
  }

  /// 处理验证错误
  static ErrorHandleResult<T> handleValidationError<T>(dynamic error) {
    final errorMessage = 'Validation error: ${error.toString()}';
    
    ConfigLogger.error('Validation error occurred', error);
    
    return ErrorHandleResult.failure(errorMessage, ErrorType.validation);
  }

  /// 处理缓存错误
  static ErrorHandleResult<T> handleCacheError<T>(dynamic error) {
    String errorMessage;
    
    if (error.toString().contains('FileSystemException')) {
      errorMessage = 'Cache file system error';
    } else if (error.toString().contains('Permission')) {
      errorMessage = 'Cache permission denied';
    } else {
      errorMessage = 'Cache error: ${error.toString()}';
    }

    XBoardLogger.warning('Cache error occurred', error);
    
    return ErrorHandleResult.failure(errorMessage, ErrorType.cache);
  }

  /// 通用错误处理
  static ErrorHandleResult<T> handleError<T>(dynamic error) {
    if (error.toString().contains('Socket') || 
        error.toString().contains('Network') ||
        error.toString().contains('Connection')) {
      return handleNetworkError<T>(error);
    }
    
    if (error.toString().contains('Format') || 
        error.toString().contains('JSON') ||
        error.toString().contains('Parse')) {
      return handleParsingError<T>(error);
    }
    
    if (error.toString().contains('Validation') || 
        error.toString().contains('Invalid')) {
      return handleValidationError<T>(error);
    }
    
    if (error.toString().contains('Cache') || 
        error.toString().contains('File')) {
      return handleCacheError<T>(error);
    }

    final errorMessage = 'Unknown error: ${error.toString()}';
    XBoardLogger.error('Unknown error occurred', error);
    
    return ErrorHandleResult.failure(errorMessage, ErrorType.unknown);
  }

  /// 带重试的操作执行
  static Future<ErrorHandleResult<T>> withRetry<T>(
    Future<T> Function() operation, {
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
    bool Function(dynamic error)? shouldRetry,
  }) async {
    dynamic lastError;
    
    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        final result = await operation();
        return ErrorHandleResult.success(result);
      } catch (error) {
        lastError = error;
        
        // 检查是否应该重试
        if (attempt < maxRetries && (shouldRetry?.call(error) ?? _defaultShouldRetry(error))) {
          XBoardLogger.warning('ErrorHandler', 'Operation failed, retrying in ${delay.inSeconds}s (attempt ${attempt + 1}/$maxRetries)');
          await Future.delayed(delay);
          continue;
        }
        
        break;
      }
    }
    
    return handleError<T>(lastError);
  }

  /// 默认重试判断逻辑
  static bool _defaultShouldRetry(dynamic error) {
    final errorStr = error.toString().toLowerCase();
    
    // 网络相关错误通常可以重试
    if (errorStr.contains('socket') || 
        errorStr.contains('timeout') ||
        errorStr.contains('connection')) {
      return true;
    }
    
    // 解析错误通常不需要重试
    if (errorStr.contains('format') || 
        errorStr.contains('parse') ||
        errorStr.contains('json')) {
      return false;
    }
    
    // 默认不重试
    return false;
  }

  /// 安全执行操作
  static Future<ErrorHandleResult<T>> safeExecute<T>(
    Future<T> Function() operation, {
    T? fallback,
  }) async {
    try {
      final result = await operation();
      return ErrorHandleResult.success(result);
    } catch (error) {
      final handleResult = handleError<T>(error);
      
      if (fallback != null) {
        XBoardLogger.info('ErrorHandler', 'Using fallback value due to error');
        return ErrorHandleResult.success(fallback);
      }
      
      return handleResult;
    }
  }

  /// 记录并忽略错误
  static void logAndIgnore(dynamic error, [String? context]) {
    final message = context != null ? '$context: $error' : error.toString();
    XBoardLogger.warning('Error ignored: $message', error);
  }
}