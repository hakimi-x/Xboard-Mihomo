/// 契约基类
/// 所有页面和组件契约都应该继承或遵循这些基类
library;

import 'package:flutter/material.dart';

/// 页面契约基类
/// 
/// 所有页面契约都应该继承这个类
/// 
/// 使用示例：
/// ```dart
/// abstract class HomePageContract extends PageContract<HomePageData, HomePageCallbacks> {
///   const HomePageContract({
///     super.key,
///     required super.data,
///     required super.callbacks,
///   });
/// }
/// ```
abstract class PageContract<TData, TCallbacks> extends StatelessWidget {
  /// 页面数据
  final TData data;
  
  /// 页面回调
  final TCallbacks callbacks;

  const PageContract({
    super.key,
    required this.data,
    required this.callbacks,
  });
}

/// 组件契约基类
/// 
/// 所有组件契约都应该继承这个类
/// 
/// 使用示例：
/// ```dart
/// abstract class CardContract extends ComponentContract<CardProps> {
///   const CardContract({
///     super.key,
///     required super.props,
///   });
/// }
/// ```
abstract class ComponentContract<TProps> extends StatelessWidget {
  /// 组件属性
  final TProps props;

  const ComponentContract({
    super.key,
    required this.props,
  });
}

/// 数据模型基类
/// 
/// 所有数据模型都应该实现这个接口
/// 这样可以方便地进行序列化、调试等操作
abstract class DataModel {
  const DataModel();
  
  /// 转换为 Map（用于序列化）
  Map<String, dynamic> toMap();
}

/// 回调模型基类
/// 
/// 所有回调模型都应该实现这个接口
/// 主要用于类型标识和文档说明
abstract class CallbacksModel {
  const CallbacksModel();
}

/// 通用回调类型定义
typedef VoidCallback = void Function();
typedef ValueCallback<T> = void Function(T value);
typedef AsyncCallback = Future<void> Function();
typedef AsyncValueCallback<T> = Future<void> Function(T value);

/// 工具类：用于创建回调的包装器
class CallbackWrapper {
  /// 包装同步回调，添加错误处理
  static VoidCallback safe(
    VoidCallback callback, {
    String? debugLabel,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    return () {
      try {
        callback();
      } catch (e, stackTrace) {
        debugPrint('[CallbackWrapper] 回调执行失败${debugLabel != null ? ": $debugLabel" : ""}');
        debugPrint('错误: $e');
        if (onError != null) {
          onError(e, stackTrace);
        } else {
          rethrow;
        }
      }
    };
  }

  /// 包装异步回调，添加错误处理
  static AsyncCallback safeAsync(
    AsyncCallback callback, {
    String? debugLabel,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    return () async {
      try {
        await callback();
      } catch (e, stackTrace) {
        debugPrint('[CallbackWrapper] 异步回调执行失败${debugLabel != null ? ": $debugLabel" : ""}');
        debugPrint('错误: $e');
        if (onError != null) {
          onError(e, stackTrace);
        } else {
          rethrow;
        }
      }
    };
  }

  /// 包装带参数的回调
  static ValueCallback<T> safeValue<T>(
    ValueCallback<T> callback, {
    String? debugLabel,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    return (value) {
      try {
        callback(value);
      } catch (e, stackTrace) {
        debugPrint('[CallbackWrapper] 回调执行失败${debugLabel != null ? ": $debugLabel" : ""}');
        debugPrint('参数: $value');
        debugPrint('错误: $e');
        if (onError != null) {
          onError(e, stackTrace);
        } else {
          rethrow;
        }
      }
    };
  }
}

/// 空回调实现（用于测试或占位）
class EmptyCallbacks implements CallbacksModel {
  const EmptyCallbacks();
}

/// 空数据实现（用于测试或占位）
class EmptyData implements DataModel {
  const EmptyData();

  @override
  Map<String, dynamic> toMap() => {};
}

