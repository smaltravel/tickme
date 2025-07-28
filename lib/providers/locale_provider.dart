import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/constants/shared_prefs_keys.dart';
import 'package:tickme/l10n/app_localizations.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';

final localeServiceProvider =
    NotifierProvider<LocaleService, Locale>(LocaleService.new);

class LocaleService extends Notifier<Locale> {
  static const String _defaultLocale = 'en';

  Locale _lookupLocaleOrDefault(String localeName) {
    final supportedLocales =
        AppLocalizations.supportedLocales.map((l) => l.languageCode).toList();

    return Locale(
        supportedLocales.contains(localeName) ? localeName : _defaultLocale);
  }

  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);

    ref.listenSelf((_, curr) =>
        prefs.setString(SharedPrefsKeys.appLanguage, curr.languageCode));

    return _lookupLocaleOrDefault(
        prefs.getString(SharedPrefsKeys.appLanguage) ?? _defaultLocale);
  }

  void setLocale(String localeName) =>
      state = _lookupLocaleOrDefault(localeName);
}
