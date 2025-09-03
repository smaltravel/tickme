// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../time_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeEntryModel {
  int? get id;
  int get categoryId;
  DateTime get startTime;
  DateTime get endTime;

  /// Create a copy of TimeEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimeEntryModelCopyWith<TimeEntryModel> get copyWith =>
      _$TimeEntryModelCopyWithImpl<TimeEntryModel>(
          this as TimeEntryModel, _$identity);

  /// Serializes this TimeEntryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TimeEntryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, categoryId, startTime, endTime);

  @override
  String toString() {
    return 'TimeEntryModel(id: $id, categoryId: $categoryId, startTime: $startTime, endTime: $endTime)';
  }
}

/// @nodoc
abstract mixin class $TimeEntryModelCopyWith<$Res> {
  factory $TimeEntryModelCopyWith(
          TimeEntryModel value, $Res Function(TimeEntryModel) _then) =
      _$TimeEntryModelCopyWithImpl;
  @useResult
  $Res call({int? id, int categoryId, DateTime startTime, DateTime endTime});
}

/// @nodoc
class _$TimeEntryModelCopyWithImpl<$Res>
    implements $TimeEntryModelCopyWith<$Res> {
  _$TimeEntryModelCopyWithImpl(this._self, this._then);

  final TimeEntryModel _self;
  final $Res Function(TimeEntryModel) _then;

  /// Create a copy of TimeEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? categoryId = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TimeEntryModel implements TimeEntryModel {
  const _TimeEntryModel(
      {this.id,
      required this.categoryId,
      required this.startTime,
      required this.endTime});
  factory _TimeEntryModel.fromJson(Map<String, dynamic> json) =>
      _$TimeEntryModelFromJson(json);

  @override
  final int? id;
  @override
  final int categoryId;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;

  /// Create a copy of TimeEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimeEntryModelCopyWith<_TimeEntryModel> get copyWith =>
      __$TimeEntryModelCopyWithImpl<_TimeEntryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TimeEntryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimeEntryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, categoryId, startTime, endTime);

  @override
  String toString() {
    return 'TimeEntryModel(id: $id, categoryId: $categoryId, startTime: $startTime, endTime: $endTime)';
  }
}

/// @nodoc
abstract mixin class _$TimeEntryModelCopyWith<$Res>
    implements $TimeEntryModelCopyWith<$Res> {
  factory _$TimeEntryModelCopyWith(
          _TimeEntryModel value, $Res Function(_TimeEntryModel) _then) =
      __$TimeEntryModelCopyWithImpl;
  @override
  @useResult
  $Res call({int? id, int categoryId, DateTime startTime, DateTime endTime});
}

/// @nodoc
class __$TimeEntryModelCopyWithImpl<$Res>
    implements _$TimeEntryModelCopyWith<$Res> {
  __$TimeEntryModelCopyWithImpl(this._self, this._then);

  final _TimeEntryModel _self;
  final $Res Function(_TimeEntryModel) _then;

  /// Create a copy of TimeEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? categoryId = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_TimeEntryModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
