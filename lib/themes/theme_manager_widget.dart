/// 主题管理器Widget
/// 用于在应用中管理和切换主题
library;

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 主题包配置
class ThemePackageConfig {
  final String id;
  final String name;
  final String description;
  final ThemeData Function(BuildContext context, {int? primaryColor}) lightThemeBuilder;
  final ThemeData Function(BuildContext context, {int? primaryColor}) darkThemeBuilder;

  const ThemePackageConfig({
    required this.id,
    required this.name,
    required this.description,
    required this.lightThemeBuilder,
    required this.darkThemeBuilder,
  });
}

/// 主题管理器
class AppThemeManager {
  static const String _storageKey = 'app_theme_package_id';
  static const String _defaultThemeId = 'default';

  /// 所有可用的主题包
  static final List<ThemePackageConfig> availableThemes = [];

  /// 注册主题包
  static void registerTheme(ThemePackageConfig theme) {
    // 检查是否已存在
    final existingIndex = availableThemes.indexWhere((t) => t.id == theme.id);
    if (existingIndex >= 0) {
      availableThemes[existingIndex] = theme;
      debugPrint('[AppThemeManager] 主题已更新: ${theme.name}');
    } else {
      availableThemes.add(theme);
      debugPrint('[AppThemeManager] 主题已注册: ${theme.name}');
    }
  }

  /// 获取当前主题ID
  static Future<String> getCurrentThemeId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_storageKey) ?? _defaultThemeId;
    } catch (e) {
      debugPrint('[AppThemeManager] 获取主题ID失败: $e');
      return _defaultThemeId;
    }
  }

  /// 设置当前主题
  static Future<void> setCurrentThemeId(String themeId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, themeId);
      debugPrint('[AppThemeManager] 主题已切换: $themeId');
    } catch (e) {
      debugPrint('[AppThemeManager] 设置主题失败: $e');
    }
  }

  /// 根据ID获取主题包
  static ThemePackageConfig? getThemeById(String id) {
    try {
      return availableThemes.firstWhere((theme) => theme.id == id);
    } catch (e) {
      return null;
    }
  }

  /// 获取当前主题包
  static Future<ThemePackageConfig> getCurrentTheme() async {
    final id = await getCurrentThemeId();
    return getThemeById(id) ?? availableThemes.first;
  }
}

/// 主题包选择器Provider
final currentThemePackageIdProvider = StateProvider<String>((ref) => 'default');

/// 当前主题包Provider
final currentThemePackageProvider = Provider<ThemePackageConfig?>((ref) {
  final themeId = ref.watch(currentThemePackageIdProvider);
  return AppThemeManager.getThemeById(themeId);
});

/// 主题数据Provider - 亮色主题
final lightThemeProvider = Provider.family<ThemeData, BuildContext>((ref, context) {
  final themePackage = ref.watch(currentThemePackageProvider);
  final primaryColor = ref.watch(
    themeSettingProvider.select((state) => state.primaryColor),
  );

  if (themePackage == null) {
    // 降级到默认主题
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor != null ? Color(primaryColor) : const Color(0xFF554DAF),
        brightness: Brightness.light,
      ),
    );
  }

  return themePackage.lightThemeBuilder(context, primaryColor: primaryColor);
});

/// 主题数据Provider - 暗色主题
final darkThemeProvider = Provider.family<ThemeData, BuildContext>((ref, context) {
  final themePackage = ref.watch(currentThemePackageProvider);
  final primaryColor = ref.watch(
    themeSettingProvider.select((state) => state.primaryColor),
  );

  if (themePackage == null) {
    // 降级到默认主题
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor != null ? Color(primaryColor) : const Color(0xFF554DAF),
        brightness: Brightness.dark,
      ),
    );
  }

  return themePackage.darkThemeBuilder(context, primaryColor: primaryColor);
});

/// 主题包选择器Widget
class ThemePackageSelector extends ConsumerWidget {
  const ThemePackageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeId = ref.watch(currentThemePackageIdProvider);
    final themes = AppThemeManager.availableThemes;

    if (themes.isEmpty) {
      return const ListTile(
        leading: Icon(Icons.palette),
        title: Text('主题包'),
        subtitle: Text('没有可用的主题包'),
      );
    }

    return ListTile(
      leading: const Icon(Icons.palette),
      title: const Text('主题包'),
      subtitle: Text(
        AppThemeManager.getThemeById(currentThemeId)?.name ?? '默认主题',
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final selected = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('选择主题包'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: themes.length,
                itemBuilder: (context, index) {
                  final theme = themes[index];
                  final isSelected = theme.id == currentThemeId;

                  return RadioListTile<String>(
                    value: theme.id,
                    groupValue: currentThemeId,
                    title: Text(theme.name),
                    subtitle: Text(theme.description),
                    selected: isSelected,
                    onChanged: (value) {
                      Navigator.of(context).pop(value);
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('取消'),
              ),
            ],
          ),
        );

        if (selected != null && selected != currentThemeId) {
          await AppThemeManager.setCurrentThemeId(selected);
          ref.read(currentThemePackageIdProvider.notifier).state = selected;
        }
      },
    );
  }
}

