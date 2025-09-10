// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AnalyticsScreen]
class AnalyticsTab extends PageRouteInfo<void> {
  const AnalyticsTab({List<PageRouteInfo>? children})
      : super(AnalyticsTab.name, initialChildren: children);

  static const String name = 'AnalyticsTab';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AnalyticsScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class CategoriesTab extends PageRouteInfo<void> {
  const CategoriesTab({List<PageRouteInfo>? children})
      : super(CategoriesTab.name, initialChildren: children);

  static const String name = 'CategoriesTab';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsTab extends PageRouteInfo<void> {
  const SettingsTab({List<PageRouteInfo>? children})
      : super(SettingsTab.name, initialChildren: children);

  static const String name = 'SettingsTab';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}
