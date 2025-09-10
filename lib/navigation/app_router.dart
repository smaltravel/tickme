import 'package:auto_route/auto_route.dart';
import 'package:tickme/views/screens/categories_screen.dart';
import 'package:tickme/views/screens/main_screen.dart';
import 'package:tickme/views/screens/analytics_screen.dart';
import 'package:tickme/views/screens/settings_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: MainRoute.page,
          initial: true,
          children: <AutoRoute>[
            AutoRoute(
              path: 'categories',
              page: CategoriesTab.page,
              initial: true,
            ),
            AutoRoute(
              path: 'analytics',
              page: AnalyticsTab.page,
            ),
            AutoRoute(
              path: 'settings',
              page: SettingsTab.page,
            ),
          ],
        ),
      ];
}
