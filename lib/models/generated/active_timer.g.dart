// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../active_timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveTimerModel _$ActiveTimerModelFromJson(Map<String, dynamic> json) =>
    ActiveTimerModel(
      categoryId: json['categoryId'] as String,
      start: DateTime.parse(json['start'] as String),
    );

Map<String, dynamic> _$ActiveTimerModelToJson(ActiveTimerModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'start': instance.start.toIso8601String(),
    };
