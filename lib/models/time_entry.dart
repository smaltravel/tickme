import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/time_entry.g.dart';

@immutable
@JsonSerializable()
class TimeEntryModel {
  final String id;
  final String categoryId;
  final DateTime startTime;
  final DateTime endTime;

  const TimeEntryModel({
    required this.id,
    required this.categoryId,
    required this.startTime,
    required this.endTime,
  });

  //For JSON serialization / deserialization
  factory TimeEntryModel.fromJson(Map<String, dynamic> json) =>
      _$TimeEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeEntryModelToJson(this);
}
