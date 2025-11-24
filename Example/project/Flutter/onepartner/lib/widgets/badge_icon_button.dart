import 'package:flutter/material.dart';

class BadgeIconButton extends StatelessWidget {
  const BadgeIconButton({
    super.key,
    required this.icon,
    required this.value,
    this.onPressed,
    this.badgeColor = Colors.red,
    this.badgeTextColor = Colors.white,
    this.top = 8,
    this.right = 8,
    this.badgePadding = const EdgeInsets.all(2),
    this.badgeBorderRadius = const BorderRadius.all(Radius.circular(10)),
    this.badgeConstraints = const BoxConstraints(minWidth: 16, minHeight: 16),
    this.textStyle,
    this.showZero = false,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final int value;

  final Color badgeColor;
  final Color badgeTextColor;
  final double top;
  final double right;
  final EdgeInsets badgePadding;
  final BorderRadius badgeBorderRadius;
  final BoxConstraints badgeConstraints;
  final TextStyle? textStyle;
  final bool showZero;

  @override
  Widget build(BuildContext context) {
    final shouldShowBadge = showZero ? true : value > 0;
    return Stack(
      children: [
        IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
        if (shouldShowBadge)
          Positioned(
            right: right,
            top: top,
            child: Container(
              padding: badgePadding,
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: badgeBorderRadius,
              ),
              constraints: badgeConstraints,
              child: Text(
                '$value',
                style: textStyle ?? TextStyle(color: badgeTextColor, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}