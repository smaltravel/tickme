import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';
import 'package:tickme/screens/app_navigation.dart';

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
    return MaterialApp.router(
      title: 'Tickme',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppNavigation.router,
    );
  }
}
