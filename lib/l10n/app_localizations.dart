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
  /// **'Pie Chart'**
  String get bottom_bar_stats;

  /// No description provided for @bottom_bar_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get bottom_bar_settings;
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
