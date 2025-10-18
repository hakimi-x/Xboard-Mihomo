import 'package:fl_clash/xboard/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/xboard/features/online_support/providers/chat_provider.dart';
import 'package:fl_clash/xboard/features/auth/auth.dart';

/// WebSocket 自动连接器
///
/// 职责:
/// - 监听用户登录状态变化
/// - 自动管理 WebSocket 连接生命周期
/// - 完全解耦,无需在登录逻辑中主动调用
///
/// 工作原理:
/// 1. 监听 xboardUserAuthProvider 的 isAuthenticated 状态
/// 2. 登录成功(false → true)时自动连接 WebSocket
/// 3. 登出(true → false)时自动断开 WebSocket
/// 4. 初始化时检查当前认证状态,如果已登录则立即连接
final webSocketAutoConnectorProvider = Provider<void>((ref) {
  final wsService = ref.watch(wsServiceProvider);

  // 监听认证状态变化
  ref.listen<UserAuthState>(
    xboardUserAuthProvider,
    (previous, next) {
      final wasAuthenticated = previous?.isAuthenticated ?? false;
      final isAuthenticated = next.isAuthenticated;

      // 从未登录到已登录 → 连接 WebSocket
      if (!wasAuthenticated && isAuthenticated) {
        XBoardLogger.info(
          'WebSocketAutoConnector',
          '检测到登录成功,自动启动 WebSocket 连接',
        );
        wsService.connect();
      }
      // 从已登录到未登录 → 断开 WebSocket
      else if (wasAuthenticated && !isAuthenticated) {
        XBoardLogger.info(
          'WebSocketAutoConnector',
          '检测到登出,自动断开 WebSocket 连接',
        );
        wsService.dispose();
      }
    },
  );

  // 初始化时检查当前认证状态
  // 如果用户已登录(例如应用重启后通过 quickAuth 恢复登录状态),则立即连接
  final currentAuthState = ref.read(xboardUserAuthProvider);
  if (currentAuthState.isAuthenticated) {
    XBoardLogger.info(
      'WebSocketAutoConnector',
      '初始化检测到已登录状态,启动 WebSocket 连接',
    );
    // 使用 Future.microtask 避免在构建期间调用异步操作
    Future.microtask(() => wsService.connect());
  }

  return;
});
