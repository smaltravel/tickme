// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../active_timer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActiveTimerModel {
  int get categoryId;
  DateTime get start;

  /// Create a copy of ActiveTimerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActiveTimerModelCopyWith<ActiveTimerModel> get copyWith =>
      _$ActiveTimerModelCopyWithImpl<ActiveTimerModel>(
          this as ActiveTimerModel, _$identity);

  /// Serializes this ActiveTimerModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActiveTimerModel &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.start, start) || other.start == start));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, categoryId, start);

  @override
  String toString() {
    return 'ActiveTimerModel(categoryId: $categoryId, start: $start)';
  }
}

/// @nodoc
abstract mixin class $ActiveTimerModelCopyWith<$Res> {
  factory $ActiveTimerModelCopyWith(
          ActiveTimerModel value, $Res Function(ActiveTimerModel) _then) =
      _$ActiveTimerModelCopyWithImpl;
  @useResult
  $Res call({int categoryId, DateTime start});
}

/// @nodoc
class _$ActiveTimerModelCopyWithImpl<$Res>
    implements $ActiveTimerModelCopyWith<$Res> {
  _$ActiveTimerModelCopyWithImpl(this._self, this._then);

  final ActiveTimerModel _self;
  final $Res Function(ActiveTimerModel) _then;

  /// Create a copy of ActiveTimerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? start = null,
  }) {
    return _then(_self.copyWith(
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ActiveTimerModel implements ActiveTimerModel {
  const _ActiveTimerModel({required this.categoryId, required this.start});
  factory _ActiveTimerModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveTimerModelFromJson(json);

  @override
  final int categoryId;
  @override
  final DateTime start;

  /// Create a copy of ActiveTimerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActiveTimerModelCopyWith<_ActiveTimerModel> get copyWith =>
      __$ActiveTimerModelCopyWithImpl<_ActiveTimerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ActiveTimerModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ActiveTimerModel &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.start, start) || other.start == start));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, categoryId, start);

  @override
  String toString() {
    return 'ActiveTimerModel(categoryId: $categoryId, start: $start)';
  }
}

/// @nodoc
abstract mixin class _$ActiveTimerModelCopyWith<$Res>
    implements $ActiveTimerModelCopyWith<$Res> {
  factory _$ActiveTimerModelCopyWith(
          _ActiveTimerModel value, $Res Function(_ActiveTimerModel) _then) =
      __$ActiveTimerModelCopyWithImpl;
  @override
  @useResult
  $Res call({int categoryId, DateTime start});
}

/// @nodoc
class __$ActiveTimerModelCopyWithImpl<$Res>
    implements _$ActiveTimerModelCopyWith<$Res> {
  __$ActiveTimerModelCopyWithImpl(this._self, this._then);

  final _ActiveTimerModel _self;
  final $Res Function(_ActiveTimerModel) _then;

  /// Create a copy of ActiveTimerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? categoryId = null,
    Object? start = null,
  }) {
    return _then(_ActiveTimerModel(
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
