import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/models/time_range.dart';
import 'package:tickme/providers/database_provider.dart';
import 'package:tickme/providers/time_range_provider.dart';
import 'package:tickme/widgets/widgets.dart';

class StatsScreen extends ConsumerWidget {
  static const routeName = '/stats';

  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(timeRangeNotifierProvider);
    final timeEntries = ref.watch(databaseStateNotifierProvider);
    final dataMap =
        _calculateCategoryDurations(entries: timeEntries, range: range);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SegmentedButton(
          segments: <ButtonSegment<Calendar>>[
            ButtonSegment<Calendar>(
              value: Calendar.day,
              label: Text(context.loc.day),
              icon: Icon(Icons.calendar_today),
            ),
            ButtonSegment<Calendar>(
              value: Calendar.week,
              label: Text(context.loc.week),
              icon: Icon(Icons.calendar_view_week),
            ),
            ButtonSegment<Calendar>(
              value: Calendar.month,
              label: Text(context.loc.month),
              icon: Icon(Icons.calendar_month),
            ),
          ],
          selected: <Calendar>{range.calendar},
          onSelectionChanged: (Set<Calendar> newSelection) {
            if (newSelection.isNotEmpty) {
              ref.read(timeRangeNotifierProvider.notifier).setRange(
                    newSelection.first,
                  );
            }
          },
        ),
        ...<Widget>[
          if (dataMap.isEmpty) const NoDataWidget(),
          if (dataMap.isNotEmpty)
            Expanded(child: ChartWithLegendWidget(dataMap: dataMap)),
        ],
      ],
    );
  }

  Map<String, double> _calculateCategoryDurations({
    required TimeEntries entries,
    required TimeRangeModel range,
  }) {
    final durations = <String, double>{};

    for (final entry in entries) {
      durations[entry.categoryId] = (durations[entry.categoryId] ?? 0) +
          _calculateDuration(entry, range).toDouble();
    }

    return durations;
  }

  int _calculateDuration(TimeEntryModel entry, TimeRangeModel range) {
    final start =
        entry.startTime.isAfter(range.start) ? entry.startTime : range.start;
    final end = entry.endTime.isBefore(range.end) ? entry.endTime : range.end;

    return end.difference(start).inSeconds;
  }
}
