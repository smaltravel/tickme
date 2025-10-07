import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';

part 'generated/theme_mode_provider.g.dart';

const _sharedPrefKey = 'app_theme_mode';

/// Theme mode options for the app
enum AppThemeMode {
  light('light'),
  dark('dark'),
  system('system');

  const AppThemeMode(this.value);
  final String value;

  static AppThemeMode fromString(String value) {
    return AppThemeMode.values.firstWhere(
      (mode) => mode.value == value,
      orElse: () => AppThemeMode.system,
    );
  }
}

/// Provider that manages the app's theme mode
/// Persists the user's preference to SharedPreferences
@riverpod
class ThemeModeService extends _$ThemeModeService {
  @override
  AppThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);

    // Listen for changes and persist to SharedPreferences
    listenSelf((_, curr) {
      prefs.setString(_sharedPrefKey, curr.value);
    });

    // Load saved preference or default to system
    final savedMode = prefs.getString(_sharedPrefKey);
    return savedMode != null ? AppThemeMode.fromString(savedMode) : AppThemeMode.system;
  }

  /// Update the theme mode
  void setThemeMode(AppThemeMode mode) {
    state = mode;
  }

  /// Get the effective ThemeMode for Flutter
  ThemeMode getThemeMode() {
    switch (state) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}

/// Helper provider to get the current ThemeMode for MaterialApp
@riverpod
ThemeMode themeMode(Ref ref) {
  ref.watch(themeModeServiceProvider);
  return ref.read(themeModeServiceProvider.notifier).getThemeMode();
}
