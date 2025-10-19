/// 首页契约
/// 
/// 定义首页需要的数据和回调
library;

import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

/// 首页契约
/// 
/// 所有主题的首页实现都必须继承这个契约
abstract class HomePageContract extends PageContract<HomePageData, HomePageCallbacks> {
  const HomePageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 首页数据
class HomePageData implements DataModel {
  /// 用户名
  final String userName;
  
  /// 是否已连接
  final bool isConnected;
  
  /// 上传速度（字节/秒）
  final int uploadSpeed;
  
  /// 下载速度（字节/秒）
  final int downloadSpeed;
  
  /// 当前选中的配置文件名
  final String? currentProfileName;
  
  /// 当前延迟（毫秒）
  final int? currentDelay;
  
  /// 总上传流量（字节）
  final int totalUpload;
  
  /// 总下载流量（字节）
  final int totalDownload;
  
  /// 活跃连接数
  final int activeConnections;

  const HomePageData({
    required this.userName,
    required this.isConnected,
    required this.uploadSpeed,
    required this.downloadSpeed,
    this.currentProfileName,
    this.currentDelay,
    required this.totalUpload,
    required this.totalDownload,
    required this.activeConnections,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'isConnected': isConnected,
      'uploadSpeed': uploadSpeed,
      'downloadSpeed': downloadSpeed,
      'currentProfileName': currentProfileName,
      'currentDelay': currentDelay,
      'totalUpload': totalUpload,
      'totalDownload': totalDownload,
      'activeConnections': activeConnections,
    };
  }

  /// 格式化速度显示
  String formatSpeed(int bytesPerSecond) {
    if (bytesPerSecond < 1024) {
      return '$bytesPerSecond B/s';
    } else if (bytesPerSecond < 1024 * 1024) {
      return '${(bytesPerSecond / 1024).toStringAsFixed(2)} KB/s';
    } else {
      return '${(bytesPerSecond / (1024 * 1024)).toStringAsFixed(2)} MB/s';
    }
  }

  /// 格式化流量显示
  String formatTraffic(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }
  }
}

/// 首页回调
class HomePageCallbacks implements CallbacksModel {
  /// 切换连接状态
  final VoidCallback onConnectToggle;
  
  /// 点击配置文件
  final VoidCallback onProfilesTap;
  
  /// 点击代理
  final VoidCallback onProxiesTap;
  
  /// 点击连接
  final VoidCallback onConnectionsTap;
  
  /// 点击设置
  final VoidCallback onSettingsTap;
  
  /// 点击日志
  final VoidCallback onLogsTap;
  
  /// 刷新数据
  final AsyncCallback onRefresh;

  const HomePageCallbacks({
    required this.onConnectToggle,
    required this.onProfilesTap,
    required this.onProxiesTap,
    required this.onConnectionsTap,
    required this.onSettingsTap,
    required this.onLogsTap,
    required this.onRefresh,
  });
}

