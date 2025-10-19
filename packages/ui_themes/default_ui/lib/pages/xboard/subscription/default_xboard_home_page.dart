// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI XBoard首页
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/xboard/features/shared/shared.dart';
import 'package:fl_clash/xboard/features/subscription/widgets/subscription_usage_card.dart';
import 'package:fl_clash/xboard/features/subscription/widgets/xboard_connect_button.dart';
import 'package:fl_clash/xboard/features/auth/providers/xboard_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultXBoardHomePage extends XBoardHomePageContract {
  const DefaultXBoardHomePage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        ref.listenManual(
          isCurrentPageProvider(PageLabel.xboard),
          (prev, next) {
            if (prev != next && next == true) {
              // 页面激活时的逻辑
            }
          },
          fireImmediately: true,
        );

        // 获取屏幕高度并计算自适应间距
        final screenHeight = MediaQuery.of(context).size.height;
        final appBarHeight = kToolbarHeight;
        final statusBarHeight = MediaQuery.of(context).padding.top;
        final bottomNavHeight = 60.0; // 底部导航栏高度
        final availableHeight = screenHeight - appBarHeight - statusBarHeight - bottomNavHeight;

        // 根据可用高度调整间距
        double sectionSpacing;
        double verticalPadding;
        double horizontalPadding;

        if (availableHeight < 500) {
          // 小屏幕：紧凑布局
          sectionSpacing = 8.0;
          verticalPadding = 8.0;
          horizontalPadding = 12.0;
        } else if (availableHeight < 650) {
          // 中等屏幕：适中布局
          sectionSpacing = 10.0;
          verticalPadding = 10.0;
          horizontalPadding = 16.0;
        } else {
          // 大屏幕：标准布局
          sectionSpacing = 14.0;
          verticalPadding = 12.0;
          horizontalPadding = 16.0;
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                Theme.of(context).colorScheme.surface,
              ],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: verticalPadding),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - (2 * verticalPadding),
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const NoticeBanner(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: _buildUsageSection(ref),
                          ),
                          SizedBox(height: sectionSpacing),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: _buildProxyModeSection(),
                          ),
                          SizedBox(height: sectionSpacing),
                          const NodeSelectorBar(),
                          SizedBox(height: sectionSpacing),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: _buildConnectionSection(),
                          ),
                          // 添加弹性空间，确保内容不会太紧凑
                          if (availableHeight > 600) const Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildUsageSection(WidgetRef ref) {
    final userInfo = ref.userInfo;
    final subscriptionInfo = ref.subscriptionInfo;
    final currentProfile = ref.watch(currentProfileProvider);
    
    return SubscriptionUsageCard(
      subscriptionInfo: subscriptionInfo,
      userInfo: userInfo,
      profileSubscriptionInfo: currentProfile?.subscriptionInfo,
    );
  }

  Widget _buildConnectionSection() {
    return const XBoardConnectButton(isFloating: false);
  }

  Widget _buildProxyModeSection() {
    return const XBoardOutboundMode();
  }
}
