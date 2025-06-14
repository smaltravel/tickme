import 'package:flutter/cupertino.dart';

enum Calendar {
  day,
  week,
  month,
}

@immutable
class TimeRangeModel {
  final DateTime start;
  final DateTime end;
  final Calendar calendar;

  const TimeRangeModel({
    required this.start,
    required this.end,
    required this.calendar,
  });
}
