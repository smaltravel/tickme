import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/common/utils/time.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/services/database.dart';
import 'package:tickme/common/constants/database.dart';

part 'generated/time_entries_prodiver.g.dart';

@Riverpod(keepAlive: true)
class TimeEntries extends _$TimeEntries {
  @override
  Future<int> build() =>
      DatabaseService.getRowCount(DatabaseConstants.timeEntriesTable);

  /// Insert a new time entry into the database
  /// If the entry spans multiple days, it will be split by day
  Future<void> insert(TimeEntryModel entry) async {
    final entries = splitEntryByDays(entry);

    for (final splitEntry in entries) {
      await DatabaseService.insert(
        DatabaseConstants.timeEntriesTable,
        splitEntry.toJson(),
      );
    }

    // Update the state with new count
    ref.invalidateSelf();
  }

  /// Delete a time entry by its ID
  Future<void> delete(int entryId) async {
    await DatabaseService.delete(
      DatabaseConstants.timeEntriesTable,
      'id = ?',
      [entryId],
    );

    // Update the state with new count
    ref.invalidateSelf();
  }

  /// Get all time entries that are completely included within the given time range
  Future<List<TimeEntryModel>> getInRange(DateTime start, DateTime end) async {
    final results = await DatabaseService.query(
      DatabaseConstants.timeEntriesTable,
      where: 'startTime >= ? AND endTime <= ?',
      whereArgs: [
        start.toIso8601String(),
        end.toIso8601String(),
      ],
      orderBy: 'startTime ASC',
    );

    return results.map((row) => TimeEntryModel.fromJson(row)).toList();
  }

  /// Get all time entries
  Future<List<TimeEntryModel>> getAllEntries() async {
    final results = await DatabaseService.query(
      DatabaseConstants.timeEntriesTable,
      orderBy: 'startTime ASC',
    );

    return results.map((row) => TimeEntryModel.fromJson(row)).toList();
  }

  /// Refresh the entry count from database
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
