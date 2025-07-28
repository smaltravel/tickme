import 'package:tickme/models/time_entry.dart';

/// Abstract repository interface for time entry operations
abstract class TimeEntryRepository {
  /// Get time entries within a specific date range
  Future<List<TimeEntryModel>> getTimeEntriesByRange(
      DateTime start, DateTime end);

  /// Insert a new time entry
  Future<void> insertTimeEntry(TimeEntryModel entry);

  /// Remove all entries for a specific category
  Future<void> removeEntriesByCategoryId(String categoryId);

  /// Remove all time entries
  Future<void> eraseAllEntries();

  /// Get time entries with pagination
  Future<List<TimeEntryModel>> getTimeEntriesPartition(int offset, int limit);

  /// Get total count of time entries
  Future<int> countAllEntries();
}
