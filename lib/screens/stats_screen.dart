import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/models/time_range.dart';
import 'package:tickme/providers/database_provider.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/providers/time_range_provider.dart';

class StatsScreen extends ConsumerWidget {
  static const routeName = '/stats';

  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(timeRangeNotifierProvider);
    final categories = ref.watch(tickCategoriesProvider);
    final timeEntries = ref.watch(databaseStateNotifierProvider);
    final sections = _buildSections(timeEntries, categories, range);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 8.0,
      children: <Widget>[
        SegmentedButton(
          segments: const <ButtonSegment<Calendar>>[
            ButtonSegment<Calendar>(
              value: Calendar.day,
              label: Text('Day'),
              icon: Icon(Icons.calendar_today),
            ),
            ButtonSegment<Calendar>(
              value: Calendar.week,
              label: Text('Week'),
              icon: Icon(Icons.calendar_view_week),
            ),
            ButtonSegment<Calendar>(
              value: Calendar.month,
              label: Text('Month'),
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
        Expanded(
          child: sections.isEmpty
              ? const Center(child: Text('No data'))
              : PieChart(PieChartData(sections: sections)),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildSections(
    TimeEntries entries,
    TickCategoriesStorage categories,
    TimeRangeModel range,
  ) {
    final Map<String, int> categoryDurations = {};

    for (final entry in entries) {
      final category = categories.firstWhere((c) => c.id == entry.categoryId);
      categoryDurations[category.name] =
          (categoryDurations[category.name] ?? 0) +
              _calculateDuration(entry, range);
    }

    return categoryDurations.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: entry.key,
        color: Colors.primaries[
            categoryDurations.keys.toList().indexOf(entry.key) %
                Colors.primaries.length],
      );
    }).toList();
  }

  int _calculateDuration(TimeEntryModel entry, TimeRangeModel range) {
    final start =
        entry.startTime.isAfter(range.start) ? entry.startTime : range.start;
    final end = entry.endTime.isBefore(range.end) ? entry.endTime : range.end;

    return end.difference(start).inSeconds;
  }
}
