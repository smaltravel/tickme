import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/active_timer.g.dart';

@immutable
@JsonSerializable()
class ActiveTimerModel {
  final String categoryId;
  final DateTime start;

  const ActiveTimerModel({
    required this.categoryId,
    required this.start,
  });

  //For JSON serialization / deserialization
  factory ActiveTimerModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveTimerModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveTimerModelToJson(this);
}
