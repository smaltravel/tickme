import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/providers/repository_provider.dart';
import 'package:tickme/providers/time_range_provider.dart';

part 'generated/database_provider.g.dart';

typedef TimeEntries = List<TimeEntryModel>;

final databaseStateNotifierProvider =
    StateNotifierProvider<DatabaseStateNotifier, TimeEntries>((ref) {
  return DatabaseStateNotifier(ref);
});

@Riverpod(keepAlive: true)
class DatabaseState extends _$DatabaseState {
  @override
  Future<TimeEntries> build() async {
    final range = ref.watch(timeRangeNotifierProvider);
    final repository = ref.watch(timeEntryRepositoryProvider);

    try {
      return await repository.getTimeEntriesByRange(range.start, range.end);
    } catch (e) {
      // Log error for debugging
      debugPrint('DatabaseState build error: $e');
      rethrow;
    }
  }

  Future<void> insertTimeEntry(TimeEntryModel data) async {
    final repository = ref.read(timeEntryRepositoryProvider);

    try {
      await repository.insertTimeEntry(data);
      final range = ref.read(timeRangeNotifierProvider);
      state = AsyncData(
          await repository.getTimeEntriesByRange(range.start, range.end));
    } catch (e) {
      debugPrint('insertTimeEntry error: $e');
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> removeEntriesByCategoryId(String categoryId) async {
    final repository = ref.read(timeEntryRepositoryProvider);

    try {
      await repository.removeEntriesByCategoryId(categoryId);
      final range = ref.read(timeRangeNotifierProvider);
      state = AsyncData(
          await repository.getTimeEntriesByRange(range.start, range.end));
    } catch (e) {
      debugPrint('removeEntriesByCategoryId error: $e');
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> eraseAllEntries() async {
    final repository = ref.read(timeEntryRepositoryProvider);

    try {
      await repository.eraseAllEntries();
      final range = ref.read(timeRangeNotifierProvider);
      state = AsyncData(
          await repository.getTimeEntriesByRange(range.start, range.end));
    } catch (e) {
      debugPrint('eraseAllEntries error: $e');
      state = AsyncError(e, StackTrace.current);
    }
  }
}

class DatabaseStateNotifier extends StateNotifier<TimeEntries> {
  DatabaseStateNotifier(Ref ref) : super([]) {
    ref.watch(databaseStateProvider).whenData((value) {
      state = value;
    });
  }
}
