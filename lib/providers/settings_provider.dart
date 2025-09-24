import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/common/constants/shared_preferences.dart';
import 'package:tickme/l10n/app_localizations.dart';
import 'package:tickme/models/global_app_settings.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';

part 'generated/settings_provider.g.dart';

@Riverpod(keepAlive: true)
class TickMeAppSettings extends _$TickMeAppSettings {
  static final GlobalAppSettings _defaultSettings = GlobalAppSettings(
    themeMode: AppThemeMode.system,
    languageCode: Locale('en').languageCode,
  );

  @override
  GlobalAppSettings build() {
    final prefs = ref.watch(sharedPreferencesProvider);

    ref.listenSelf((_, curr) => prefs.setString(
        SharedPreferencesConstants.globalAppSettingsKey, jsonEncode(curr)));

    return GlobalAppSettings.fromJson(
      jsonDecode(
          prefs.getString(SharedPreferencesConstants.globalAppSettingsKey) ??
              jsonEncode(_defaultSettings)),
    );
  }

  void setLocale(String languageCode) {
    state = state.copyWith(languageCode: _lookupLocaleOrDefault(languageCode));
  }

  void setThemeMode(AppThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
  }

  ThemeMode getEffectiveThemeMode(BuildContext context) {
    if (state.themeMode == AppThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
    }

    return state.themeMode == AppThemeMode.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  String _lookupLocaleOrDefault(String localeCode) =>
      AppLocalizations.supportedLocales
          .firstWhere(
            (locale) => locale.languageCode == localeCode,
            orElse: () => Locale(_defaultSettings.languageCode),
          )
          .languageCode;
}
