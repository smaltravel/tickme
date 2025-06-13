import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/screens/home_screen.dart';
import 'package:tickme/screens/settings_screen.dart';

const routes = [
  HomeScreen.routeName,
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
          icon: const Icon(Icons.settings),
          label: context.loc.bottom_bar_settings,
        ),
      ],
    );
  }
}

class ShellWrapper extends StatelessWidget {
  const ShellWrapper({
    required this.child,
    bool? canPop,
    super.key,
  }) : canPop = canPop ?? false;

  final bool canPop;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          title: Text(
            'Tickme',
            style: Theme.of(context).textTheme.displaySmall,
          ),
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
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: SettingsScreen.routeName,
            builder: (context, state) => const SettingsScreen(),
          )
        ],
        builder: (context, state, child) => ShellWrapper(child: child),
      ),
    ],
  );
}
