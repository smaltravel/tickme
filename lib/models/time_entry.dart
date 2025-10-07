import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/time_entry.freezed.dart';
part 'generated/time_entry.g.dart';

@freezed
abstract class TimeEntryModel with _$TimeEntryModel {
  const factory TimeEntryModel({
    int? id,
    required int categoryId,
    required DateTime startTime,
    required DateTime endTime,
  }) = _TimeEntryModel;

  factory TimeEntryModel.fromJson(Map<String, dynamic> json) =>
      _$TimeEntryModelFromJson(json);
}
