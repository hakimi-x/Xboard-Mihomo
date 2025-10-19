/// 代理页面契约
/// 
/// 定义代理选择页面需要的数据和回调
library;

import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/ui/contracts/contract_base.dart';
import 'package:flutter/material.dart';

/// 代理页面契约
abstract class ProxiesPageContract extends PageContract<ProxiesPageData, ProxiesPageCallbacks> {
  const ProxiesPageContract({
    super.key,
    required super.data,
    required super.callbacks,
  });
}

/// 代理页面数据
class ProxiesPageData implements DataModel {
  /// 代理组列表
  final List<Group> groups;
  
  /// 当前展开的组ID列表
  final Set<String> expandedGroupIds;
  
  /// 是否正在测试延迟
  final bool isTesting;
  
  /// 正在测试的代理名称集合
  final Set<String> testingProxies;
  
  /// 搜索关键词
  final String? searchKeyword;
  
  /// 视图模式
  final ProxiesViewMode viewMode;

  const ProxiesPageData({
    required this.groups,
    this.expandedGroupIds = const {},
    this.isTesting = false,
    this.testingProxies = const {},
    this.searchKeyword,
    this.viewMode = ProxiesViewMode.list,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'groups': groups.map((g) => g.toJson()).toList(),
      'expandedGroupIds': expandedGroupIds.toList(),
      'isTesting': isTesting,
      'testingProxies': testingProxies.toList(),
      'searchKeyword': searchKeyword,
      'viewMode': viewMode.toString(),
    };
  }
  
  /// 过滤后的组列表
  List<Group> get filteredGroups {
    if (searchKeyword == null || searchKeyword!.isEmpty) {
      return groups;
    }
    
    return groups.where((group) {
      // 组名匹配
      if (group.name.toLowerCase().contains(searchKeyword!.toLowerCase())) {
        return true;
      }
      // 代理名匹配
      return group.all.any(
        (proxy) => proxy.name.toLowerCase().contains(searchKeyword!.toLowerCase())
      );
    }).toList();
  }
}

/// 代理视图模式
enum ProxiesViewMode {
  list,     // 列表视图
  grid,     // 网格视图
  compact,  // 紧凑视图
}

/// 代理页面回调
class ProxiesPageCallbacks implements CallbacksModel {
  /// 选择代理
  final Function(Group group, String proxyName) onProxySelect;
  
  /// 切换组展开状态
  final ValueCallback<String> onGroupToggle;
  
  /// 测试所有代理延迟
  final VoidCallback onTestAll;
  
  /// 测试单个组的延迟
  final ValueCallback<Group> onTestGroup;
  
  /// 测试单个代理延迟
  final Function(Group group, String proxyName) onTestProxy;
  
  /// 搜索
  final ValueCallback<String?> onSearch;
  
  /// 改变视图模式
  final ValueCallback<ProxiesViewMode> onViewModeChange;
  
  /// 查看代理详情
  final Function(Group group, String proxyName) onProxyDetail;

  const ProxiesPageCallbacks({
    required this.onProxySelect,
    required this.onGroupToggle,
    required this.onTestAll,
    required this.onTestGroup,
    required this.onTestProxy,
    required this.onSearch,
    required this.onViewModeChange,
    required this.onProxyDetail,
  });
}

