import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';
import 'package:uuid/uuid.dart';

part 'generated/time_entry_provider.g.dart';

const _sharedPrefKey = 'time_entries_list';
const _uuid = Uuid();

typedef TimeEntriesStorage = List<TimeEntry>;

@Riverpod(keepAlive: true)
class Timer extends _$Timer {
  @override
  TimeEntriesStorage build() {
    final pref = ref.watch(sharedPreferencesProvider);
    final currentState = [
      for (var entry in (jsonDecode(pref.getString(_sharedPrefKey) ?? '[]')
          as List<dynamic>))
        TimeEntry.fromJson(entry as Map<String, dynamic>)
    ];

    ref.listenSelf(
        (_, curr) => pref.setString(_sharedPrefKey, jsonEncode(curr)));

    return currentState;
  }

  void add(
      {required String categoryId,
      required DateTime start,
      required DateTime end}) {
    state = [
      ...state,
      TimeEntry(
          id: _uuid.v7(),
          categoryId: categoryId,
          startTime: start,
          endTime: end)
    ];
  }

  void erase() {
    state = [];
  }
}
