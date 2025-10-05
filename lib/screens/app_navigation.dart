import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tickme/common/tickme_dark_theme.dart';
import 'package:tickme/common/tickme_light_theme.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/providers/theme_mode_provider.dart';
import 'package:tickme/screens/home_screen.dart';
import 'package:tickme/screens/settings_screen.dart';
import 'package:tickme/screens/stats_screen.dart';

/// Core navigation shell for the TickMe application
///
/// Provides persistent bottom navigation with three main tabs:
/// - Home: Category management and time tracking
/// - Stats: Time visualization and analytics
/// - Settings: App configuration
///
/// Uses persistent_bottom_nav_bar_v2 for navigation with Moon Design theming
class AppNavigation extends ConsumerWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch theme changes to rebuild navigation
    final themeMode = ref.watch(themeModeServiceProvider);

    // Lock orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Access theme colors from MoonTheme extension
    final moonTheme = Theme.of(context).extension<MoonTheme>()!;
    final colors = moonTheme.tokens.colors;

    final backgroundColor = colors.gohan;
    final surfaceColor = colors.goku;
    final primaryColor = colors.piccolo;
    final inactiveColor = Theme.of(context).brightness == Brightness.dark
        ? TickMeDarkTheme.inactiveColor
        : TickMeLightTheme.inactiveColor;

    return PersistentTabView(
      backgroundColor: surfaceColor,
      tabs: [
        PersistentTabConfig(
          screen: Container(
            color: backgroundColor,
            child: const HomeScreen(),
          ),
          item: ItemConfig(
            icon: Icon(
              MoonIcons.generic_home_32_light,
              color: inactiveColor,
            ),
            title: context.loc.bottom_bar_home,
            activeForegroundColor: primaryColor,
            inactiveForegroundColor: inactiveColor,
          ),
        ),
        PersistentTabConfig(
          screen: Container(
            color: backgroundColor,
            child: const StatsScreen(),
          ),
          item: ItemConfig(
            icon: Icon(
              MoonIcons.chart_pie_chart_24_light,
              color: inactiveColor,
            ),
            title: context.loc.bottom_bar_stats,
            activeForegroundColor: primaryColor,
            inactiveForegroundColor: inactiveColor,
          ),
        ),
        PersistentTabConfig(
          screen: Container(
            color: backgroundColor,
            child: const SettingsScreen(),
          ),
          item: ItemConfig(
            icon: Icon(
              MoonIcons.generic_settings_32_light,
              color: inactiveColor,
            ),
            title: context.loc.bottom_bar_settings,
            activeForegroundColor: primaryColor,
            inactiveForegroundColor: inactiveColor,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style2BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: surfaceColor,
        ),
      ),
    );
  }
}
