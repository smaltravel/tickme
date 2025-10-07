// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../theme_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeModeHash() => r'0bd501121462cdbc2a9ffc76e2a03871a837a39a';

/// Helper provider to get the current ThemeMode for MaterialApp
///
/// Copied from [themeMode].
@ProviderFor(themeMode)
final themeModeProvider = AutoDisposeProvider<ThemeMode>.internal(
  themeMode,
  name: r'themeModeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$themeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeModeRef = AutoDisposeProviderRef<ThemeMode>;
String _$themeModeServiceHash() => r'939f848c332d676e0550d09636737a7adf2fe7c0';

/// Provider that manages the app's theme mode
/// Persists the user's preference to SharedPreferences
///
/// Copied from [ThemeModeService].
@ProviderFor(ThemeModeService)
final themeModeServiceProvider =
    AutoDisposeNotifierProvider<ThemeModeService, AppThemeMode>.internal(
  ThemeModeService.new,
  name: r'themeModeServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeModeServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeModeService = AutoDisposeNotifier<AppThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
