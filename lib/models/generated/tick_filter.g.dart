// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tick_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TickFilterModel _$TickFilterModelFromJson(Map<String, dynamic> json) =>
    _TickFilterModel(
      type: $enumDecode(_$TimeFrameTypeEnumMap, json['type']),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toSet(),
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
    );

Map<String, dynamic> _$TickFilterModelToJson(_TickFilterModel instance) =>
    <String, dynamic>{
      'type': _$TimeFrameTypeEnumMap[instance.type]!,
      'categories': instance.categories.toList(),
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };

const _$TimeFrameTypeEnumMap = {
  TimeFrameType.day: 'day',
  TimeFrameType.week: 'week',
  TimeFrameType.month: 'month',
  TimeFrameType.custom: 'custom',
};
