import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/xboard/features/invite/dialogs/theme_dialog.dart';
import 'package:fl_clash/xboard/features/invite/dialogs/logout_dialog.dart';
import 'package:fl_clash/xboard/features/ticket/pages/ticket_list_page.dart';
import 'package:fl_clash/xboard/features/shared/shared.dart';

class UserCenterPage extends ConsumerStatefulWidget {
  const UserCenterPage({super.key});

  @override
  ConsumerState<UserCenterPage> createState() => _UserCenterPageState();
}

class _UserCenterPageState extends ConsumerState<UserCenterPage> with PageMixin {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        ref.listenManual(
          isCurrentPageProvider(PageLabel.userCenter),
          (prev, next) {
            if (prev != next && next == true) {
              initPageState();
            }
          },
          fireImmediately: true,
        );

        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 设置列表
                _buildSettingsList(context, ref),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsList(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeSettingProvider.select((state) => state.themeMode));
    
    String getThemeModeName(ThemeMode mode) {
      switch (mode) {
        case ThemeMode.system:
          return appLocalizations.auto;
        case ThemeMode.light:
          return appLocalizations.light;
        case ThemeMode.dark:
          return appLocalizations.dark;
      }
    }

    return XBCard(
      child: Column(
        children: [
          // 工单系统
          ListTile(
            leading: Icon(
              Icons.support_agent,
              color: context.colorScheme.primary,
            ),
            title: const Text('工单系统'),
            subtitle: const Text('提交问题反馈'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TicketListPage(),
                ),
              );
            },
          ),
          Divider(
            height: 1,
            indent: 56,
            color: context.colorScheme.outlineVariant,
          ),
          
          // 主题设置
          ListTile(
            leading: Icon(
              Icons.brightness_6,
              color: context.colorScheme.primary,
            ),
            title: Text(appLocalizations.switchTheme),
            subtitle: Text(getThemeModeName(currentThemeMode)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const ThemeDialog(),
              );
            },
          ),
          Divider(
            height: 1,
            indent: 56,
            color: context.colorScheme.outlineVariant,
          ),
          
          // 登出按钮
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              appLocalizations.logout,
              style: const TextStyle(color: Colors.red),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.red,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const LogoutDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}

