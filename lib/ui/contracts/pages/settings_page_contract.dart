/// 设置页面契约
/// 
/// 定义设置页面需要的数据和回调
library;

import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

/// 设置页面契约
abstract class SettingsPageContract extends PageContract<SettingsPageData, SettingsPageCallbacks> {
  const SettingsPageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 设置页面数据
class SettingsPageData implements DataModel {
  /// 应用设置
  final AppSettings appSettings;
  
  /// Clash 配置
  final ClashConfig clashConfig;
  
  /// 当前主题ID
  final String currentThemeId;
  
  /// 可用的主题列表
  final List<ThemeInfo> availableThemes;
  
  /// 应用版本
  final String appVersion;
  
  /// 是否有新版本
  final bool hasUpdate;

  const SettingsPageData({
    required this.appSettings,
    required this.clashConfig,
    required this.currentThemeId,
    required this.availableThemes,
    required this.appVersion,
    this.hasUpdate = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'appSettings': appSettings.toJson(),
      'clashConfig': clashConfig.toJson(),
      'currentThemeId': currentThemeId,
      'availableThemes': availableThemes.map((t) => t.toMap()).toList(),
      'appVersion': appVersion,
      'hasUpdate': hasUpdate,
    };
  }
}

/// 主题信息
class ThemeInfo {
  final String id;
  final String name;
  final String description;

  const ThemeInfo({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

/// 应用设置（简化版，实际使用原有的）
class AppSettings {
  final String locale;
  final bool autoLaunch;
  final bool silentLaunch;
  final bool autoUpdateCheck;

  const AppSettings({
    required this.locale,
    this.autoLaunch = false,
    this.silentLaunch = false,
    this.autoUpdateCheck = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'locale': locale,
      'autoLaunch': autoLaunch,
      'silentLaunch': silentLaunch,
      'autoUpdateCheck': autoUpdateCheck,
    };
  }
}

/// 设置页面回调
class SettingsPageCallbacks implements CallbacksModel {
  /// 改变UI主题
  final ValueCallback<String> onThemeChange;
  
  /// 改变语言
  final ValueCallback<String> onLocaleChange;
  
  /// 改变主题模式（亮色/暗色）
  final ValueCallback<ThemeMode> onThemeModeChange;
  
  /// 改变自动启动
  final ValueCallback<bool> onAutoLaunchChange;
  
  /// 改变静默启动
  final ValueCallback<bool> onSilentLaunchChange;
  
  /// 改变自动检查更新
  final ValueCallback<bool> onAutoUpdateCheckChange;
  
  /// 修改 Clash 配置
  final VoidCallback onClashConfigEdit;
  
  /// 查看关于
  final VoidCallback onAbout;
  
  /// 查看日志
  final VoidCallback onLogs;
  
  /// 备份数据
  final VoidCallback onBackup;
  
  /// 恢复数据
  final VoidCallback onRestore;
  
  /// 清除缓存
  final VoidCallback onClearCache;
  
  /// 检查更新
  final VoidCallback onCheckUpdate;

  const SettingsPageCallbacks({
    required this.onThemeChange,
    required this.onLocaleChange,
    required this.onThemeModeChange,
    required this.onAutoLaunchChange,
    required this.onSilentLaunchChange,
    required this.onAutoUpdateCheckChange,
    required this.onClashConfigEdit,
    required this.onAbout,
    required this.onLogs,
    required this.onBackup,
    required this.onRestore,
    required this.onClearCache,
    required this.onCheckUpdate,
  });
}

