import 'package:onepartner/library_import.dart';

class AppBarAction {
  const AppBarAction({
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.color,
    this.badgeValue,
    this.showBadgeZero = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final Color? color;
  final int? badgeValue;
  final bool showBadgeZero;
}