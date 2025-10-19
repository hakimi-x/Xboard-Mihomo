/// UI主题设置区域
/// 
/// 用于设置页面的UI主题选择部分

import 'package:fl_clash/core/providers/ui_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UIThemeSettingsSection extends ConsumerWidget {
  const UIThemeSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(uiThemeProvider);
    final themeNotifier = ref.read(uiThemeProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'UI 外观',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.palette_outlined),
                title: const Text('UI 主题'),
                subtitle: Text(themeNotifier.getThemeDisplayName(currentTheme)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showThemeSelector(context, ref),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('关于主题'),
                subtitle: Text(
                  themeNotifier.getThemeDescription(currentTheme),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showThemeSelector(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(uiThemeProvider.notifier);
    final currentTheme = ref.read(uiThemeProvider);
    final availableThemes = themeNotifier.availableThemes;

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    '选择 UI 主题',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            ...availableThemes.map((themeId) {
              final isSelected = themeId == currentTheme;
              return ListTile(
                leading: Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isSelected ? Theme.of(context).colorScheme.primary : null,
                ),
                title: Text(themeNotifier.getThemeDisplayName(themeId)),
                subtitle: Text(themeNotifier.getThemeDescription(themeId)),
                selected: isSelected,
                onTap: () async {
                  // 切换主题
                  await themeNotifier.setTheme(themeId);
                  
                  if (context.mounted) {
                    Navigator.pop(context);
                    
                    // 显示提示
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('已切换到${themeNotifier.getThemeDisplayName(themeId)}'),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: '重启应用生效',
                          onPressed: () {
                            // TODO: 重启应用或重新构建
                          },
                        ),
                      ),
                    );
                  }
                },
              );
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

