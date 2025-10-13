// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tick_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TickFilterModel {
  TimeFrameType get type;
  Set<int> get categories;
  DateTime get start;
  DateTime get end;

  /// Create a copy of TickFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TickFilterModelCopyWith<TickFilterModel> get copyWith =>
      _$TickFilterModelCopyWithImpl<TickFilterModel>(
          this as TickFilterModel, _$identity);

  /// Serializes this TickFilterModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TickFilterModel &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other.categories, categories) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type,
      const DeepCollectionEquality().hash(categories), start, end);

  @override
  String toString() {
    return 'TickFilterModel(type: $type, categories: $categories, start: $start, end: $end)';
  }
}

/// @nodoc
abstract mixin class $TickFilterModelCopyWith<$Res> {
  factory $TickFilterModelCopyWith(
          TickFilterModel value, $Res Function(TickFilterModel) _then) =
      _$TickFilterModelCopyWithImpl;
  @useResult
  $Res call(
      {TimeFrameType type, Set<int> categories, DateTime start, DateTime end});
}

/// @nodoc
class _$TickFilterModelCopyWithImpl<$Res>
    implements $TickFilterModelCopyWith<$Res> {
  _$TickFilterModelCopyWithImpl(this._self, this._then);

  final TickFilterModel _self;
  final $Res Function(TickFilterModel) _then;

  /// Create a copy of TickFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? categories = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as TimeFrameType,
      categories: null == categories
          ? _self.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TickFilterModel implements TickFilterModel {
  const _TickFilterModel(
      {required this.type,
      required final Set<int> categories,
      required this.start,
      required this.end})
      : _categories = categories;
  factory _TickFilterModel.fromJson(Map<String, dynamic> json) =>
      _$TickFilterModelFromJson(json);

  @override
  final TimeFrameType type;
  final Set<int> _categories;
  @override
  Set<int> get categories {
    if (_categories is EqualUnmodifiableSetView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_categories);
  }

  @override
  final DateTime start;
  @override
  final DateTime end;

  /// Create a copy of TickFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TickFilterModelCopyWith<_TickFilterModel> get copyWith =>
      __$TickFilterModelCopyWithImpl<_TickFilterModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TickFilterModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TickFilterModel &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type,
      const DeepCollectionEquality().hash(_categories), start, end);

  @override
  String toString() {
    return 'TickFilterModel(type: $type, categories: $categories, start: $start, end: $end)';
  }
}

/// @nodoc
abstract mixin class _$TickFilterModelCopyWith<$Res>
    implements $TickFilterModelCopyWith<$Res> {
  factory _$TickFilterModelCopyWith(
          _TickFilterModel value, $Res Function(_TickFilterModel) _then) =
      __$TickFilterModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {TimeFrameType type, Set<int> categories, DateTime start, DateTime end});
}

/// @nodoc
class __$TickFilterModelCopyWithImpl<$Res>
    implements _$TickFilterModelCopyWith<$Res> {
  __$TickFilterModelCopyWithImpl(this._self, this._then);

  final _TickFilterModel _self;
  final $Res Function(_TickFilterModel) _then;

  /// Create a copy of TickFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? categories = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_TickFilterModel(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as TimeFrameType,
      categories: null == categories
          ? _self._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
