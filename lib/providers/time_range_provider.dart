import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/constants/shared_prefs_keys.dart';
import 'package:tickme/models/time_range.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';

part 'generated/time_range_provider.g.dart';

const _defaultRange = Calendar.day;

@Riverpod(keepAlive: true)
class TimeRangeNotifier extends _$TimeRangeNotifier {
  @override
  TimeRangeModel build() {
    final pref = ref.watch(sharedPreferencesProvider);
    final data = pref.getString(SharedPrefsKeys.timeRange);
    final currentState = data != null
        ? Calendar.values.firstWhere(
            (e) => e.name == data,
            orElse: () => _defaultRange,
          )
        : _defaultRange;

    ref.listenSelf((_, TimeRangeModel curr) =>
        pref.setString(SharedPrefsKeys.timeRange, curr.calendar.name));

    return _calculateRange(currentState);
  }

  TimeRangeModel _calculateRange(Calendar calendar) {
    final now = DateTime.now();
    switch (calendar) {
      case Calendar.day:
        return TimeRangeModel(
          calendar: calendar,
          start: DateTime(now.year, now.month, now.day),
          end: DateTime(now.year, now.month, now.day + 1),
        );
      case Calendar.week:
        final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
        return TimeRangeModel(
          calendar: calendar,
          start: DateTime(
              firstDayOfWeek.year, firstDayOfWeek.month, firstDayOfWeek.day),
          end: DateTime(firstDayOfWeek.year, firstDayOfWeek.month,
              firstDayOfWeek.day + 7),
        );
      case Calendar.month:
        return TimeRangeModel(
          calendar: calendar,
          start: DateTime(now.year, now.month, 1),
          end: DateTime(now.year, now.month + 1, 1),
        );
    }
  }

  void setRange(Calendar calendar) {
    state = _calculateRange(calendar);
  }
}
