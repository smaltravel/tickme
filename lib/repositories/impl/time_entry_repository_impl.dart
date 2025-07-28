import 'package:tickme/models/time_entry.dart';
import 'package:tickme/repositories/time_entry_repository.dart';
import 'package:tickme/services/database_service.dart';

/// Concrete implementation of TimeEntryRepository using SQLite
class TimeEntryRepositoryImpl implements TimeEntryRepository {
  @override
  Future<List<TimeEntryModel>> getTimeEntriesByRange(
      DateTime start, DateTime end) async {
    try {
      return await DatabaseService.getTimeEntriesByRange(start, end);
    } catch (e) {
      throw DatabaseException('Failed to get time entries by range: $e');
    }
  }

  @override
  Future<void> insertTimeEntry(TimeEntryModel entry) async {
    try {
      await DatabaseService.insertTimeEntry(entry);
    } catch (e) {
      throw DatabaseException('Failed to insert time entry: $e');
    }
  }

  @override
  Future<void> removeEntriesByCategoryId(String categoryId) async {
    try {
      await DatabaseService.removeEntriesByCategoryId(categoryId);
    } catch (e) {
      throw DatabaseException('Failed to remove entries by category ID: $e');
    }
  }

  @override
  Future<void> eraseAllEntries() async {
    try {
      await DatabaseService.eraseAllEntries();
    } catch (e) {
      throw DatabaseException('Failed to erase all entries: $e');
    }
  }

  @override
  Future<List<TimeEntryModel>> getTimeEntriesPartition(
      int offset, int limit) async {
    try {
      return await DatabaseService.readTimeEntriesPartition(offset, limit);
    } catch (e) {
      throw DatabaseException('Failed to get time entries partition: $e');
    }
  }

  @override
  Future<int> countAllEntries() async {
    try {
      return await DatabaseService.countAllEntries();
    } catch (e) {
      throw DatabaseException('Failed to count all entries: $e');
    }
  }
}

/// Custom exception for database operations
class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException: $message';
}
