import 'package:dio/dio.dart';
import 'package:fl_clash/xboard/core/core.dart';
import 'user_agent_config.dart';

/// XBoard 统一 HTTP 客户端配置
class XBoardHttpConfig {
  // ========== 超时配置 ==========
  
  /// 快速操作超时（本地缓存、健康检查）
  static const quickTimeout = Duration(seconds: 5);
  
  /// 标准 API 请求超时
  static const standardTimeout = Duration(seconds: 15);
  
  /// 下载操作超时（订阅、配置文件）
  static const downloadTimeout = Duration(seconds: 30);
  
  /// 上传操作超时（文件上传、日志上传）
  static const uploadTimeout = Duration(seconds: 60);
  
  /// 长轮询超时（WebSocket 备用方案）
  static const longPollTimeout = Duration(seconds: 90);
  
  // ========== User-Agent 配置 ==========
  // 注意：不同的 UA 是有意设计的，服务端会根据 UA 返回不同格式的数据
  // ⚠️ 重要：所有 UA 必须和原始代码完全一致，特别是加密部分用于 Caddy 认证
  
  /// User-Agent 配置说明
  /// 
  /// ⚠️ 所有 User-Agent 从配置文件读取，不再有默认值
  /// 
  /// 使用方式：
  /// ```dart
  /// final ua = await UserAgentConfig.get(UserAgentScenario.subscription);
  /// ```
  /// 
  /// 常用场景：
  /// - 订阅下载：UserAgentScenario.subscription
  /// - API/域名竞速：UserAgentScenario.apiEncrypted
  /// - 并发订阅：UserAgentScenario.subscriptionRacing
  /// - 消息附件：UserAgentScenario.attachment
  
  // ========== 重试配置 ==========
  
  /// 默认重试次数
  static const int defaultRetries = 3;
  
  /// 重试延迟（指数退避）
  static Duration retryDelay(int attempt) => Duration(seconds: attempt * 2);
  
  /// 是否应该重试（根据状态码判断）
  static bool shouldRetry(int? statusCode) {
    if (statusCode == null) return true;
    // 5xx 服务器错误应该重试
    if (statusCode >= 500) return true;
    // 429 Too Many Requests 应该重试
    if (statusCode == 429) return true;
    // 408 Request Timeout 应该重试
    if (statusCode == 408) return true;
    return false;
  }
}

/// XBoard 统一 HTTP 客户端
/// 
/// 功能特性：
/// - 统一的超时配置
/// - 统一的错误处理
/// - 自动日志记录
/// - 自动重试机制
/// - 请求/响应拦截器
class XBoardHttpClient {
  final Dio _dio;
  final String? _baseUrl;
  
  XBoardHttpClient({
    String? baseUrl,
    Duration? timeout,
    Map<String, dynamic>? headers,
  })  : _baseUrl = baseUrl,
        _dio = _createDio(
          baseUrl: baseUrl,
          timeout: timeout,
          headers: headers,
        );
  
  /// 创建 Dio 实例
  static Dio _createDio({
    String? baseUrl,
    Duration? timeout,
    Map<String, dynamic>? headers,
  }) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: timeout ?? XBoardHttpConfig.standardTimeout,
      receiveTimeout: timeout ?? XBoardHttpConfig.standardTimeout,
      sendTimeout: timeout ?? XBoardHttpConfig.standardTimeout,
      headers: {
        'Accept': '*/*',
        // User-Agent 由具体请求设置，从配置文件读取
        // 参考: await UserAgentConfig.get(UserAgentScenario.xxx)
        ...?headers,
      },
      validateStatus: (status) => status != null && status < 500,
    ));
    
    // 添加日志拦截器（仅在 Debug 模式）
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      logPrint: (obj) => XBoardLogger.debug('[HTTP] $obj'),
    ));
    
    // 添加重试拦截器
    dio.interceptors.add(_RetryInterceptor(dio));
    
    return dio;
  }
  
  /// GET 请求
  Future<HttpResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// POST 请求
  Future<HttpResult<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// PUT 请求
  Future<HttpResult<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// DELETE 请求
  Future<HttpResult<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// 下载文件
  Future<HttpResult<void>> download(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        options: Options(
          receiveTimeout: XBoardHttpConfig.downloadTimeout,
        ),
      );
      return const HttpSuccess(null, 200, {});
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// 上传文件
  Future<HttpResult<T>> upload<T>(
    String path,
    FormData formData, {
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        options: Options(
          sendTimeout: XBoardHttpConfig.uploadTimeout,
        ),
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// 处理响应
  HttpResult<T> _handleResponse<T>(Response<T> response) {
    final statusCode = response.statusCode ?? 0;
    
    if (statusCode >= 200 && statusCode < 300) {
      return HttpSuccess(
        response.data as T,
        statusCode,
        _convertHeaders(response.headers),
      );
    } else {
      return HttpFailure(
        'HTTP $statusCode: ${response.statusMessage ?? "Unknown error"}',
        statusCode: statusCode,
        data: response.data,
      );
    }
  }
  
  /// 处理错误
  HttpResult<T> _handleError<T>(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return const HttpFailure(
            '连接超时',
            errorType: HttpErrorType.timeout,
          );
        case DioExceptionType.sendTimeout:
          return const HttpFailure(
            '发送超时',
            errorType: HttpErrorType.timeout,
          );
        case DioExceptionType.receiveTimeout:
          return const HttpFailure(
            '接收超时',
            errorType: HttpErrorType.timeout,
          );
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          return HttpFailure(
            'HTTP错误: $statusCode',
            statusCode: statusCode,
            errorType: HttpErrorType.server,
            data: error.response?.data,
          );
        case DioExceptionType.cancel:
          return const HttpFailure(
            '请求已取消',
            errorType: HttpErrorType.cancel,
          );
        case DioExceptionType.badCertificate:
          return const HttpFailure(
            '证书验证失败',
            errorType: HttpErrorType.certificate,
          );
        case DioExceptionType.connectionError:
          return HttpFailure(
            '网络连接失败: ${error.message}',
            errorType: HttpErrorType.network,
          );
        default:
          return HttpFailure(
            '未知错误: ${error.message}',
            errorType: HttpErrorType.unknown,
          );
      }
    }
    
    return HttpFailure(
      '请求异常: $error',
      errorType: HttpErrorType.unknown,
    );
  }
  
  /// 转换 Headers
  Map<String, String> _convertHeaders(Headers headers) {
    final result = <String, String>{};
    headers.forEach((name, values) {
      if (values.isNotEmpty) {
        result[name] = values.first;
      }
    });
    return result;
  }
  
  /// 关闭客户端
  void close({bool force = false}) {
    _dio.close(force: force);
  }
}

/// 重试拦截器
class _RetryInterceptor extends Interceptor {
  final Dio _dio;
  
  _RetryInterceptor(this._dio);
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 检查是否应该重试
    final extra = err.requestOptions.extra;
    final retries = extra['retries'] ?? XBoardHttpConfig.defaultRetries;
    final attempt = extra['attempt'] ?? 0;
    
    if (attempt >= retries) {
      // 已达到最大重试次数
      return handler.next(err);
    }
    
    // 检查错误类型是否应该重试
    final shouldRetry = _shouldRetry(err);
    if (!shouldRetry) {
      return handler.next(err);
    }
    
    // 计算延迟
    final delay = XBoardHttpConfig.retryDelay(attempt + 1);
    XBoardLogger.warning(
      '[HTTP] 请求失败，${delay.inSeconds}秒后进行第${attempt + 1}次重试: ${err.requestOptions.uri}',
    );
    
    // 延迟后重试
    await Future.delayed(delay);
    
    // 更新重试次数
    err.requestOptions.extra['attempt'] = attempt + 1;
    
    try {
      final response = await _dio.fetch(err.requestOptions);
      return handler.resolve(response);
    } catch (e) {
      if (e is DioException) {
        return handler.next(e);
      }
      return handler.next(err);
    }
  }
  
  bool _shouldRetry(DioException err) {
    // 超时应该重试
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return true;
    }
    
    // 网络错误应该重试
    if (err.type == DioExceptionType.connectionError) {
      return true;
    }
    
    // 根据状态码判断
    final statusCode = err.response?.statusCode;
    return XBoardHttpConfig.shouldRetry(statusCode);
  }
}

/// HTTP 结果类型
sealed class HttpResult<T> {
  const HttpResult();
  
  /// 是否成功
  bool get isSuccess => this is HttpSuccess<T>;
  
  /// 是否失败
  bool get isFailure => this is HttpFailure<T>;
  
  /// 获取数据（如果成功）
  T? get dataOrNull => switch (this) {
    HttpSuccess(data: final data) => data,
    _ => null,
  };
  
  /// 模式匹配
  R when<R>({
    required R Function(T data, int statusCode, Map<String, String> headers) success,
    required R Function(String message, HttpErrorType errorType, int? statusCode, dynamic data) failure,
  }) {
    return switch (this) {
      HttpSuccess(data: final data, statusCode: final code, headers: final headers) =>
        success(data, code, headers),
      HttpFailure(
        message: final msg,
        errorType: final type,
        statusCode: final code,
        data: final data
      ) =>
        failure(msg, type, code, data),
    };
  }
}

/// HTTP 成功结果
class HttpSuccess<T> extends HttpResult<T> {
  final T data;
  final int statusCode;
  final Map<String, String> headers;
  
  const HttpSuccess(this.data, this.statusCode, this.headers);
}

/// HTTP 失败结果
class HttpFailure<T> extends HttpResult<T> {
  final String message;
  final HttpErrorType errorType;
  final int? statusCode;
  final dynamic data;
  
  const HttpFailure(
    this.message, {
    this.errorType = HttpErrorType.unknown,
    this.statusCode,
    this.data,
  });
}

/// HTTP 错误类型
enum HttpErrorType {
  /// 网络错误
  network,
  
  /// 超时
  timeout,
  
  /// 服务器错误
  server,
  
  /// 证书错误
  certificate,
  
  /// 请求取消
  cancel,
  
  /// 未知错误
  unknown,
}

