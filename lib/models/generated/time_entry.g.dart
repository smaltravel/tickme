// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../time_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeEntryModel _$TimeEntryModelFromJson(Map<String, dynamic> json) =>
    TimeEntryModel(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$TimeEntryModelToJson(TimeEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
    };
