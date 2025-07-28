import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/screens/home_screen.dart';
import 'package:tickme/screens/settings_screen.dart';
import 'package:tickme/screens/stats_screen.dart';

const routes = [
  HomeScreen.routeName,
  StatsScreen.routeName,
  SettingsScreen.routeName,
];

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });

        context.go(routes[currentPageIndex]);
      },
      selectedIndex: currentPageIndex,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_filled),
          label: context.loc.bottom_bar_home,
        ),
        NavigationDestination(
          icon: const Icon(Icons.pie_chart_outline),
          label: context.loc.bottom_bar_stats,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          label: context.loc.bottom_bar_settings,
        ),
      ],
    );
  }
}

class ShellWrapper extends StatelessWidget {
  const ShellWrapper({
    required this.child,
    required this.state,
    bool? canPop,
    super.key,
  }) : canPop = canPop ?? false;

  final bool canPop;
  final Widget child;
  final GoRouterState state;

  String _getCurrentPageName(BuildContext context) {
    final location = state.uri.path;

    switch (location) {
      case HomeScreen.routeName:
        return context.loc.bottom_bar_home;
      case StatsScreen.routeName:
        return context.loc.bottom_bar_stats;
      case SettingsScreen.routeName:
        return context.loc.bottom_bar_settings;
      default:
        return 'Tickme';
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return PopScope(
      canPop: canPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_getCurrentPageName(context)),
        ),
        bottomNavigationBar: const BottomBar(),
        body: child,
      ),
    );
  }
}

class AppNavigation {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: HomeScreen.routeName,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        routes: [
          GoRoute(
            path: HomeScreen.routeName,
            builder: (context, state) =>
                const Material(color: Color(0xFFF1F5F9), child: HomeScreen()),
          ),
          GoRoute(
            path: StatsScreen.routeName,
            builder: (context, state) =>
                const Material(color: Color(0xFFF1F5F9), child: StatsScreen()),
          ),
          GoRoute(
            path: SettingsScreen.routeName,
            builder: (context, state) => const Material(
                color: Color(0xFFF1F5F9), child: SettingsScreen()),
          )
        ],
        builder: (context, state, child) =>
            ShellWrapper(state: state, child: child),
      ),
    ],
  );
}
