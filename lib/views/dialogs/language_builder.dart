import 'package:flutter/material.dart';
import 'package:tickme/l10n/app_localizations.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/global_app_settings.dart';

Widget buildLanguageDialog({
  required BuildContext context,
  required GlobalAppSettings settings,
  required void Function(String?) setLanguage,
}) {
  return AlertDialog(
    title: Text(context.loc.language),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: AppLocalizations.supportedLocales
          .map((locale) => RadioListTile<String>(
                title: Text(context.loc.language_map(locale.languageCode)),
                value: locale.languageCode,
                groupValue: settings.languageCode,
                onChanged: setLanguage,
              ))
          .toList(),
    ),
  );
}
