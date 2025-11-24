import 'package:onepartner/library_import.dart';
import 'package:onepartner/widgets/app_bar_action.dart';
import 'package:onepartner/widgets/badge_icon_button.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    Key? key,
    required this.title,
    this.actions,
    this.appBar,
    this.header,
    required this.middle,
    this.footer,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  /// 导航栏标题
  final String title;

  /// 导航栏右侧 actions（可选，使用 AppBarAction 列表维护）
  final List<AppBarAction>? actions;

  /// 自定义 AppBar（可选，传入后优先使用）
  final PreferredSizeWidget? appBar;

  /// 页面头部（可选）
  final Widget? header;

  /// 页面中间内容（必传）
  final Widget middle;

  /// 页面底部（可选）
  final Widget? footer;

  /// Scaffold 背景色（可选）
  final Color? backgroundColor;

  /// Scaffold 是否避免底部输入法遮挡（可选）
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar ?? AppBar(
        title: Text(title),
        actions: actions
            ?.map((a) {
              final iconWidget = Icon(a.icon, color: a.color);
              Widget button = BadgeIconButton(
                icon: iconWidget,
                value: a.badgeValue ?? 0,
                onPressed: a.onPressed,
                showZero: a.showBadgeZero,
              );
              if (a.badgeValue != null && a.tooltip != null) {
                button = Tooltip(message: a.tooltip!, child: button);
              }
              return button;
            })
            .toList(),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (header != null) header!,
            Expanded(child: middle),
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}