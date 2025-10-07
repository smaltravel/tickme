import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tickme/navigation/app_router.dart';
import 'package:tickme/l10n/app_localizations_context.dart';

class RouteDestination {
  final PageRouteInfo info;
  final IconData icon;
  final String Function(BuildContext) label;

  RouteDestination({
    required this.info,
    required this.icon,
    required this.label,
  });
}

class AppDestinations {
  static final List<RouteDestination> all = [
    RouteDestination(
      info: CategoriesTab(),
      icon: Icons.home,
      label: (context) => context.loc.bottom_bar_home,
    ),
    RouteDestination(
      info: AnalyticsTab(),
      icon: Icons.bar_chart,
      label: (context) => context.loc.bottom_bar_stats,
    ),
    RouteDestination(
      info: SettingsTab(),
      icon: Icons.settings,
      label: (context) => context.loc.bottom_bar_settings,
    ),
  ];
}
