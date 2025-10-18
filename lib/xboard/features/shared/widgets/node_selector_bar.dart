import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/proxies/proxies.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/xboard/features/latency/services/auto_latency_service.dart';
import 'package:fl_clash/xboard/features/latency/widgets/latency_indicator.dart';
import 'package:fl_clash/l10n/l10n.dart';
class NodeSelectorBar extends ConsumerStatefulWidget {
  const NodeSelectorBar({super.key});
  @override
  ConsumerState<NodeSelectorBar> createState() => _NodeSelectorBarState();
}
class _NodeSelectorBarState extends ConsumerState<NodeSelectorBar> {
  String? _lastProxyName;
  bool _isFirstBuild = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoLatencyService.initialize(ref);
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          autoLatencyService.testCurrentNode();
        }
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final groups = ref.watch(groupsProvider);
    final selectedMap = ref.watch(selectedMapProvider);
    final mode = ref.watch(patchClashConfigProvider.select((state) => state.mode));
    ref.listen(runTimeProvider, (previous, next) {
      final wasConnected = previous != null;
      final isConnected = next != null;
      if (wasConnected != isConnected) {
        autoLatencyService.onConnectionStatusChanged(isConnected);
      }
    });
    ref.listen(selectedMapProvider, (previous, next) {
      if (previous != null && next != previous) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            autoLatencyService.onNodeChanged();
          }
        });
      }
    });
    if (groups.isEmpty) {
      return _buildEmptyState(context);
    }
    Group? currentGroup;
    Proxy? currentProxy;
    if (mode == Mode.global) {
      currentGroup = groups.firstWhere(
        (group) => group.name == GroupName.GLOBAL.name,
        orElse: () => groups.first,
      );
    } else if (mode == Mode.rule) {
      for (final group in groups) {
        if (group.hidden == true) continue;
        if (group.name == GroupName.GLOBAL.name) continue;
        final selectedProxyName = selectedMap[group.name];
        if (selectedProxyName != null && selectedProxyName.isNotEmpty) {
          final referencedGroup = groups.firstWhere(
            (g) => g.name == selectedProxyName,
            orElse: () => group, // 如果没找到引用的组，就使用当前组
          );
          if (referencedGroup.name == selectedProxyName && referencedGroup.type == GroupType.URLTest) {
            currentGroup = referencedGroup;
            break;
          } else {
            currentGroup = group;
            break;
          }
        }
      }
      if (currentGroup == null) {
        currentGroup = groups.firstWhere(
          (group) => group.hidden != true && group.name != GroupName.GLOBAL.name,
          orElse: () => groups.first,
        );
        if (currentGroup.now != null && currentGroup.now!.isNotEmpty) {
          final nowValue = currentGroup.now!;
          final referencedGroup = groups.firstWhere(
            (g) => g.name == nowValue,
            orElse: () => currentGroup!,
          );
          if (referencedGroup.name == nowValue && referencedGroup.type == GroupType.URLTest) {
            currentGroup = referencedGroup;
          }
        }
      }
    }
    if (currentGroup == null || currentGroup.all.isEmpty) {
      return _buildEmptyState(context);
    }
    final selectedProxyName = selectedMap[currentGroup.name] ?? "";
    String realNodeName;
    if (currentGroup.type == GroupType.URLTest) {
      realNodeName = currentGroup.now ?? "";
    } else {
      realNodeName = currentGroup.getCurrentSelectedName(selectedProxyName);
    }
    if (realNodeName.isNotEmpty) {
      currentProxy = currentGroup.all.firstWhere(
        (proxy) => proxy.name == realNodeName,
        orElse: () => currentGroup!.all.first,
      );
    } else {
      currentProxy = currentGroup.all.first;
    }
    _checkNodeChange(currentProxy);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _buildProxyDisplay(context, currentGroup, currentProxy),
    );
  }
  Widget _buildProxyDisplay(BuildContext context, Group group, Proxy proxy) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CommonScaffold(
                title: AppLocalizations.of(context).xboardProxy,
                body: const ProxiesView(),
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.router,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      proxy.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    _buildProxyLatency(proxy),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommonScaffold(
                        title: AppLocalizations.of(context).xboardProxy,
                        body: const ProxiesView(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  minimumSize: const Size(56, 30),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context).xboardSwitch,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildProxyLatency(Proxy proxy) {
    final delayState = ref.watch(getDelayProvider(
      proxyName: proxy.name,
      testUrl: ref.read(appSettingProvider).testUrl,
    ));
    return LatencyIndicator(
      delayValue: delayState,
      onTap: () => _handleManualTest(proxy),
      showIcon: true,
    );
  }
  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.wifi_off,
                color: Theme.of(context).colorScheme.onErrorContainer,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).xboardNoAvailableNodes,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppLocalizations.of(context).xboardClickToSetupNodes,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommonScaffold(
                      title: AppLocalizations.of(context).xboardProxy,
                      body: const ProxiesView(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(56, 30),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                AppLocalizations.of(context).xboardSetup,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _checkNodeChange(Proxy currentProxy) {
    if (_isFirstBuild) {
      _lastProxyName = currentProxy.name;
      _isFirstBuild = false;
      return;
    }
    if (_lastProxyName != currentProxy.name) {
      _lastProxyName = currentProxy.name;
      autoLatencyService.onNodeChanged();
    }
  }
  void _handleManualTest(Proxy proxy) {
    autoLatencyService.testProxy(proxy, forceTest: true);
  }
}