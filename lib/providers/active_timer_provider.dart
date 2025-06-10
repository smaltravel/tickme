import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';
import 'package:tickme/providers/time_entries_provider.dart';

part 'generated/active_timer_provider.g.dart';

const _sharedPrefKey = 'active_timer';

@Riverpod(keepAlive: true)
class ActiveTick extends _$ActiveTick {
  @override
  ActiveTimerModel? build() {
    final pref = ref.watch(sharedPreferencesProvider);
    final data = pref.getString(_sharedPrefKey);
    final currentState = data != null && data != "null"
        ? ActiveTimerModel.fromJson(jsonDecode(data))
        : null;

    ref.listenSelf(
        (_, curr) => pref.setString(_sharedPrefKey, jsonEncode(curr)));

    return currentState;
  }

  void run(String categoryId) {
    state = ActiveTimerModel(categoryId: categoryId, start: DateTime.now());
  }

  void stop() {
    ref.read(timeEntriesProvider.notifier).add(
        categoryId: state!.categoryId,
        start: state!.start,
        end: DateTime.now());
    state = null;
  }

  void erase() {
    state = null;
  }
}
