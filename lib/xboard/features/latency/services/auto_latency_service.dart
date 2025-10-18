import 'dart:async';
import 'dart:math';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/proxies/common.dart' as proxies_common;
// operation_coordinator已废弃，移除相关代码
import 'package:fl_clash/xboard/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoLatencyService {
  static final AutoLatencyService _instance = AutoLatencyService._internal();
  factory AutoLatencyService() => _instance;
  AutoLatencyService._internal();
  Timer? _periodicTimer;
  String? _lastTestedProxy;
  DateTime? _lastTestTime;
  bool _isServiceActive = false;
  WidgetRef? _ref;
  final Map<String, DateTime> _proxyTestCache = {};
  static const int _cacheMinutes = 2;
  static const int _periodicIntervalMinutes = 5;
  
  // 操作协调器已废弃
  // final OperationCoordinator _coordinator = OperationCoordinator();
  void initialize(WidgetRef ref) {
    if (_ref == ref && _isServiceActive) {
      XBoardLogger.debug('服务已使用相同ref初始化，跳过重复初始化');
      return;
    }
    _ref = ref;
    if (!_isServiceActive) {
      _isServiceActive = true;
      _startPeriodicTesting();
      XBoardLogger.info('自动延迟测试服务已启动');
    } else {
      XBoardLogger.debug('自动延迟测试服务已激活，更新ref引用');
    }
  }
  void dispose() {
    _periodicTimer?.cancel();
    _periodicTimer = null;
    _nodeChangeTimer?.cancel();
    _nodeChangeTimer = null;
    _isServiceActive = false;
    _ref = null;
    _proxyTestCache.clear();
    XBoardLogger.info('自动延迟测试服务已停止');
  }
  void _cleanExpiredCache() {
    final now = DateTime.now();
    final expiredEntries = <String>[];
    
    _proxyTestCache.removeWhere((proxyName, lastTestTime) {
      final isExpired = now.difference(lastTestTime).inMinutes >= _cacheMinutes * 2;
      if (isExpired) {
        expiredEntries.add(proxyName);
      }
      return isExpired;
    });
    
    if (expiredEntries.isNotEmpty) {
      XBoardLogger.debug('AutoLatencyService', '清理过期缓存: ${expiredEntries.join(', ')}');
    }
  }
  bool _ensureServiceActive() {
    if (!_isServiceActive || _ref == null) {
      XBoardLogger.warning('服务未激活或ref为空');
      return false;
    }
    
    if (!_isRefValid()) {
      XBoardLogger.warning('Ref已失效，服务不可用');
      return false;
    }
    
    try {
      final groups = _ref!.read(groupsProvider);
      if (groups.isEmpty) {
        XBoardLogger.debug('代理组数据尚未加载，跳过测试');
        return false;
      }
      
      final config = _ref!.read(patchClashConfigProvider);
      final mode = config.mode;
      if (mode != Mode.global && mode != Mode.rule) {
        XBoardLogger.debug('当前模式($mode)不支持延迟测试');
        return false;
      }
      
    } catch (e) {
      XBoardLogger.error('无法获取代理组或配置数据', e);
      return false;
    }
    return true;
  }
  Future<void> testCurrentNode({bool forceTest = false}) async {
    if (!_ensureServiceActive()) {
      return;
    }
    if (!_isRefValid()) {
      XBoardLogger.warning('Ref已失效，跳过延迟测试');
      return;
    }
    try {
      final currentProxy = _getCurrentSelectedProxy();
      if (currentProxy == null) {
        XBoardLogger.debug('未找到当前代理，跳过测试');
        return;
      }
      
      if (!forceTest) {
        if (!_shouldTestProxy(currentProxy.name)) {
          XBoardLogger.debug('代理 ${currentProxy.name} 无需重复测试（缓存有效）');
          return;
        }
        
        if (_lastTestedProxy == currentProxy.name && _lastTestTime != null) {
          final timeSinceLastTest = DateTime.now().difference(_lastTestTime!);
          if (timeSinceLastTest.inSeconds < 5) {
            XBoardLogger.debug('代理 ${currentProxy.name} 刚刚测试过(${timeSinceLastTest.inSeconds}s前)，跳过重复测试');
            return;
          }
        }
      }
      
      XBoardLogger.info('开始测试节点延迟: ${currentProxy.name}');
      final testUrl = _ref!.read(appSettingProvider).testUrl;
      await proxies_common.proxyDelayTest(currentProxy, testUrl);
      _lastTestedProxy = currentProxy.name;
      _lastTestTime = DateTime.now();
      _proxyTestCache[currentProxy.name] = DateTime.now();
      XBoardLogger.info('节点延迟测试完成: ${currentProxy.name}');
    } catch (e) {
      XBoardLogger.error('延迟测试失败', e);
    }
  }
  Future<void> testProxy(Proxy proxy, {bool forceTest = false}) async {
    if (!_isServiceActive || _ref == null) {
      XBoardLogger.warning('服务未激活或ref为空，跳过指定节点测试');
      return;
    }
    
    if (!_isRefValid()) {
      XBoardLogger.warning('Ref已失效，跳过指定节点延迟测试');
      return;
    }
    
    try {
      if (!forceTest && !_shouldTestProxy(proxy.name)) {
        XBoardLogger.debug('指定节点 ${proxy.name} 无需重复测试（缓存有效）');
        return;
      }
      
      XBoardLogger.info('开始测试指定节点延迟: ${proxy.name}');
      final testUrl = _ref!.read(appSettingProvider).testUrl;
      await proxies_common.proxyDelayTest(proxy, testUrl);
      _proxyTestCache[proxy.name] = DateTime.now();
      XBoardLogger.info('指定节点延迟测试完成: ${proxy.name}');
    } catch (e) {
      XBoardLogger.error('指定节点延迟测试失败', e);
    }
  }
  Future<void> testCurrentGroupNodes({int maxNodes = 5}) async {
    if (!_ensureServiceActive()) {
      return;
    }
    if (!_isRefValid()) {
      XBoardLogger.warning('Ref已失效，跳过批量延迟测试');
      return;
    }
    try {
      final currentGroup = _getCurrentGroup();
      if (currentGroup == null || currentGroup.all.isEmpty) {
        XBoardLogger.debug('未找到当前组或组为空，跳过批量测试');
        return;
      }
      final nodesToTest = currentGroup.all.take(maxNodes).toList();
      XBoardLogger.info('AutoLatencyService', '开始批量测试当前组 ${currentGroup.name} 的节点，数量: ${nodesToTest.length}');
      XBoardLogger.debug('AutoLatencyService', '测试节点列表: ${nodesToTest.map((p) => p.name).join(', ')}');
      final testUrl = _ref!.read(appSettingProvider).testUrl;
      await proxies_common.delayTest(nodesToTest, testUrl);
      XBoardLogger.info('批量延迟测试完成');
    } catch (e) {
      XBoardLogger.error('批量延迟测试失败', e);
    }
  }
  Timer? _nodeChangeTimer;

  void onNodeChanged() {
    XBoardLogger.info('检测到节点切换，将自动测试新节点');
    
    // 使用防抖机制，避免快速切换时的重复测试
    // _coordinator已废弃，延迟后直接执行
    Future.delayed(const Duration(seconds: 2), () {
      _performNodeChangeTest();
    });
  }

  void _performNodeChangeTest() {
    if (!_ensureServiceActive() || !_isRefValid()) {
      return;
    }
    
    final currentProxy = _getCurrentSelectedProxy();
    if (currentProxy == null) {
      XBoardLogger.warning('节点切换后未找到有效代理');
      return;
    }
    
    // 检查是否需要跳过重复测试
    if (_lastTestedProxy == currentProxy.name && _lastTestTime != null) {
      final timeSinceLastTest = DateTime.now().difference(_lastTestTime!);
      if (timeSinceLastTest.inSeconds < 3) {
        XBoardLogger.debug('节点 ${currentProxy.name} 刚测试过，跳过重复测试');
        return;
      }
    }
    
    // 使用协调器确保同一节点不会同时测试
    // _coordinator已废弃，直接执行
    XBoardLogger.info('执行节点切换后的延迟测试: ${currentProxy.name}');
    testCurrentNode(forceTest: true);
  }
  void onConnectionStatusChanged(bool isConnected) {
    if (isConnected) {
      XBoardLogger.info('代理连接成功，将自动测试当前节点');
      Timer(const Duration(milliseconds: 1500), () {
        if (_ensureServiceActive() && _isRefValid()) {
          testCurrentNode(forceTest: true);
          Timer(const Duration(seconds: 2), () {
            if (_ensureServiceActive() && _isRefValid()) {
              testCurrentGroupNodes(maxNodes: 3);
            }
          });
        }
      });
    } else {
      XBoardLogger.info('代理连接断开');
    }
  }
  void _startPeriodicTesting() {
    _periodicTimer?.cancel();
    _periodicTimer = Timer.periodic(
      const Duration(minutes: _periodicIntervalMinutes),
      (_) {
        _performPeriodicTest();
      },
    );
  }

  Future<void> _performPeriodicTest() async {
    if (!_ensureServiceActive()) {
      XBoardLogger.warning('服务状态检查失败，跳过定期测试');
      return;
    }
    
    try {
      XBoardLogger.info('执行定期延迟测试');
      _cleanExpiredCache();
      
      await testCurrentNode();
      
      final randomDelay = Random().nextInt(30) + 10;
      Timer(Duration(seconds: randomDelay), () {
        if (_ensureServiceActive()) {
          testCurrentGroupNodes(maxNodes: 3);
        }
      });
    } catch (e) {
      XBoardLogger.error('定期测试执行失败', e);
      if (e.toString().contains('disposed') || e.toString().contains('invalid')) {
        XBoardLogger.warning('检测到状态异常，重置服务状态');
        _ref = null;
      }
    }
  }
  bool _shouldTestProxy(String proxyName) {
    final lastTestTime = _proxyTestCache[proxyName];
    if (lastTestTime == null) {
      return true;
    }
    final now = DateTime.now();
    final timeSinceLastTest = now.difference(lastTestTime);
    final shouldTest = timeSinceLastTest.inMinutes >= _cacheMinutes;
    if (!shouldTest) {
      XBoardLogger.debug('代理 $proxyName 缓存有效，距上次测试 ${timeSinceLastTest.inSeconds}s');
    }
    return shouldTest;
  }
  bool _isRefValid() {
    if (_ref == null) return false;
    try {
      _ref!.read(groupsProvider);
      return true;
    } catch (e) {
      if (e.toString().contains('disposed')) {
        XBoardLogger.warning('检测到ref已disposed，清理服务状态');
        _ref = null;
        return false;
      }
      return true;
    }
  }
  Proxy? _getCurrentSelectedProxy() {
    if (_ref == null || !_isRefValid()) {
      XBoardLogger.warning('ref无效，无法获取当前代理');
      return null;
    }
    try {
      final groups = _ref!.read(groupsProvider);
      final selectedMap = _ref!.read(selectedMapProvider);
      final mode = _ref!.read(patchClashConfigProvider.select((state) => state.mode));
      if (groups.isEmpty) {
        XBoardLogger.debug('代理组为空，无法获取当前代理');
        return null;
      }
      XBoardLogger.debug('当前模式: $mode, 组数量: ${groups.length}', null);
      
      Group? currentGroup = _findCurrentGroup(groups, selectedMap, mode);
      if (currentGroup == null || currentGroup.all.isEmpty) {
        XBoardLogger.debug('当前组为空或无代理节点');
        return null;
      }
      
      XBoardLogger.debug('找到当前组: ${currentGroup.name}, 类型: ${currentGroup.type}, 节点数: ${currentGroup.all.length}', null);
      
      Proxy? selectedProxy = _getSelectedProxyFromGroup(currentGroup, selectedMap, groups);
      if (selectedProxy != null) {
        XBoardLogger.debug('最终选中的代理: ${selectedProxy.name}');
        return selectedProxy;
      }
      
      final fallbackProxy = currentGroup.all.first;
      XBoardLogger.debug('使用备用代理: ${fallbackProxy.name}');
      return fallbackProxy;
    } catch (e) {
      XBoardLogger.error('获取当前代理失败', e);
      return null;
    }
  }

  Group? _findCurrentGroup(List<Group> groups, Map<String, String> selectedMap, Mode mode) {
    if (mode == Mode.global) {
      return groups.firstWhere(
        (group) => group.name == GroupName.GLOBAL.name,
        orElse: () => groups.first,
      );
    } else if (mode == Mode.rule) {
      for (final group in groups) {
        if (group.hidden == true || group.name == GroupName.GLOBAL.name) continue;
        final selectedProxyName = selectedMap[group.name];
        if (selectedProxyName != null && selectedProxyName.isNotEmpty) {
          final referencedGroup = groups.where((g) => g.name == selectedProxyName).firstOrNull;
          if (referencedGroup != null && referencedGroup.type == GroupType.URLTest) {
            return referencedGroup;
          }
          return group;
        }
      }
      return groups.where(
        (group) => group.hidden != true && group.name != GroupName.GLOBAL.name,
      ).firstOrNull ?? groups.first;
    }
    return null;
  }

  Proxy? _getSelectedProxyFromGroup(Group group, Map<String, String> selectedMap, List<Group> allGroups) {
    final selectedProxyName = selectedMap[group.name] ?? "";
    XBoardLogger.debug('组 ${group.name} 的选中代理: $selectedProxyName');
    
    String realNodeName = "";
    
    if (group.type == GroupType.URLTest || group.type == GroupType.Fallback) {
      realNodeName = group.now?.isNotEmpty == true ? group.now! : "";
      if (realNodeName.isEmpty && group.all.isNotEmpty) {
        realNodeName = group.all.first.name;
        XBoardLogger.debug('${group.type}组now为空，使用第一个节点: $realNodeName');
      }
      XBoardLogger.debug('${group.type}组当前节点: $realNodeName');
    } else {
      if (selectedProxyName.isNotEmpty) {
        final referencedGroup = allGroups.where((g) => g.name == selectedProxyName).firstOrNull;
        if (referencedGroup != null) {
          return _getSelectedProxyFromGroup(referencedGroup, selectedMap, allGroups);
        } else {
          final realName = group.getCurrentSelectedName(selectedProxyName);
          if (realName != selectedProxyName && group.all.any((p) => p.name == realName)) {
            realNodeName = realName;
          } else if (group.all.any((p) => p.name == selectedProxyName)) {
            realNodeName = selectedProxyName;
          } else {
            realNodeName = group.all.isNotEmpty ? group.all.first.name : "";
            XBoardLogger.debug('选中的代理不存在，使用默认节点: $realNodeName');
          }
        }
      } else {
        realNodeName = group.all.isNotEmpty ? group.all.first.name : "";
        XBoardLogger.debug('未选择代理，使用默认节点: $realNodeName');
      }
      XBoardLogger.debug('Selector组当前节点: $realNodeName');
    }
    
    if (realNodeName.isNotEmpty && group.all.any((p) => p.name == realNodeName)) {
      final proxy = group.all.firstWhere((proxy) => proxy.name == realNodeName);
      final isRealProxy = !allGroups.any((g) => g.name == realNodeName);
      if (isRealProxy) {
        XBoardLogger.debug('找到真实代理节点: ${proxy.name}');
        return proxy;
      } else {
        XBoardLogger.debug('节点 $realNodeName 是组引用，递归查找真实节点');
        final referencedGroup = allGroups.firstWhere((g) => g.name == realNodeName);
        return _getSelectedProxyFromGroup(referencedGroup, selectedMap, allGroups);
      }
    }
    
    XBoardLogger.debug('未找到有效的代理节点');
    return null;
  }
  Group? _getCurrentGroup() {
    if (_ref == null || !_isRefValid()) return null;
    try {
      final groups = _ref!.read(groupsProvider);
      final selectedMap = _ref!.read(selectedMapProvider);
      final mode = _ref!.read(patchClashConfigProvider.select((state) => state.mode));
      if (groups.isEmpty) return null;
      if (mode == Mode.global) {
        return groups.firstWhere(
          (group) => group.name == GroupName.GLOBAL.name,
          orElse: () => groups.first,
        );
      } else if (mode == Mode.rule) {
        for (final group in groups) {
          if (group.hidden == true) continue;
          if (group.name == GroupName.GLOBAL.name) continue;
          final selectedProxyName = selectedMap[group.name];
          if (selectedProxyName != null && selectedProxyName.isNotEmpty) {
            return group;
          }
        }
        return groups.firstWhere(
          (group) => group.hidden != true && group.name != GroupName.GLOBAL.name,
          orElse: () => groups.first,
        );
      }
      return null;
    } catch (e) {
      XBoardLogger.error('获取当前组失败', e);
      return null;
    }
  }
}
final autoLatencyService = AutoLatencyService();