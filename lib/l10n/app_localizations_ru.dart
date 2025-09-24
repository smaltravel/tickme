// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get add => 'Добавить';

  @override
  String get apply => 'Применить';

  @override
  String get cancel => 'Отмена';

  @override
  String get remove => 'Удалить';

  @override
  String get day => 'День';

  @override
  String get week => 'Неделя';

  @override
  String get month => 'Месяц';

  @override
  String get custom => 'Пользовательский';

  @override
  String get home_color_picker_title => 'Выбрать цвет';

  @override
  String get home_edit_category_update => 'Обновить';

  @override
  String get home_edit_category => 'Редактировать категорию';

  @override
  String get home_edit_category_name => 'имя';

  @override
  String get home_select_color => 'Выбрать цвет';

  @override
  String get home_active_timer => 'Активный таймер';

  @override
  String get home_choose_icon => 'Выбрать иконку';

  @override
  String get home_stop => 'Остановить';

  @override
  String get home_new_category => 'Новая категория';

  @override
  String get home_no_categories => 'Нет категорий';

  @override
  String get home_tap_to_add_category =>
      'Нажмите +, чтобы добавить свою первую категорию';

  @override
  String get settings_remove_data => 'Удалить все данные';

  @override
  String get settings_confirm_removing_title => 'Подтвердить удаление';

  @override
  String get settings_confirm_removing_content =>
      'Вы уверены, что хотите удалить все данные?';

  @override
  String get settings_export_to_csv => 'Экспорт в CSV';

  @override
  String get settings_exporting_data => 'Экспорт данных...';

  @override
  String get settings_data_exported => 'CSV данные экспортированы';

  @override
  String get settings_failed_to_export_data =>
      'Не удалось экспортировать данные';

  @override
  String get settings_language => 'Язык';

  @override
  String get bottom_bar_home => 'Главная';

  @override
  String get bottom_bar_stats => 'Графики';

  @override
  String get bottom_bar_settings => 'Настройки';

  @override
  String get stats_no_data => 'Нет данных';

  @override
  String stats_active_filters(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString фильтров',
      two: '2 фильтра',
      one: '1 фильтр',
      zero: 'Нет фильтров',
    );
    return '$_temp0';
  }

  @override
  String get stats_total_time => 'Общее время';

  @override
  String get category_modal_edit => 'Редактировать';

  @override
  String get category_modal_delete => 'Удалить';

  @override
  String get app_description =>
      'Простое приложение для отслеживания времени, призванное помочь вам отслеживать и анализировать, как вы тратите свое время на различные виды деятельности.';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get data_management => 'Управление данными';

  @override
  String get export_data => 'Экспорт данных';

  @override
  String get export_data_subtitle => 'Экспортировать в CSV';

  @override
  String get reset_data => 'Сбросить данные';

  @override
  String get reset_data_subtitle => 'Удалить все данные';

  @override
  String get reset_data_warning =>
      'Это навсегда удалит все ваши данные. Это действие нельзя отменить.';

  @override
  String get reset => 'Сбросить';

  @override
  String get reset_data_success => 'Все данные были успешно сброшены';

  @override
  String get reset_data_error => 'Ошибка при сбросе данных';

  @override
  String get about => 'О приложении';

  @override
  String theme_mode(String mode) {
    String _temp0 = intl.Intl.selectLogic(
      mode,
      {
        'light': 'Светлая',
        'dark': 'Тёмная',
        'other': 'Системная',
      },
    );
    return '$_temp0';
  }

  @override
  String language_map(String language) {
    String _temp0 = intl.Intl.selectLogic(
      language,
      {
        'en': 'Английский',
        'de': 'Немецкий',
        'ru': 'Русский',
        'other': '',
      },
    );
    return '$_temp0';
  }
}
