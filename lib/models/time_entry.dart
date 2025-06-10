import 'package:flutter/material.dart';

@immutable
class TimeEntryModel {
  final int? id;
  final String categoryId;
  final DateTime startTime;
  final DateTime endTime;

  const TimeEntryModel({
    this.id,
    required this.categoryId,
    required this.startTime,
    required this.endTime,
  });

  factory TimeEntryModel.fromMap(Map<String, dynamic> map) {
    return TimeEntryModel(
      id: map['id'] as int?,
      categoryId: map['categoryId'] as String,
      startTime: DateTime.parse(map['startTime'] as String),
      endTime: DateTime.parse(map['endTime'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }
}
