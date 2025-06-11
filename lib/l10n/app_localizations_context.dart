import 'package:flutter/material.dart' show BuildContext;
import 'package:tickme/l10n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
