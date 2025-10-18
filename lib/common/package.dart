import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

import 'common.dart';

extension PackageInfoExtension on PackageInfo {
  String get ua => [
        "$appNameEn/v$version", // 使用英文名称避免HTTP头中文字符问题
        "clash-verge",
        "Platform/${Platform.operatingSystem}",
      ].join(" ");
}
