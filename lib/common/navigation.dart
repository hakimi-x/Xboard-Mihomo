import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
// import 'package:fl_clash/views/views.dart';
import 'package:fl_clash/xboard/features/payment/pages/plans.dart';
import 'package:fl_clash/xboard/features/subscription/pages/xboard_home_page.dart';
import 'package:fl_clash/xboard/features/online_support/pages/online_support_page.dart';
import 'package:fl_clash/xboard/features/online_support/providers/chat_provider.dart';
import 'package:fl_clash/xboard/features/invite/pages/invite_page.dart';
import 'package:fl_clash/xboard/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Navigation {
  static Navigation? _instance;

  List<NavigationItem> getItems({
    bool openLogs = false,
    bool hasProxies = false,
  }) {
    return [
      // 暂时隐藏其他页面，只保留指定的几个页面
      // const NavigationItem(
      //   keep: false,
      //   icon: Icon(Icons.space_dashboard),
      //   label: PageLabel.dashboard,
      //   view: DashboardView(
      //     key: GlobalObjectKey(PageLabel.dashboard),
      //   ),
      //   modes: [], // 暂时隐藏
      // ),
      const NavigationItem(
        icon: Icon(Icons.home),
        label: PageLabel.xboard,
        view: XBoardHomePage(
          key: GlobalObjectKey(
            PageLabel.xboard,
          ),
        ),
        modes: [NavigationItemMode.desktop, NavigationItemMode.mobile],
      ),
      const NavigationItem(
        icon: Icon(Icons.shopping_cart),
        label: PageLabel.plans,
        view: PlansView(
          key: GlobalObjectKey(
            PageLabel.plans,
          ),
        ),
        modes: [NavigationItemMode.desktop],
      ),
      const NavigationItem(
        icon: Icon(Icons.support_agent),
        label: PageLabel.onlineSupport,
        view: OnlineSupportPage(
          key: GlobalObjectKey(
            PageLabel.onlineSupport,
          ),
        ),
        modes: [NavigationItemMode.desktop], // 桌面端显示
      ),
      const NavigationItem(
        icon: Icon(Icons.people),
        label: PageLabel.invite,
        view: InvitePage(
          key: GlobalObjectKey(
            PageLabel.invite,
          ),
        ),
        modes: [NavigationItemMode.desktop, NavigationItemMode.mobile], // 桌面端和手机端都显示
      ),
      // TODO: 个人中心页面占位 - 待开发
      // const NavigationItem(
      //   icon: Icon(Icons.person),
      //   label: PageLabel.userCenter,
      //   view: UserCenterPage(
      //     key: GlobalObjectKey(
      //       PageLabel.userCenter,
      //     ),
      //   ),
      //   modes: [NavigationItemMode.desktop],
      // ),
    ];
  }

  Navigation._internal();

  factory Navigation() {
    _instance ??= Navigation._internal();
    return _instance!;
  }
}

final navigation = Navigation();
