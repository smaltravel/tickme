// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../time_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeEntryModel _$TimeEntryModelFromJson(Map<String, dynamic> json) =>
    _TimeEntryModel(
      id: (json['id'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num).toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$TimeEntryModelToJson(_TimeEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
    };
