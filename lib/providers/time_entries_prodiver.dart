import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/common/utils/time.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/providers/tick_filter_provider.dart';
import 'package:tickme/services/database.dart';

part 'generated/time_entries_prodiver.g.dart';

typedef TimeEntriesState = List<TimeEntryModel>;

@Riverpod(keepAlive: true)
class TimeEntries extends _$TimeEntries {
  @override
  Future<TimeEntriesState> build() {
    final timeFrame = ref.watch(tickFilterProvider);

    return (DatabaseService.database.select(DatabaseService.timeEntries)
          ..where((e) =>
              e.startTime.isBiggerOrEqualValue(timeFrame.start) &
              e.endTime.isSmallerOrEqualValue(timeFrame.end)))
        .get();
  }

  /// Insert a new time entry into the database
  /// If the entry spans multiple days, it will be split by day
  Future<void> insert(TimeEntryModel entry) async {
    final entries = splitEntryByDays(entry);

    for (final splitEntry in entries) {
      await DatabaseService.database
          .into(DatabaseService.timeEntries)
          .insert(TimeEntriesCompanion.insert(
            categoryId: splitEntry.categoryId,
            startTime: splitEntry.startTime,
            endTime: splitEntry.endTime,
          ));
    }

    // Update the state with new count
    ref.invalidateSelf();
  }

  /// Delete a time entry by its ID
  Future<void> delete(int entryId) async {
    await DatabaseService.timeEntries.deleteAll();

    // Update the state with new count
    ref.invalidateSelf();
  }

  /// Get all time entries
  Future<TimeEntriesState> getAllEntries() => DatabaseService.allTimeEntries;
}
