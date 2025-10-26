import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/views/screens/categories_screen.dart';
import 'package:tickme/views/screens/analytics_screen.dart';
import 'package:tickme/views/screens/settings_screen.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: const CategoriesScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: context.loc.bottom_bar_home,
          ),
        ),
        PersistentTabConfig(
          screen: const AnalyticsScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.bar_chart),
            title: context.loc.bottom_bar_stats,
          ),
        ),
        PersistentTabConfig(
          screen: const SettingsScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.settings),
            title: context.loc.bottom_bar_settings,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}
