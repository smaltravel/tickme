import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';
import 'package:tickme/providers/time_entries_provider.dart';

part 'generated/active_timer_provider.g.dart';

const _sharedPrefKey = 'active_timer';

final elapsedTimeNotifierProvider =
    StateNotifierProvider<ElapsedTimeNotifier, Duration>((ref) {
  return ElapsedTimeNotifier(ref);
});

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
    ref.read(timeEntriesProvider).addTimeEntry(TimeEntryModel(
        categoryId: state!.categoryId,
        startTime: state!.start,
        endTime: DateTime.now()));
    state = null;
  }

  void erase() {
    state = null;
  }
}

@riverpod
Stream<Duration> elapsedTime(Ref ref) {
  final activeTimer = ref.watch(activeTickProvider);

  return activeTimer != null
      ? Stream.periodic(const Duration(seconds: 1),
          (_) => DateTime.now().difference(activeTimer.start))
      : Stream.value(Duration.zero);
}

class ElapsedTimeNotifier extends StateNotifier<Duration> {
  ElapsedTimeNotifier(Ref ref) : super(Duration.zero) {
    ref.watch(elapsedTimeProvider.stream).listen((data) {
      state = data;
    });
  }
}
