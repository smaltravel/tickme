import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tickme/utils/theme_colors.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/providers/theme_mode_provider.dart';
import 'package:tickme/screens/home_screen.dart';
import 'package:tickme/screens/settings_screen.dart';
import 'package:tickme/screens/stats_screen.dart';

class AppNavigation extends ConsumerWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch theme changes to rebuild navigation when theme switches
    ref.watch(themeModeServiceProvider);

    // Lock orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Access semantic colors instead of Moon's character-based names
    final colors = context.colors;

    return PersistentTabView(
      backgroundColor: colors.surface,
      tabs: [
        PersistentTabConfig(
          screen: Container(
            color: colors.background,
            child: const HomeScreen(),
          ),
          item: ItemConfig(
            icon: Icon(
              MoonIcons.generic_home_32_light,
              color: colors.inactive,
            ),
            title: context.loc.bottom_bar_home,
            activeForegroundColor: colors.primary,
            inactiveForegroundColor: colors.inactive,
          ),
        ),
        PersistentTabConfig(
          screen: Container(
            color: colors.background,
            child: const StatsScreen(),
          ),
          item: ItemConfig(
            icon: Icon(
              MoonIcons.chart_pie_chart_24_light,
              color: colors.inactive,
            ),
            title: context.loc.bottom_bar_stats,
            activeForegroundColor: colors.primary,
            inactiveForegroundColor: colors.inactive,
          ),
        ),
        PersistentTabConfig(
          screen: Container(
            color: colors.background,
            child: const SettingsScreen(),
          ),
          item: ItemConfig(
            icon: Icon(
              MoonIcons.generic_settings_32_light,
              color: colors.inactive,
            ),
            title: context.loc.bottom_bar_settings,
            activeForegroundColor: colors.primary,
            inactiveForegroundColor: colors.inactive,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style2BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: colors.surface,
        ),
      ),
    );
  }
}
