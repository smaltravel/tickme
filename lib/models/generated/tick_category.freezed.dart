// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tick_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TickCategoryModel {
  int? get id;
  String get name;
  @JsonKey(fromJson: _deserializeIcon, toJson: serializeIcon)
  IconPickerIcon get icon;
  @JsonKey(fromJson: deserializeColor, toJson: serializeColor)
  Color get color;

  /// Create a copy of TickCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TickCategoryModelCopyWith<TickCategoryModel> get copyWith =>
      _$TickCategoryModelCopyWithImpl<TickCategoryModel>(
          this as TickCategoryModel, _$identity);

  /// Serializes this TickCategoryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TickCategoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon, color);

  @override
  String toString() {
    return 'TickCategoryModel(id: $id, name: $name, icon: $icon, color: $color)';
  }
}

/// @nodoc
abstract mixin class $TickCategoryModelCopyWith<$Res> {
  factory $TickCategoryModelCopyWith(
          TickCategoryModel value, $Res Function(TickCategoryModel) _then) =
      _$TickCategoryModelCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String name,
      @JsonKey(fromJson: _deserializeIcon, toJson: serializeIcon)
      IconPickerIcon icon,
      @JsonKey(fromJson: deserializeColor, toJson: serializeColor)
      Color color});
}

/// @nodoc
class _$TickCategoryModelCopyWithImpl<$Res>
    implements $TickCategoryModelCopyWith<$Res> {
  _$TickCategoryModelCopyWithImpl(this._self, this._then);

  final TickCategoryModel _self;
  final $Res Function(TickCategoryModel) _then;

  /// Create a copy of TickCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? icon = null,
    Object? color = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconPickerIcon,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TickCategoryModel implements TickCategoryModel {
  const _TickCategoryModel(
      {this.id,
      required this.name,
      @JsonKey(fromJson: _deserializeIcon, toJson: serializeIcon)
      required this.icon,
      @JsonKey(fromJson: deserializeColor, toJson: serializeColor)
      required this.color});
  factory _TickCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$TickCategoryModelFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  @JsonKey(fromJson: _deserializeIcon, toJson: serializeIcon)
  final IconPickerIcon icon;
  @override
  @JsonKey(fromJson: deserializeColor, toJson: serializeColor)
  final Color color;

  /// Create a copy of TickCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TickCategoryModelCopyWith<_TickCategoryModel> get copyWith =>
      __$TickCategoryModelCopyWithImpl<_TickCategoryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TickCategoryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TickCategoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon, color);

  @override
  String toString() {
    return 'TickCategoryModel(id: $id, name: $name, icon: $icon, color: $color)';
  }
}

/// @nodoc
abstract mixin class _$TickCategoryModelCopyWith<$Res>
    implements $TickCategoryModelCopyWith<$Res> {
  factory _$TickCategoryModelCopyWith(
          _TickCategoryModel value, $Res Function(_TickCategoryModel) _then) =
      __$TickCategoryModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      @JsonKey(fromJson: _deserializeIcon, toJson: serializeIcon)
      IconPickerIcon icon,
      @JsonKey(fromJson: deserializeColor, toJson: serializeColor)
      Color color});
}

/// @nodoc
class __$TickCategoryModelCopyWithImpl<$Res>
    implements _$TickCategoryModelCopyWith<$Res> {
  __$TickCategoryModelCopyWithImpl(this._self, this._then);

  final _TickCategoryModel _self;
  final $Res Function(_TickCategoryModel) _then;

  /// Create a copy of TickCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? icon = null,
    Object? color = null,
  }) {
    return _then(_TickCategoryModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconPickerIcon,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

// dart format on
