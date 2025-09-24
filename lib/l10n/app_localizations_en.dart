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
  String get apply => 'Apply';

  @override
  String get cancel => 'Cancel';

  @override
  String get remove => 'Remove';

  @override
  String get day => 'Day';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get custom => 'Custom';

  @override
  String get home_color_picker_title => 'Pick a color';

  @override
  String get home_edit_category_update => 'Update';

  @override
  String get home_edit_category => 'Edit Category';

  @override
  String get home_edit_category_name => 'name';

  @override
  String get home_select_color => 'Select Color';

  @override
  String get home_active_timer => 'Active Timer';

  @override
  String get home_choose_icon => 'Choose Icon';

  @override
  String get home_stop => 'Stop';

  @override
  String get home_new_category => 'New Category';

  @override
  String get home_no_categories => 'No categories yet';

  @override
  String get home_tap_to_add_category => 'Tap + to add your first category';

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
  String get settings_data_exported => 'CSV data exported';

  @override
  String get settings_failed_to_export_data => 'Failed to export data';

  @override
  String get settings_language => 'Language';

  @override
  String get bottom_bar_home => 'Home';

  @override
  String get bottom_bar_stats => 'Charts';

  @override
  String get bottom_bar_settings => 'Settings';

  @override
  String get stats_no_data => 'No Data Yet';

  @override
  String stats_active_filters(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString filters',
      one: '1 filter',
      zero: 'No filters',
    );
    return '$_temp0';
  }

  @override
  String get stats_total_time => 'Total Time';

  @override
  String get category_modal_edit => 'Edit';

  @override
  String get category_modal_delete => 'Delete';

  @override
  String get app_description =>
      'A simple time tracking application designed to help you monitor and analyze how you spend your time across different activities.';

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get data_management => 'Data Management';

  @override
  String get export_data => 'Export Data';

  @override
  String get export_data_subtitle => 'Export to CSV';

  @override
  String get reset_data => 'Reset Data';

  @override
  String get reset_data_subtitle => 'Delete all data';

  @override
  String get reset_data_warning =>
      'This will permanently delete all your data. This action cannot be undone.';

  @override
  String get reset => 'Reset';

  @override
  String get reset_data_success => 'All data has been reset successfully';

  @override
  String get reset_data_error => 'Failed to reset data';

  @override
  String get about => 'About';

  @override
  String theme_mode(String mode) {
    String _temp0 = intl.Intl.selectLogic(
      mode,
      {
        'light': 'Light',
        'dark': 'Dark',
        'other': 'System',
      },
    );
    return '$_temp0';
  }

  @override
  String language_map(String language) {
    String _temp0 = intl.Intl.selectLogic(
      language,
      {
        'en': 'English',
        'de': 'German',
        'ru': 'Russian',
        'other': '',
      },
    );
    return '$_temp0';
  }
}
