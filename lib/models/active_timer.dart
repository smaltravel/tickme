import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/active_timer.g.dart';

@immutable
@JsonSerializable()
class ActiveTimer {
  final String categoryId;
  final DateTime start;

  const ActiveTimer({
    required this.categoryId,
    required this.start,
  });

  //For JSON serialization / deserialization
  factory ActiveTimer.fromJson(Map<String, dynamic> json) =>
      _$ActiveTimerFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveTimerToJson(this);
}
