import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/global_app_settings.freezed.dart';
part 'generated/global_app_settings.g.dart';

enum AppThemeMode {
  light,
  dark,
  system,
}

@freezed
abstract class GlobalAppSettings with _$GlobalAppSettings {
  const factory GlobalAppSettings({
    required AppThemeMode themeMode,
    required String languageCode,
  }) = _GlobalAppSettings;

  factory GlobalAppSettings.fromJson(Map<String, dynamic> json) =>
      _$GlobalAppSettingsFromJson(json);
}
