import 'package:flutter/material.dart';
class XBCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool isSelected;
  final double? elevation;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  const XBCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.isSelected = false,
    this.elevation,
    this.backgroundColor,
    this.borderRadius,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final defaultBorderRadius = BorderRadius.circular(16);
    return Container(
      margin: margin,
      child: Material(
        elevation: elevation ?? (isSelected ? 4 : 2),
        borderRadius: borderRadius ?? defaultBorderRadius,
        color: backgroundColor ?? 
               (isSelected 
                 ? colorScheme.primaryContainer 
                 : colorScheme.surfaceContainer),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? defaultBorderRadius,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? defaultBorderRadius,
              border: isSelected
                  ? Border.all(
                      color: colorScheme.primary,
                      width: 2,
                    )
                  : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}