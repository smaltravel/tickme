import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/services/database_service.dart';

final timeEntriesProvider = Provider(
  (ref) => TimeEntriesController(),
);

class TimeEntriesController {
  Future<int> addTimeEntry(TimeEntryModel entry) async {
    return await DatabaseService.insertTimeEntry(entry);
  }

  Future<int> removeEntriesByCategoryId(String categoryId) async {
    return await DatabaseService.removeEntriesByCategoryId(categoryId);
  }

  Future<int> eraseAllEntries() async {
    return await DatabaseService.eraseAllEntries();
  }
}
