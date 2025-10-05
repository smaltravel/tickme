import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tickme/common/tickme_dark_theme.dart';
import 'package:tickme/common/tickme_light_theme.dart';
import 'package:tickme/l10n/app_localizations.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/providers/csv_export_service_provider.dart';
import 'package:tickme/providers/locale_provider.dart';
import 'package:tickme/providers/theme_mode_provider.dart';
import 'package:tickme/providers/tick_categories_provider.dart';

class SettingsScreen extends ConsumerWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeServiceProvider);
    final moonTheme = Theme.of(context).extension<MoonTheme>()!;
    final colors = moonTheme.tokens.colors;

    return SafeArea(
      child: ListView(
        children: [
          FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: colors.goku,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: colors.krillin,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/app/icon.webp', width: 48, height: 48),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data!.appName} ${snapshot.data!.version}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                context.loc.app_description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: MoonCircularLoader(),
                  );
                }
              }),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.loc.settings_confirm_removing_title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(context.loc.settings_confirm_removing_content),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MoonButton(
                              buttonSize: MoonButtonSize.sm,
                              backgroundColor: Colors.transparent,
                              onTap: () => Navigator.of(context).pop(),
                              label: Text(context.loc.cancel),
                            ),
                            const SizedBox(width: 8),
                            MoonButton(
                              buttonSize: MoonButtonSize.sm,
                              backgroundColor: Colors.red,
                              onTap: () {
                                ref.read(tickCategoriesProvider.notifier).erase();
                                Navigator.of(context).pop();
                              },
                              label: Text(
                                context.loc.remove,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: colors.goku,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: colors.krillin,
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      context.loc.settings_remove_data,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(
                    Icons.delete_forever,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? TickMeDarkTheme.inactiveColor
                        : TickMeLightTheme.inactiveColor,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              // Show toast using Moon Design
              MoonToast.show(
                context,
                label: Text(context.loc.settings_exporting_data),
              );

              final csvExportService = ref.watch(csvExportServiceProvider);
              final filePath = await csvExportService.exportToCsv();
              final shareResult = await SharePlus.instance.share(ShareParams(
                files: [XFile(filePath)],
              ));

              if (shareResult.status == ShareResultStatus.success) {
                if (context.mounted) {
                  MoonToast.show(
                    context,
                    label: Text(context.loc.settings_data_exported),
                  );
                }
              } else {
                if (context.mounted) {
                  MoonToast.show(
                    context,
                    label: Text(context.loc.settings_failed_to_export_data),
                    backgroundColor: Colors.red,
                  );
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: colors.goku,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: colors.krillin,
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      context.loc.settings_export_to_csv,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(
                    Icons.file_download_outlined,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? TickMeDarkTheme.inactiveColor
                        : TickMeLightTheme.inactiveColor,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: colors.goku,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: colors.krillin,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    context.loc.settings_theme,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButton<AppThemeMode>(
                  value: ref.watch(themeModeServiceProvider),
                  items: [
                    DropdownMenuItem(
                      value: AppThemeMode.light,
                      child: Text(context.loc.theme_light),
                    ),
                    DropdownMenuItem(
                      value: AppThemeMode.dark,
                      child: Text(context.loc.theme_dark),
                    ),
                    DropdownMenuItem(
                      value: AppThemeMode.system,
                      child: Text(context.loc.theme_system),
                    ),
                  ],
                  onChanged: (AppThemeMode? newTheme) {
                    if (newTheme != null) {
                      ref.read(themeModeServiceProvider.notifier).setThemeMode(newTheme);
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: colors.goku,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: colors.krillin,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    context.loc.settings_language,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButton<String>(
                  value: locale.languageCode,
                  items: AppLocalizations.supportedLocales
                      .map((l) => DropdownMenuItem<String>(
                            value: l.languageCode,
                            child: Text(l.languageCode),
                          ))
                      .toList(),
                  onChanged: (String? newLocale) => ref.read(localeServiceProvider.notifier).setLocale(
                        newLocale ?? 'en',
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
