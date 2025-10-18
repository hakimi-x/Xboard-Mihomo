import 'package:flutter/material.dart';

/// 带未读数标记的图标组件
class BadgeIcon extends StatelessWidget {
  final Widget icon;
  final int count;
  final bool showZero;
  final Color? badgeColor;
  final Color? textColor;
  final double? badgeSize;

  const BadgeIcon({
    super.key,
    required this.icon,
    this.count = 0,
    this.showZero = false,
    this.badgeColor,
    this.textColor,
    this.badgeSize,
  });

  @override
  Widget build(BuildContext context) {
    final shouldShowBadge = count > 0 || (showZero && count == 0);

    if (!shouldShowBadge) {
      return icon;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        Positioned(
          right: -4,
          top: -4,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: badgeColor ?? Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: BoxConstraints(
              minWidth: badgeSize ?? 16,
              minHeight: badgeSize ?? 16,
            ),
            child: count > 0
                ? Text(
                    count > 99 ? '99+' : count.toString(),
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
