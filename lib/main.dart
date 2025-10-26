import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickme/common/tickme_dark_theme.dart';
import 'package:tickme/common/tickme_light_theme.dart';
import 'package:tickme/l10n/app_localizations.dart';
import 'package:tickme/models/global_app_settings.dart';
import 'package:tickme/providers/settings_provider.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';
import 'package:tickme/navigation/app_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
    child: const TickmeApp(),
  ));
}

class TickmeApp extends ConsumerWidget {
  const TickmeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(tickMeAppSettingsProvider);

    // Convert AppThemeMode to Flutter's ThemeMode
    ThemeMode flutterThemeMode;
    if (settings.themeMode == AppThemeMode.dark) {
      flutterThemeMode = ThemeMode.dark;
    } else if (settings.themeMode == AppThemeMode.light) {
      flutterThemeMode = ThemeMode.light;
    } else {
      flutterThemeMode = ThemeMode.system;
    }

    return MaterialApp(
      title: 'Tickme',
      theme: TickMeLightTheme.theme,
      darkTheme: TickMeDarkTheme.theme,
      themeMode: flutterThemeMode,
      home: const AppNavigation(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settings.languageCode),
    );
  }
}
