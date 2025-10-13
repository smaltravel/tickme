import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/tick_filter.freezed.dart';
part 'generated/tick_filter.g.dart';

enum TimeFrameType {
  day,
  week,
  month,
  custom,
}

@freezed
abstract class TickFilterModel with _$TickFilterModel {
  const factory TickFilterModel({
    required TimeFrameType type,
    required Set<int> categories,
    required DateTime start,
    required DateTime end,
  }) = _TickFilterModel;

  factory TickFilterModel.fromJson(Map<String, dynamic> json) =>
      _$TickFilterModelFromJson(json);
}
