// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../global_app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GlobalAppSettings _$GlobalAppSettingsFromJson(Map<String, dynamic> json) =>
    _GlobalAppSettings(
      themeMode: $enumDecode(_$AppThemeModeEnumMap, json['themeMode']),
      languageCode: json['languageCode'] as String,
    );

Map<String, dynamic> _$GlobalAppSettingsToJson(_GlobalAppSettings instance) =>
    <String, dynamic>{
      'themeMode': _$AppThemeModeEnumMap[instance.themeMode]!,
      'languageCode': instance.languageCode,
    };

const _$AppThemeModeEnumMap = {
  AppThemeMode.light: 'light',
  AppThemeMode.dark: 'dark',
  AppThemeMode.system: 'system',
};
