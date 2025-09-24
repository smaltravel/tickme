// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get add => 'Hinzufügen';

  @override
  String get apply => 'Anwenden';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get remove => 'Entfernen';

  @override
  String get day => 'Tag';

  @override
  String get week => 'Woche';

  @override
  String get month => 'Monat';

  @override
  String get custom => 'Benutzerdefiniert';

  @override
  String get home_color_picker_title => 'Farbe auswählen';

  @override
  String get home_edit_category_update => 'Aktualisieren';

  @override
  String get home_edit_category => 'Kategorie bearbeiten';

  @override
  String get home_edit_category_name => 'Name';

  @override
  String get home_select_color => 'Farbe auswählen';

  @override
  String get home_active_timer => 'Aktiver Timer';

  @override
  String get home_choose_icon => 'Symbol auswählen';

  @override
  String get home_stop => 'Stoppen';

  @override
  String get home_new_category => 'Neue Kategorie';

  @override
  String get home_no_categories => 'Keine Kategorien vorhanden';

  @override
  String get home_tap_to_add_category =>
      'Tippen Sie +, um Ihre erste Kategorie hinzuzufügen';

  @override
  String get settings_remove_data => 'Alle Daten entfernen';

  @override
  String get settings_confirm_removing_title => 'Bestätigung des Entfernens';

  @override
  String get settings_confirm_removing_content =>
      'Sind Sie sicher, dass Sie alle Daten entfernen möchten?';

  @override
  String get settings_export_to_csv => 'Exportieren nach CSV';

  @override
  String get settings_exporting_data => 'Daten werden exportiert...';

  @override
  String get settings_data_exported => 'CSV-Daten exportiert';

  @override
  String get settings_failed_to_export_data =>
      'Fehler beim Exportieren der Daten';

  @override
  String get settings_language => 'Sprache';

  @override
  String get bottom_bar_home => 'Home';

  @override
  String get bottom_bar_stats => 'Charts';

  @override
  String get bottom_bar_settings => 'Einstellungen';

  @override
  String get stats_no_data => 'Keine Daten vorhanden';

  @override
  String stats_active_filters(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Filter',
      one: '1 Filter',
      zero: 'Keine Filter',
    );
    return '$_temp0';
  }

  @override
  String get stats_total_time => 'Gesamtzeit';

  @override
  String get category_modal_edit => 'Bearbeiten';

  @override
  String get category_modal_delete => 'Löschen';

  @override
  String get app_description =>
      'Eine einfache Anwendung zur Zeiterfassung, mit der Sie überwachen und analysieren können, wie Sie Ihre Zeit bei verschiedenen Aktivitäten verbringen.';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get language => 'Sprache';

  @override
  String get theme => 'Design';

  @override
  String get data_management => 'Datenverwaltung';

  @override
  String get export_data => 'Daten exportieren';

  @override
  String get export_data_subtitle => 'Exportieren nach CSV';

  @override
  String get reset_data => 'Daten zurücksetzen';

  @override
  String get reset_data_subtitle => 'Alle Daten löschen';

  @override
  String get reset_data_warning =>
      'Dies wird alle Ihre Daten dauerhaft löschen. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get reset_data_final_warning =>
      'Geben Sie \'RESET\' ein, um die Löschung aller Daten zu bestätigen:';

  @override
  String get type_reset_to_confirm => 'RESET eingeben, um zu bestätigen';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get about => 'Über';

  @override
  String theme_mode(String mode) {
    String _temp0 = intl.Intl.selectLogic(
      mode,
      {
        'light': 'Hell',
        'dark': 'Dunkel',
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
        'de': 'Deutsch',
        'ru': 'Russisch',
        'other': '',
      },
    );
    return '$_temp0';
  }
}
