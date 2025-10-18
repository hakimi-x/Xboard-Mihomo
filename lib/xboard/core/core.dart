/// XBoard Core 模块 - 核心基础层
///
/// 提供 XBoard 模块的核心基础设施，包括：
/// - 日志系统
/// - 异常类型
/// - Result 类型
/// - 工具函数
///
/// 本模块**零依赖**，只依赖 Dart SDK，可以被任何其他模块使用
///
/// 使用示例：
/// ```dart
/// import 'package:fl_clash/xboard/core/core.dart';
///
/// // 使用日志
/// XBoardLogger.info('初始化完成');
///
/// // 使用 Result
/// Result<String> result = Result.success('data');
/// result.when(
///   success: (data) => print(data),
///   failure: (error) => print(error),
/// );
///
/// // 抛出异常
/// throw XBoardException(
///   code: 'ERROR_CODE',
///   message: '错误信息',
/// );
/// ```
library;

// ===== 导出日志模块 =====
export 'logger/logger.dart';

// ===== 导出异常模块 =====
export 'exceptions/exceptions.dart';

// ===== 导出 Result 类型 =====
export 'result/result.dart';

// ===== 导出工具函数 =====
export 'utils/utils.dart';

