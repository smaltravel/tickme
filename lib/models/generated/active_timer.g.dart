// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../active_timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveTimer _$ActiveTimerFromJson(Map<String, dynamic> json) => ActiveTimer(
      categoryId: json['categoryId'] as String,
      start: DateTime.parse(json['start'] as String),
    );

Map<String, dynamic> _$ActiveTimerToJson(ActiveTimer instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'start': instance.start.toIso8601String(),
    };
