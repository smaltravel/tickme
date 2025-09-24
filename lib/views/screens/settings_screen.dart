import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/providers/settings_provider.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/views/dialogs/confirmation_dialog.dart';
import 'package:tickme/views/dialogs/language_builder.dart';
import 'package:tickme/views/dialogs/theme_builder.dart';
import 'package:tickme/views/widgets/settings/section_header.dart';

@RoutePage(name: 'SettingsTab')
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(tickMeAppSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.bottom_bar_settings),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Appearance Section
          SectionHeader(title: context.loc.appearance),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.loc.language),
            subtitle: Text(context.loc.language_map(settings.languageCode)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => showDialog(
                context: context,
                builder: (context) => buildLanguageDialog(
                    context: context,
                    settings: settings,
                    setLanguage: (value) {
                      if (value != null) {
                        ref
                            .read(tickMeAppSettingsProvider.notifier)
                            .setLocale(value);
                      }
                      Navigator.of(context).pop();
                    })),
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: Text(context.loc.theme),
            subtitle: Text(
                context.loc.theme_mode(settings.themeMode.name.toLowerCase())),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => showDialog(
                context: context,
                builder: (context) => buildThemeDialog(
                    context: context,
                    settings: settings,
                    setThemeMode: (value) {
                      if (value != null) {
                        ref
                            .read(tickMeAppSettingsProvider.notifier)
                            .setThemeMode(value);
                      }
                      Navigator.of(context).pop();
                    })),
          ),

          const Divider(),

          // Data Management Section
          SectionHeader(title: context.loc.data_management),
          ListTile(
            leading: const Icon(Icons.file_download),
            title: Text(context.loc.export_data),
            subtitle: Text(context.loc.export_data_subtitle),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: null, // TODO: Implement export
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text(context.loc.reset_data),
            subtitle: Text(context.loc.reset_data_subtitle),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => showDialog(
                context: context,
                builder: (context) => ConfirmationDialog(
                      title: context.loc.reset_data,
                      message: context.loc.reset_data_warning,
                      confirmText: context.loc.reset,
                      confirmColor: Colors.red,
                      onConfirm: () => ref
                          .read(tickCategoriesProvider.notifier)
                          .removeAllCategories(),
                    )),
          ),

          const Divider(),

          // About Section
          SectionHeader(title: context.loc.about),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  leading: Image.asset('assets/app/icon.webp'),
                  title: Text(
                      '${snapshot.data!.appName} ${snapshot.data!.version}'),
                  subtitle: Text(context.loc.app_description),
                  enabled: false,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
