// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../active_timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActiveTimerModel _$ActiveTimerModelFromJson(Map<String, dynamic> json) =>
    _ActiveTimerModel(
      categoryId: (json['categoryId'] as num).toInt(),
      start: DateTime.parse(json['start'] as String),
    );

Map<String, dynamic> _$ActiveTimerModelToJson(_ActiveTimerModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'start': instance.start.toIso8601String(),
    };
