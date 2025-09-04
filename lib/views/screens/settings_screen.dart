import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tickme/l10n/app_localizations.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/providers/csv_export_service_provider.dart';
import 'package:tickme/providers/locale_provider.dart';
import 'package:tickme/providers/tick_categories_provider.dart';

class SettingsScreen extends ConsumerWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeServiceProvider);
    return ListView(
      children: [
        FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  title: Text(
                      '${snapshot.data!.appName} ${snapshot.data!.version}'),
                  leading: Image.asset('assets/app/icon.webp'),
                  subtitle: Text(context.loc.app_description),
                );
              } else {
                // Displaying LoadingSpinner to indicate waiting state
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        ListTile(
          title: Text(context.loc.settings_remove_data),
          trailing: const Icon(Icons.delete_forever),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(context.loc.settings_confirm_removing_title),
                content: Text(context.loc.settings_confirm_removing_content),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    child: Text(context.loc.cancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    child: Text(context.loc.remove),
                    onPressed: () {
                      ref.read(tickCategoriesProvider.notifier).erase();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        ListTile(
          title: Text(context.loc.settings_export_to_csv),
          trailing: const Icon(Icons.file_download_outlined),
          onTap: () async {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.loc.settings_exporting_data)),
            );

            final csvExportService = ref.watch(csvExportServiceProvider);
            final filePath = await csvExportService.exportToCsv();
            final shareResult = await SharePlus.instance.share(ShareParams(
              files: [XFile(filePath)],
            ));

            if (shareResult.status == ShareResultStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.loc.settings_data_exported)),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(context.loc.settings_failed_to_export_data)),
              );
            }
          },
        ),
        ListTile(
          title: Text(context.loc.settings_language),
          trailing: DropdownButton<String>(
            value: locale.languageCode,
            items: AppLocalizations.supportedLocales
                .map((l) => DropdownMenuItem<String>(
                      value: l.languageCode,
                      child: Text(l.languageCode),
                    ))
                .toList(),
            onChanged: (String? newLocale) =>
                ref.read(localeServiceProvider.notifier).setLocale(
                      newLocale ?? 'en',
                    ),
          ),
        ),
      ],
    );
  }
}
