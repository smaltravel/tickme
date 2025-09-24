import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @home_color_picker_title.
  ///
  /// In en, this message translates to:
  /// **'Pick a color'**
  String get home_color_picker_title;

  /// No description provided for @home_edit_category_update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get home_edit_category_update;

  /// No description provided for @home_edit_category.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get home_edit_category;

  /// No description provided for @home_edit_category_name.
  ///
  /// In en, this message translates to:
  /// **'name'**
  String get home_edit_category_name;

  /// No description provided for @home_select_color.
  ///
  /// In en, this message translates to:
  /// **'Select Color'**
  String get home_select_color;

  /// No description provided for @home_active_timer.
  ///
  /// In en, this message translates to:
  /// **'Active Timer'**
  String get home_active_timer;

  /// No description provided for @home_choose_icon.
  ///
  /// In en, this message translates to:
  /// **'Choose Icon'**
  String get home_choose_icon;

  /// No description provided for @home_stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get home_stop;

  /// No description provided for @home_new_category.
  ///
  /// In en, this message translates to:
  /// **'New Category'**
  String get home_new_category;

  /// No description provided for @home_no_categories.
  ///
  /// In en, this message translates to:
  /// **'No categories yet'**
  String get home_no_categories;

  /// No description provided for @home_tap_to_add_category.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first category'**
  String get home_tap_to_add_category;

  /// No description provided for @settings_remove_data.
  ///
  /// In en, this message translates to:
  /// **'Remove all data'**
  String get settings_remove_data;

  /// No description provided for @settings_confirm_removing_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm Removing'**
  String get settings_confirm_removing_title;

  /// No description provided for @settings_confirm_removing_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove all data?'**
  String get settings_confirm_removing_content;

  /// No description provided for @settings_export_to_csv.
  ///
  /// In en, this message translates to:
  /// **'Export to CSV'**
  String get settings_export_to_csv;

  /// No description provided for @settings_exporting_data.
  ///
  /// In en, this message translates to:
  /// **'Exporting data...'**
  String get settings_exporting_data;

  /// No description provided for @settings_data_exported.
  ///
  /// In en, this message translates to:
  /// **'CSV data exported'**
  String get settings_data_exported;

  /// No description provided for @settings_failed_to_export_data.
  ///
  /// In en, this message translates to:
  /// **'Failed to export data'**
  String get settings_failed_to_export_data;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @bottom_bar_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottom_bar_home;

  /// No description provided for @bottom_bar_stats.
  ///
  /// In en, this message translates to:
  /// **'Charts'**
  String get bottom_bar_stats;

  /// No description provided for @bottom_bar_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get bottom_bar_settings;

  /// No description provided for @stats_no_data.
  ///
  /// In en, this message translates to:
  /// **'No Data Yet'**
  String get stats_no_data;

  /// A plural message for the number of active filters
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No filters} =1{1 filter} other{{count} filters}}'**
  String stats_active_filters(num count);

  /// No description provided for @stats_total_time.
  ///
  /// In en, this message translates to:
  /// **'Total Time'**
  String get stats_total_time;

  /// No description provided for @category_modal_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get category_modal_edit;

  /// No description provided for @category_modal_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get category_modal_delete;

  /// No description provided for @app_description.
  ///
  /// In en, this message translates to:
  /// **'A simple time tracking application designed to help you monitor and analyze how you spend your time across different activities.'**
  String get app_description;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @data_management.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get data_management;

  /// No description provided for @export_data.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get export_data;

  /// No description provided for @export_data_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Export to CSV'**
  String get export_data_subtitle;

  /// No description provided for @reset_data.
  ///
  /// In en, this message translates to:
  /// **'Reset Data'**
  String get reset_data;

  /// No description provided for @reset_data_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get reset_data_subtitle;

  /// No description provided for @reset_data_warning.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete all your data. This action cannot be undone.'**
  String get reset_data_warning;

  /// No description provided for @reset_data_final_warning.
  ///
  /// In en, this message translates to:
  /// **'Type \'RESET\' to confirm deletion of all data:'**
  String get reset_data_final_warning;

  /// No description provided for @type_reset_to_confirm.
  ///
  /// In en, this message translates to:
  /// **'Type RESET to confirm'**
  String get type_reset_to_confirm;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// A message for the theme mode
  ///
  /// In en, this message translates to:
  /// **'{mode, select, light{Light} dark{Dark} other{System}}'**
  String theme_mode(String mode);

  /// Choosen language
  ///
  /// In en, this message translates to:
  /// **'{language, select, en{English} de{German} ru{Russian} other{}}'**
  String language_map(String language);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
