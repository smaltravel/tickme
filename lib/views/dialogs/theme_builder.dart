import 'package:flutter/material.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/global_app_settings.dart';

Widget buildThemeDialog({
  required BuildContext context,
  required GlobalAppSettings settings,
  required void Function(AppThemeMode?) setThemeMode,
}) {
  return AlertDialog(
    title: Text(context.loc.theme),
    content: Column(mainAxisSize: MainAxisSize.min, children: [
      ...AppThemeMode.values.map((themeMode) => RadioListTile<AppThemeMode>(
            title: Text(context.loc.theme_mode(themeMode.name.toLowerCase())),
            value: themeMode,
            groupValue: settings.themeMode,
            onChanged: setThemeMode,
          )),
    ]),
  );
}
