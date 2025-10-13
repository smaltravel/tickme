import 'package:drift/drift.dart' as drift;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tickme/models/tick_category.dart';

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

@drift.UseRowClass(TimeEntryModel)
class TimeEntries extends drift.Table {
  drift.IntColumn get id => integer().autoIncrement()();
  drift.IntColumn get categoryId => integer().references(TickCategories, #id)();
  drift.DateTimeColumn get startTime => dateTime()();
  drift.DateTimeColumn get endTime => dateTime()();
}
