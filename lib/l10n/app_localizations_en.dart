// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get add => 'Add';

  @override
  String get cancel => 'Cancel';

  @override
  String get remove => 'Remove';

  @override
  String get home_edit_category_rename => 'Rename';

  @override
  String get home_edit_category => 'Edit Category';

  @override
  String get home_edit_category_name => 'name';

  @override
  String get home_active_timer => 'Active Timer';

  @override
  String get home_stop => 'Stop';

  @override
  String get home_new_category => 'New Category';

  @override
  String get settings_remove_data => 'Remove all data';

  @override
  String get settings_confirm_removing_title => 'Confirm Removing';

  @override
  String get settings_confirm_removing_content =>
      'Are you sure you want to remove all data?';

  @override
  String get settings_export_to_csv => 'Export to CSV';

  @override
  String get settings_exporting_data => 'Exporting data...';

  @override
  String settings_data_exported(String filePath) {
    return 'Data exported to $filePath';
  }

  @override
  String get settings_failed_to_export_data => 'Failed to export data';

  @override
  String get settings_language => 'Language';

  @override
  String get bottom_bar_home => 'Home';

  @override
  String get bottom_bar_settings => 'Settings';
}
