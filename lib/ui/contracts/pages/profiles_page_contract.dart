/// 配置文件页面契约
/// 
/// 定义配置文件管理页面需要的数据和回调
library;

import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

/// 配置文件页面契约
abstract class ProfilesPageContract extends PageContract<ProfilesPageData, ProfilesPageCallbacks> {
  const ProfilesPageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 配置文件页面数据
class ProfilesPageData implements DataModel {
  /// 所有配置文件列表
  final List<Profile> profiles;
  
  /// 当前激活的配置文件 ID
  final String? currentProfileId;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 是否正在更新某个配置文件
  final String? updatingProfileId;
  
  /// 排序方式
  final ProfileSortType sortType;

  const ProfilesPageData({
    required this.profiles,
    this.currentProfileId,
    this.isLoading = false,
    this.updatingProfileId,
    this.sortType = ProfileSortType.createTime,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'profiles': profiles.map((p) => p.toJson()).toList(),
      'currentProfileId': currentProfileId,
      'isLoading': isLoading,
      'updatingProfileId': updatingProfileId,
      'sortType': sortType.toString(),
    };
  }
  
  /// 获取当前激活的配置文件
  Profile? get currentProfile {
    if (currentProfileId == null) return null;
    try {
      return profiles.firstWhere((p) => p.id == currentProfileId);
    } catch (e) {
      return null;
    }
  }
}

/// 配置文件排序类型
enum ProfileSortType {
  createTime,
  updateTime,
  name,
}

/// 配置文件页面回调
class ProfilesPageCallbacks implements CallbacksModel {
  /// 选择配置文件
  final ValueCallback<Profile> onProfileSelect;
  
  /// 添加配置文件
  final VoidCallback onProfileAdd;
  
  /// 编辑配置文件
  final ValueCallback<Profile> onProfileEdit;
  
  /// 删除配置文件
  final ValueCallback<Profile> onProfileDelete;
  
  /// 更新配置文件
  final ValueCallback<Profile> onProfileUpdate;
  
  /// 导入配置文件（从URL）
  final VoidCallback onProfileImportFromUrl;
  
  /// 导入配置文件（从文件）
  final VoidCallback onProfileImportFromFile;
  
  /// 导入配置文件（扫码）
  final VoidCallback onProfileImportFromQr;
  
  /// 改变排序方式
  final ValueCallback<ProfileSortType> onSortTypeChange;
  
  /// 查看配置文件详情
  final ValueCallback<Profile> onProfileDetail;

  const ProfilesPageCallbacks({
    required this.onProfileSelect,
    required this.onProfileAdd,
    required this.onProfileEdit,
    required this.onProfileDelete,
    required this.onProfileUpdate,
    required this.onProfileImportFromUrl,
    required this.onProfileImportFromFile,
    required this.onProfileImportFromQr,
    required this.onSortTypeChange,
    required this.onProfileDetail,
  });
}

