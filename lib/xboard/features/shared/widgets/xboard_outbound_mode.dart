import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fl_clash/xboard/services/services.dart';
import 'package:fl_clash/xboard/core/core.dart';
import 'tun_introduction_dialog.dart';
import 'package:fl_clash/l10n/l10n.dart';
class XBoardOutboundMode extends StatelessWidget {
  const XBoardOutboundMode({super.key});
  void _handleModeChange(WidgetRef ref, Mode modeOption) {
    XBoardLogger.debug('[XBoardOutboundMode] 切换模式到: $modeOption');
    globalState.appController.changeMode(modeOption);
    if (modeOption == Mode.global) {
      XBoardLogger.debug('[XBoardOutboundMode] 切换到全局模式，执行自动节点选择');
      Future.delayed(const Duration(milliseconds: 100), () {
        _selectValidProxyForGlobalMode(ref);
      });
    }
  }
  Future<void> _handleTunToggle(BuildContext context, WidgetRef ref, bool selected) async {
    if (selected) {
      final storageService = ref.read(storageServiceProvider);
      final hasShownResult = await storageService.hasTunFirstUseShown();
      final hasShown = hasShownResult.dataOrNull ?? false;
      if (!hasShown) {
        if (context.mounted) {
          final shouldEnable = await TunIntroductionDialog.show(context);
          if (shouldEnable == true) {
            await storageService.markTunFirstUseShown();
            ref.read(patchClashConfigProvider.notifier).updateState(
                  (state) => state.copyWith.tun(enable: true),
                );
          }
        }
      } else {
        ref.read(patchClashConfigProvider.notifier).updateState(
              (state) => state.copyWith.tun(enable: true),
            );
      }
    } else {
      ref.read(patchClashConfigProvider.notifier).updateState(
            (state) => state.copyWith.tun(enable: false),
          );
    }
  }
  void _selectValidProxyForGlobalMode(WidgetRef ref) {
    XBoardLogger.debug('[XBoardOutboundMode] 开始选择有效代理节点');
    final groups = ref.read(groupsProvider);
    if (groups.isEmpty) {
      XBoardLogger.debug('[XBoardOutboundMode] 没有可用的代理组');
      return;
    }
    final globalGroup = groups.firstWhere(
      (group) => group.name == GroupName.GLOBAL.name,
      orElse: () => groups.first,
    );
    XBoardLogger.debug('[XBoardOutboundMode] 找到全局组: ${globalGroup.name}, 节点数: ${globalGroup.all.length}');
    if (globalGroup.all.isEmpty) {
      XBoardLogger.debug('[XBoardOutboundMode] 全局组没有可用节点');
      return;
    }
    Proxy? validProxy;
    for (final proxy in globalGroup.all) {
      XBoardLogger.debug('[XBoardOutboundMode] 检查节点: ${proxy.name}');
      if (proxy.name.toUpperCase() != 'DIRECT' && 
          proxy.name.toLowerCase() != 'direct' &&
          proxy.name.toUpperCase() != 'REJECT') {
        validProxy = proxy;
        XBoardLogger.debug('[XBoardOutboundMode] 选择有效代理节点: ${proxy.name}');
        break;
      }
    }
    if (validProxy != null) {
      XBoardLogger.debug('[XBoardOutboundMode] 设置选中代理: ${validProxy.name}');
      globalState.appController.updateCurrentSelectedMap(
        globalGroup.name,
        validProxy.name,
      );
      XBoardLogger.debug('[XBoardOutboundMode] 代理节点设置完成');
    } else {
      XBoardLogger.debug('[XBoardOutboundMode] 没有找到有效的代理节点');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final mode = ref.watch(patchClashConfigProvider.select((state) => state.mode));
        final tunEnabled = ref.watch(patchClashConfigProvider.select((state) => state.tun.enable));
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.tune,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppLocalizations.of(context).xboardProxyMode,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: FilterChip(
                        label: Text(Intl.message(Mode.rule.name)),
                        selected: mode == Mode.rule,
                        onSelected: (selected) {
                          if (selected) {
                            _handleModeChange(ref, Mode.rule);
                          }
                        },
                        selectedColor: Theme.of(context).colorScheme.primaryContainer,
                        checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        labelStyle: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: FilterChip(
                        label: Text(Intl.message(Mode.global.name)),
                        selected: mode == Mode.global,
                        onSelected: (selected) {
                          if (selected) {
                            _handleModeChange(ref, Mode.global);
                          }
                        },
                        selectedColor: Theme.of(context).colorScheme.primaryContainer,
                        checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        labelStyle: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: FilterChip(
                        label: const Text("TUN"),
                        selected: tunEnabled,
                        onSelected: (selected) {
                          _handleTunToggle(context, ref, selected);
                        },
                        selectedColor: Colors.green.withValues(alpha: 0.2),
                        checkmarkColor: Colors.green.shade700,
                        side: tunEnabled
                            ? BorderSide(color: Colors.green.shade300, width: 1)
                            : null,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        labelStyle: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                _getModeDescription(mode, tunEnabled, context),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  String _getModeDescription(Mode mode, bool tunEnabled, BuildContext context) {
    final tunStatus = tunEnabled ? ' | ${AppLocalizations.of(context).xboardTunEnabled}' : '';
    switch (mode) {
      case Mode.rule:
        return '${AppLocalizations.of(context).xboardProxyModeRuleDescription}$tunStatus';
      case Mode.global:
        return '${AppLocalizations.of(context).xboardProxyModeGlobalDescription}$tunStatus';
      case Mode.direct:
        return '${AppLocalizations.of(context).xboardProxyModeDirectDescription}$tunStatus';
    }
  }
}