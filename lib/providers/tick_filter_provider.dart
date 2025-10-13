import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/common/constants/shared_preferences.dart';
import 'package:tickme/common/utils/time.dart';
import 'package:tickme/models/tick_filter.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';

part 'generated/tick_filter_provider.g.dart';

@Riverpod(keepAlive: true)
class TickFilter extends _$TickFilter {
  @override
  TickFilterModel build() {
    final pref = ref.watch(sharedPreferencesProvider);
    final data = pref.getString(SharedPreferencesConstants.tickFilterKey);
    final currentState = data != null
        ? TickFilterModel.fromJson(jsonDecode(data))
        : _composeRange(type: TimeFrameType.day);

    ref.listenSelf((_, curr) => pref.setString(
        SharedPreferencesConstants.tickFilterKey, jsonEncode(curr)));

    return currentState;
  }

  TickFilterModel _composeRange(
      {required TimeFrameType type, DateTime? start, DateTime? end}) {
    final resolver = TimeIntervalResolver(seed: DateTime.now());

    switch (type) {
      case TimeFrameType.day:
        return TickFilterModel(
            type: type,
            categories: {},
            start: resolver.startThisDay,
            end: resolver.endThisDay);
      case TimeFrameType.week:
        return TickFilterModel(
            type: type,
            categories: {},
            start: resolver.startThisWeek,
            end: resolver.endThisWeek);
      case TimeFrameType.month:
        return TickFilterModel(
            type: type,
            categories: {},
            start: resolver.startThisMonth,
            end: resolver.endThisMonth);
      case TimeFrameType.custom:
        if (start == null || end == null) {
          // If no start or end is provided, use the default range
          return TickFilterModel(
              type: type,
              categories: {},
              start: resolver.startThisDay,
              end: resolver.endThisDay);
        }
        return TickFilterModel(
            type: type, categories: {}, start: start, end: end);
    }
  }

  void updateTimeFrame(
          {required TimeFrameType type, DateTime? start, DateTime? end}) =>
      state = _composeRange(type: type, start: start, end: end)
          .copyWith(categories: state.categories);

  void updateCategories(Set<int> categories) =>
      state = state.copyWith(categories: categories);

  void update(
          {required TimeFrameType type,
          DateTime? start,
          DateTime? end,
          required Set<int> categories}) =>
      state = _composeRange(type: type, start: start, end: end)
          .copyWith(categories: categories);
}
