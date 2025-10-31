import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/ticket/models/ticket_state.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';

class TicketNotifier extends Notifier<TicketState> {
  @override
  TicketState build() {
    return const TicketState();
  }

  /// 获取工单列表
  Future<void> fetchTickets() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      commonPrint.log('开始获取工单列表...');
      final tickets = await XBoardSDK.getTickets();
      
      // 按创建时间降序排序（最新的在前）
      final sortedTickets = [...tickets]
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      state = state.copyWith(
        tickets: sortedTickets,
        isLoading: false,
      );
      commonPrint.log('工单列表获取成功，共 ${sortedTickets.length} 条');
    } catch (e) {
      commonPrint.log('获取工单列表失败: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: '获取工单列表失败: $e',
      );
    }
  }

  /// 获取工单详情
  Future<void> fetchTicketDetail(int ticketId) async {
    state = state.copyWith(isLoadingDetail: true, errorMessage: null);
    try {
      commonPrint.log('开始获取工单详情: $ticketId');
      final ticketDetail = await XBoardSDK.getTicketDetail(ticketId);
      
      if (ticketDetail != null) {
        state = state.copyWith(
          currentTicketDetail: ticketDetail,
          isLoadingDetail: false,
        );
        commonPrint.log('工单详情获取成功');
      } else {
        state = state.copyWith(
          isLoadingDetail: false,
          errorMessage: '获取工单详情失败',
        );
      }
    } catch (e) {
      commonPrint.log('获取工单详情失败: $e');
      state = state.copyWith(
        isLoadingDetail: false,
        errorMessage: '获取工单详情失败: $e',
      );
    }
  }

  /// 创建工单
  Future<bool> createTicket({
    required String subject,
    required String message,
    required int level,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      commonPrint.log('创建工单: $subject');
      final ticket = await XBoardSDK.createTicket(
        subject: subject,
        message: message,
        level: level,
      );
      
      // ticket为null也可能表示成功（服务器只返回success=true）
      commonPrint.log('工单创建成功');
      // 刷新工单列表
      await fetchTickets();
      return true;
    } catch (e) {
      commonPrint.log('创建工单失败: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: '创建工单失败: $e',
      );
      return false;
    }
  }

  /// 回复工单
  Future<bool> replyTicket({
    required int ticketId,
    required String message,
  }) async {
    try {
      commonPrint.log('回复工单: $ticketId');
      final success = await XBoardSDK.replyTicket(
        id: ticketId,
        message: message,
      );
      
      if (success) {
        commonPrint.log('工单回复成功，刷新详情...');
        // 刷新工单详情
        await fetchTicketDetail(ticketId);
        // 刷新列表
        await fetchTickets();
        return true;
      }
      return false;
    } catch (e) {
      commonPrint.log('回复工单失败: $e');
      state = state.copyWith(
        errorMessage: '回复工单失败: $e',
      );
      return false;
    }
  }

  /// 关闭工单
  Future<bool> closeTicket(int ticketId) async {
    try {
      commonPrint.log('关闭工单: $ticketId');
      final success = await XBoardSDK.closeTicket(ticketId);
      
      if (success) {
        commonPrint.log('工单关闭成功');
        // 刷新工单列表
        await fetchTickets();
        return true;
      }
      return false;
    } catch (e) {
      commonPrint.log('关闭工单失败: $e');
      state = state.copyWith(
        errorMessage: '关闭工单失败: $e',
      );
      return false;
    }
  }

  /// 清除错误消息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final ticketProvider = NotifierProvider<TicketNotifier, TicketState>(
  TicketNotifier.new,
);

