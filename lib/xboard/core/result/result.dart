/// Result 类型 - 统一的成功/失败封装
///
/// 用于替代返回 null 的做法，明确区分成功和失败，保留错误信息
///
/// 使用示例：
/// ```dart
/// // 返回成功
/// return Result.success(userData);
///
/// // 返回失败
/// return Result.failure(XBoardException(
///   code: 'USER_NOT_FOUND',
///   message: '用户不存在',
/// ));
///
/// // 使用结果
/// final result = await getUserInfo();
/// result.when(
///   success: (data) => print('成功: $data'),
///   failure: (error) => print('失败: ${error.message}'),
/// );
/// ```
library;

import '../exceptions/xboard_exception.dart';

/// Result 类型 - 封装操作的成功或失败结果
sealed class Result<T> {
  const Result();

  /// 创建成功结果
  factory Result.success(T data) = Success<T>;

  /// 创建失败结果
  factory Result.failure(XBoardException exception) = Failure<T>;

  /// 是否成功
  bool get isSuccess => this is Success<T>;

  /// 是否失败
  bool get isFailure => this is Failure<T>;

  /// 获取数据（成功时返回数据，失败时返回 null）
  T? get dataOrNull => switch (this) {
        Success(:final data) => data,
        Failure() => null,
      };

  /// 获取异常（失败时返回异常，成功时返回 null）
  XBoardException? get exceptionOrNull => switch (this) {
        Success() => null,
        Failure(:final exception) => exception,
      };

  /// 获取数据（成功时返回数据，失败时抛出异常）
  T get data => switch (this) {
        Success(:final data) => data,
        Failure(:final exception) => throw exception,
      };

  /// 模式匹配处理结果
  R when<R>({
    required R Function(T data) success,
    required R Function(XBoardException exception) failure,
  }) {
    return switch (this) {
      Success(:final data) => success(data),
      Failure(:final exception) => failure(exception),
    };
  }

  /// 异步模式匹配处理结果
  Future<R> whenAsync<R>({
    required Future<R> Function(T data) success,
    required Future<R> Function(XBoardException exception) failure,
  }) {
    return switch (this) {
      Success(:final data) => success(data),
      Failure(:final exception) => failure(exception),
    };
  }

  /// 映射成功值
  Result<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success(:final data) => Result.success(transform(data)),
      Failure(:final exception) => Result.failure(exception),
    };
  }

  /// 异步映射成功值
  Future<Result<R>> mapAsync<R>(Future<R> Function(T data) transform) async {
    return switch (this) {
      Success(:final data) => Result.success(await transform(data)),
      Failure(:final exception) => Result.failure(exception),
    };
  }

  /// 链式调用（flatMap）
  Result<R> flatMap<R>(Result<R> Function(T data) transform) {
    return switch (this) {
      Success(:final data) => transform(data),
      Failure(:final exception) => Result.failure(exception),
    };
  }

  /// 异步链式调用
  Future<Result<R>> flatMapAsync<R>(
    Future<Result<R>> Function(T data) transform,
  ) async {
    return switch (this) {
      Success(:final data) => await transform(data),
      Failure(:final exception) => Result.failure(exception),
    };
  }

  /// 提供默认值
  T getOrElse(T defaultValue) {
    return dataOrNull ?? defaultValue;
  }

  /// 提供默认值（延迟计算）
  T getOrElseLazy(T Function() defaultValue) {
    return dataOrNull ?? defaultValue();
  }
}

/// 成功结果
final class Success<T> extends Result<T> {
  @override
  final T data;

  const Success(this.data);

  @override
  String toString() => 'Success(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Success<T> && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

/// 失败结果
final class Failure<T> extends Result<T> {
  final XBoardException exception;

  const Failure(this.exception);

  @override
  String toString() => 'Failure(exception: $exception)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure<T> && other.exception == exception;
  }

  @override
  int get hashCode => exception.hashCode;
}

/// 扩展方法 - 将 Future 转换为 Result
extension FutureResultExtension<T> on Future<T> {
  /// 将可能抛出异常的 Future 转换为 Result
  Future<Result<T>> toResult({
    XBoardException Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      final data = await this;
      return Result.success(data);
    } catch (error, stackTrace) {
      if (error is XBoardException) {
        return Result.failure(error);
      }
      final exception = onError?.call(error, stackTrace) ??
          XBoardException(
            code: 'UNKNOWN_ERROR',
            message: error.toString(),
            originalError: error,
            stackTrace: stackTrace,
          );
      return Result.failure(exception);
    }
  }
}

/// 扩展方法 - 将同步函数转换为 Result
extension FunctionResultExtension<T> on T Function() {
  /// 将可能抛出异常的函数转换为 Result
  Result<T> toResult({
    XBoardException Function(Object error, StackTrace stackTrace)? onError,
  }) {
    try {
      final data = this();
      return Result.success(data);
    } catch (error, stackTrace) {
      if (error is XBoardException) {
        return Result.failure(error);
      }
      final exception = onError?.call(error, stackTrace) ??
          XBoardException(
            code: 'UNKNOWN_ERROR',
            message: error.toString(),
            originalError: error,
            stackTrace: stackTrace,
          );
      return Result.failure(exception);
    }
  }
}

