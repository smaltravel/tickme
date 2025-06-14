import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/providers/time_range_provider.dart';
import 'package:tickme/services/database_service.dart';

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
    return await DatabaseService.getTimeEntriesByRange(range.start, range.end);
  }

  Future<void> insertTimeEntry(TimeEntryModel data) async {
    await DatabaseService.insertTimeEntry(data);
    final range = ref.read(timeRangeNotifierProvider);
    state = AsyncData(
        await DatabaseService.getTimeEntriesByRange(range.start, range.end));
  }

  Future<void> removeEntriesByCategoryId(String categoryId) async {
    await DatabaseService.removeEntriesByCategoryId(categoryId);
    final range = ref.read(timeRangeNotifierProvider);
    state = AsyncData(
        await DatabaseService.getTimeEntriesByRange(range.start, range.end));
  }

  Future<void> eraseAllEntries() async {
    await DatabaseService.eraseAllEntries();
    final range = ref.read(timeRangeNotifierProvider);
    state = AsyncData(
        await DatabaseService.getTimeEntriesByRange(range.start, range.end));
  }
}

class DatabaseStateNotifier extends StateNotifier<TimeEntries> {
  DatabaseStateNotifier(Ref ref) : super([]) {
    ref.watch(databaseStateProvider).whenData((value) {
      state = value;
    });
  }
}
