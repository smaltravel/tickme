import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/common/constants/shared_preferences.dart';
import 'package:tickme/l10n/app_localizations.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';

part 'generated/locale_provider.g.dart';

@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  static const String _defaultLocale = 'en';

  Locale _lookupLocaleOrDefault(String localeName) => Locale(
      AppLocalizations.supportedLocales.any((l) => l.languageCode == localeName)
          ? localeName
          : _defaultLocale);

  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);

    ref.listenSelf((_, curr) => prefs.setString(
        SharedPreferencesConstants.appLanguageKey, curr.languageCode));

    return _lookupLocaleOrDefault(
        prefs.getString(SharedPreferencesConstants.appLanguageKey) ??
            _defaultLocale);
  }

  void setLocale(String localeName) =>
      state = _lookupLocaleOrDefault(localeName);
}
