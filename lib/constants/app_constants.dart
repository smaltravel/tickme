class AppConstants {
  // App Information
  static const String appName = 'TickMe';
  static const String appVersion = '1.0.1';
  static const String appDescription =
      'A simple time tracking application designed to help you monitor and analyze how you spend your time across different activities.';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double cardSpacing = 8.0;
  static const double defaultBorderRadius = 8.0;
  static const double defaultIconSize = 40.0;
  static const double smallIconSize = 24.0;
  static const double largeIconSize = 64.0;

  // Home Screen Constants
  static const double homeRunSpacing = 8.0;
  static const double homeSpacing = 4.0;
  static const int homeColumns = 5;
  static const int maxCategoryNameLength = 20;
  static const double tickTileAspectRatio = 1.5;

  // Timer Constants
  static const Duration timerUpdateInterval = Duration(seconds: 1);
  static const Duration animationDuration = Duration(milliseconds: 300);

  // Chart Constants
  static const double chartAspectRatio = 1.5;
  static const double chartMargin = 8.0;
  static const double legendAvatarRadius = 8.0;
  static const double chartThreshold = 0.05; // 5% threshold for showing badges

  // Database Constants
  static const String dbName = 'tickme.db';
  static const int dbVersion = 1;
  static const String timeEntriesTable = 'time_entries';

  // Colors
  static const int noDataIconColor = 0xffd1d5db;
  static const int noDataBackgroundColor = 0xfff3f4f6;
}
