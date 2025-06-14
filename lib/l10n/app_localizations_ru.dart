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
  String get cancel => 'Отмена';

  @override
  String get remove => 'Удалить';

  @override
  String get home_edit_category_update => 'Обновить';

  @override
  String get home_edit_category => 'Редактировать категорию';

  @override
  String get home_edit_category_name => 'имя';

  @override
  String get home_active_timer => 'Активный таймер';

  @override
  String get home_choose_icon => 'Выбрать иконку';

  @override
  String get home_stop => 'Остановить';

  @override
  String get home_new_category => 'Новая категория';

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
  String settings_data_exported(String filePath) {
    return 'Данные экспортированы в $filePath';
  }

  @override
  String get settings_failed_to_export_data =>
      'Не удалось экспортировать данные';

  @override
  String get settings_language => 'Язык';

  @override
  String get bottom_bar_home => 'Главная';

  @override
  String get bottom_bar_stats => 'Диаграмма';

  @override
  String get bottom_bar_settings => 'Настройки';
}
