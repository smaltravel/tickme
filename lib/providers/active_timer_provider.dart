import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/providers/database_provider.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';

part 'generated/active_timer_provider.g.dart';

const _sharedPrefKey = 'active_timer';

@Riverpod(keepAlive: true)
class ActiveTick extends _$ActiveTick {
  @override
  ActiveTimerModel? build() {
    final pref = ref.watch(sharedPreferencesProvider);
    final data = pref.getString(_sharedPrefKey);
    final currentState = data != null && data != "null" ? ActiveTimerModel.fromJson(jsonDecode(data)) : null;

    listenSelf((_, curr) => pref.setString(_sharedPrefKey, jsonEncode(curr)));

    return currentState;
  }

  void run(String categoryId) {
    state = ActiveTimerModel(categoryId: categoryId, start: DateTime.now());
  }

  void stop() {
    ref.read(databaseStateProvider.notifier).insertTimeEntry(
        TimeEntryModel(categoryId: state!.categoryId, startTime: state!.start, endTime: DateTime.now()));
    state = null;
  }

  void erase() {
    state = null;
  }
}
