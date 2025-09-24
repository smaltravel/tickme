// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../global_app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GlobalAppSettings {
  AppThemeMode get themeMode;
  String get languageCode;

  /// Create a copy of GlobalAppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GlobalAppSettingsCopyWith<GlobalAppSettings> get copyWith =>
      _$GlobalAppSettingsCopyWithImpl<GlobalAppSettings>(
          this as GlobalAppSettings, _$identity);

  /// Serializes this GlobalAppSettings to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GlobalAppSettings &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, themeMode, languageCode);

  @override
  String toString() {
    return 'GlobalAppSettings(themeMode: $themeMode, languageCode: $languageCode)';
  }
}

/// @nodoc
abstract mixin class $GlobalAppSettingsCopyWith<$Res> {
  factory $GlobalAppSettingsCopyWith(
          GlobalAppSettings value, $Res Function(GlobalAppSettings) _then) =
      _$GlobalAppSettingsCopyWithImpl;
  @useResult
  $Res call({AppThemeMode themeMode, String languageCode});
}

/// @nodoc
class _$GlobalAppSettingsCopyWithImpl<$Res>
    implements $GlobalAppSettingsCopyWith<$Res> {
  _$GlobalAppSettingsCopyWithImpl(this._self, this._then);

  final GlobalAppSettings _self;
  final $Res Function(GlobalAppSettings) _then;

  /// Create a copy of GlobalAppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? languageCode = null,
  }) {
    return _then(_self.copyWith(
      themeMode: null == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as AppThemeMode,
      languageCode: null == languageCode
          ? _self.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GlobalAppSettings implements GlobalAppSettings {
  const _GlobalAppSettings(
      {required this.themeMode, required this.languageCode});
  factory _GlobalAppSettings.fromJson(Map<String, dynamic> json) =>
      _$GlobalAppSettingsFromJson(json);

  @override
  final AppThemeMode themeMode;
  @override
  final String languageCode;

  /// Create a copy of GlobalAppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GlobalAppSettingsCopyWith<_GlobalAppSettings> get copyWith =>
      __$GlobalAppSettingsCopyWithImpl<_GlobalAppSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GlobalAppSettingsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GlobalAppSettings &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, themeMode, languageCode);

  @override
  String toString() {
    return 'GlobalAppSettings(themeMode: $themeMode, languageCode: $languageCode)';
  }
}

/// @nodoc
abstract mixin class _$GlobalAppSettingsCopyWith<$Res>
    implements $GlobalAppSettingsCopyWith<$Res> {
  factory _$GlobalAppSettingsCopyWith(
          _GlobalAppSettings value, $Res Function(_GlobalAppSettings) _then) =
      __$GlobalAppSettingsCopyWithImpl;
  @override
  @useResult
  $Res call({AppThemeMode themeMode, String languageCode});
}

/// @nodoc
class __$GlobalAppSettingsCopyWithImpl<$Res>
    implements _$GlobalAppSettingsCopyWith<$Res> {
  __$GlobalAppSettingsCopyWithImpl(this._self, this._then);

  final _GlobalAppSettings _self;
  final $Res Function(_GlobalAppSettings) _then;

  /// Create a copy of GlobalAppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? themeMode = null,
    Object? languageCode = null,
  }) {
    return _then(_GlobalAppSettings(
      themeMode: null == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as AppThemeMode,
      languageCode: null == languageCode
          ? _self.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
