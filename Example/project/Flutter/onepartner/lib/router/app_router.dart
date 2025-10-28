
import 'package:onepartner/utils/imports.dart';
import 'package:onepartner/views/home/home_page.dart';
import 'package:onepartner/views/settings/setting_page.dart';
import 'package:onepartner/views/common/profile_page.dart';
import 'package:onepartner/views/login/login_page.dart';
import 'package:onepartner/views/tabbar/tabs_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/home'),
    AutoRoute(page: ProfileRoute.page, path: '/profile'),
    AutoRoute(page: SettingsRoute.page, path: '/setting'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: TabsRoute.page, path: '/tabs'),


  ];
}