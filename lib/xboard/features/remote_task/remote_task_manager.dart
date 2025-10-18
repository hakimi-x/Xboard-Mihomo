import 'dart:convert'; // 导入 json 编解码库
import 'package:fl_clash/xboard/core/core.dart';
import 'package:fl_clash/xboard/config/xboard_config.dart';

import 'services/status_reporting_service.dart';
import 'services/remote_task_service.dart';
import 'services/device_info_service.dart';
import 'utils/node_id_manager.dart';

class RemoteTaskManager {
  final String _wsUrl;
  late final StatusReportingService _statusReportingService;
  late final RemoteTaskService _remoteTaskService;
  
  RemoteTaskManager._internal(this._wsUrl) {
    // For demonstration, a hardcoded token. In a real app, get this securely.
    const String dummyAuthToken = "a-very-secret-token"; 

    _statusReportingService = StatusReportingService(
      _wsUrl,
      onStatusChange: (isConnected) {
        XBoardLogger.info('WebSocket 连接状态: $isConnected');
      },
      onMessageReceivedCallback: _handleIncomingMessage, // 将消息处理回调绑定到这里
      authToken: dummyAuthToken, // Pass the authentication token
    );
    _remoteTaskService = RemoteTaskService();
  }

  /// 从配置创建RemoteTaskManager实例
  static Future<RemoteTaskManager?> create() async {
    try {
      final wsUrl = XBoardConfig.wsUrl;
      if (wsUrl == null) {
        XBoardLogger.warning('无法从配置获取WebSocket URL');
        return null;
      }
      XBoardLogger.info('从配置获取WebSocket URL: $wsUrl');
      return RemoteTaskManager._internal(wsUrl);
    } catch (e) {
      XBoardLogger.error('创建RemoteTaskManager失败', e);
      return null;
    }
  }

  /// 使用指定URL创建RemoteTaskManager（仅用于测试，生产环境请使用create()方法）
  /// 注意：此方法绕过了配置系统，仅应在测试或特殊调试场景中使用
  static RemoteTaskManager createWithUrl(String wsUrl) {
    return RemoteTaskManager._internal(wsUrl);
  }
  void initialize() {
    XBoardLogger.info('RemoteTaskManager 已初始化');
  }
  void start() {
    _statusReportingService.connect();
    XBoardLogger.info('RemoteTaskManager 已启动: 尝试连接 WebSocket');
  }
  void stop() {
    _statusReportingService.dispose(); // dispose 方法会停止并清理资源
    XBoardLogger.info('RemoteTaskManager 已停止');
  }
  void dispose() {
    _statusReportingService.dispose();
    XBoardLogger.info('RemoteTaskManager 已释放');
  }
  Future<void> _handleIncomingMessage(String message) async {
    XBoardLogger.debug('RemoteTaskManager 接收到原始消息: $message');
    try {
      final Map<String, dynamic> data = jsonDecode(message);
      
      // 处理系统事件消息
      if (data.containsKey('event')) {
        final String event = data['event'];
        switch (event) {
          case 'pong':
            XBoardLogger.debug('收到服务端心跳响应: ${data['timestamp']}');
            return;
          case 'identify_ack':
            XBoardLogger.info('身份验证成功: ${data['message']}');
            return;
          default:
            XBoardLogger.warning('收到未知系统事件: $event');
            return;
        }
      }
      final String? commandId = data['commandId'];
      final String? type = data['type'];
      final Map<String, dynamic>? payload = data['payload'];
      if (commandId == null || type == null || payload == null) {
        XBoardLogger.error('接收到的指令格式不正确，缺少 commandId, type 或 payload');
        XBoardLogger.debug('消息内容: $message');
        if (data.containsKey('commandId') || data.containsKey('type')) {
          _sendTaskResult(commandId, 'error', '指令格式不正确', null);
        }
        return;
      }
      XBoardLogger.debug('解析指令: commandId=$commandId, type=$type');
      dynamic taskResult;
      String status = 'success';
      String? errorMessage;
      switch (type) {
        case 'http_task':
          final String? url = payload['url'];
          final String method = payload['method'] ?? 'GET';
          final Map<String, dynamic>? headers = payload['headers'];
          final dynamic body = payload['body'];
          if (url == null) {
            status = 'error';
            errorMessage = 'HTTP 任务缺少 URL 参数。';
            XBoardLogger.error(errorMessage);
          } else {
            try {
              taskResult = await _remoteTaskService.executeHttpRequest(
                url: url,
                method: method,
                headers: headers,
                body: body,
              );
              if (taskResult['status'] == 'error') {
                status = 'error';
                errorMessage = taskResult['errorMessage'];
              }
            } catch (e) {
              status = 'error';
              errorMessage = '执行 HTTP 任务时发生异常: $e';
              XBoardLogger.error(errorMessage);
            }
          }
          break;
        case 'device_info':
          final String infoType = payload['info_type'] ?? 'basic';
          try {
            switch (infoType) {
              case 'basic':
                taskResult = await DeviceInfoService.collectBasicDeviceInfo();
                break;
              case 'network':
                taskResult = await DeviceInfoService.collectNetworkInfo();
                break;
              case 'system':
                taskResult = await DeviceInfoService.collectSystemResources();
                break;
              case 'runtime':
                taskResult = await DeviceInfoService.collectAppRuntimeInfo();
                break;
              case 'all':
                // 收集所有信息
                final basicInfo = await DeviceInfoService.collectBasicDeviceInfo();
                final networkInfo = await DeviceInfoService.collectNetworkInfo();
                final systemInfo = await DeviceInfoService.collectSystemResources();
                final runtimeInfo = await DeviceInfoService.collectAppRuntimeInfo();
                taskResult = {
                  'status': 'success',
                  'all_info': {
                    'basic': basicInfo,
                    'network': networkInfo,
                    'system': systemInfo,
                    'runtime': runtimeInfo,
                  }
                };
                break;
              default:
                status = 'error';
                errorMessage = '不支持的设备信息类型: $infoType (支持: basic, network, system, runtime, all)';
                XBoardLogger.error(errorMessage);
                break;
            }
            
            if (taskResult['status'] == 'error') {
              status = 'error';
              errorMessage = taskResult['error_message'];
            }
          } catch (e) {
            status = 'error';
            errorMessage = '收集设备信息时发生异常: $e';
            XBoardLogger.error(errorMessage);
          }
          break;
        default:
          status = 'error';
          errorMessage = '未知指令类型: $type';
          XBoardLogger.error(errorMessage);
          break;
      }
      _sendTaskResult(commandId, status, errorMessage, taskResult);
    } catch (e) {
      XBoardLogger.error('处理传入消息时发生 JSON 解析错误或未知错误', e);
      _sendTaskResult(null, 'error', '客户端处理指令时发生内部错误: $e', null);
    }
  }
  void _sendTaskResult(String? commandId, String status, String? errorMessage, dynamic result) async {
    try {
      final nodeId = await NodeIdManager.getNodeId();
      final Map<String, dynamic> responsePayload = {
        'commandId': commandId,
        'nodeId': nodeId,
        'status': status,
        'timestamp': DateTime.now().toIso8601String(),
      };
      if (errorMessage != null) {
        responsePayload['errorMessage'] = errorMessage;
      }
      if (result != null) {
        responsePayload['result'] = result;
      }
      final String jsonResponse = jsonEncode(responsePayload);
      _statusReportingService.sendMessage(jsonResponse);
    } catch (e) {
      XBoardLogger.error('发送任务结果时获取nodeId失败', e);
      // 降级处理，不包含nodeId
      final Map<String, dynamic> responsePayload = {
        'commandId': commandId,
        'status': status,
        'timestamp': DateTime.now().toIso8601String(),
        'error': '无法获取nodeId: $e',
      };
      if (errorMessage != null) {
        responsePayload['errorMessage'] = errorMessage;
      }
      if (result != null) {
        responsePayload['result'] = result;
      }
      final String jsonResponse = jsonEncode(responsePayload);
      _statusReportingService.sendMessage(jsonResponse);
    }
  }

}
