import 'package:auto_route/auto_route.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/views/screens/home_screen.dart';
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
          path: '/home',
          initial: true,
          page: HomeRoute.page,
        ),
        AutoRoute(
          path: '/analytics',
          page: AnalyticsRoute.page,
          title: (context, _) => context.loc.bottom_bar_stats,
        ),
        AutoRoute(
          path: '/settings',
          page: SettingsRoute.page,
          title: (context, _) => context.loc.bottom_bar_settings,
        ),
      ];
}
