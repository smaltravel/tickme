import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/models/time_range.dart';
import 'package:tickme/providers/database_provider.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/providers/time_range_provider.dart';

@immutable
class ChartData {
  final PieChartSectionData section;
  final TickCategoryModel category;

  const ChartData({
    required this.section,
    required this.category,
  });
}

class NoDataPlaceHolder extends StatelessWidget {
  const NoDataPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xfff3f4f6),
            radius: 50,
            child: Icon(
              Icons.timer_off_outlined,
              color: Color(0xffd1d5db),
              size: 50,
            ),
          ),
          Text(
            'No Data Yet',
            style: TextTheme.of(context).headlineSmall,
          ),
        ],
      ),
    );
  }
}

class PieChartWidget extends ConsumerWidget {
  final Map<String, double> dataMap;

  const PieChartWidget({super.key, required this.dataMap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(tickCategoriesProvider);
    final chartData = _buildChartData(categories);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8.0,
        children: <Widget>[
          Card(
            color: Colors.white,
            child: PieChart(
              PieChartData(
                sections: chartData.map((e) => e.section).toList(),
              ),
              duration: const Duration(milliseconds: 800),
            ),
          ),
          Expanded(
              child: Card(
            color: Colors.white,
            child: ListView.builder(
              itemCount: chartData.length,
              itemBuilder: (context, index) {
                final data = chartData[index].category;
                final duration =
                    Duration(seconds: chartData[index].section.value.toInt());
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: data.color,
                  ),
                  title: Text(data.name),
                  trailing: Icon(data.icon),
                  subtitle: Text(_fromDuration(duration)),
                );
              },
            ),
          ))
        ],
      ),
    );
  }

  String _fromDuration(Duration duration) {
    String? transform(int val, String unit) =>
        val != 0 ? val.toString() + unit : null;

    final data = [
      transform(duration.inDays, 'd'),
      transform(duration.inHours, 'h'),
      transform(duration.inMinutes, 'm'),
    ];

    return data.where((e) => e != null).join(' ');
  }

  List<ChartData> _buildChartData(TickCategoriesStorage categories) {
    return dataMap.entries.map((entry) {
      final category = categories.firstWhere(
        (c) => c.id == entry.key,
        orElse: () => unknownTickCategory,
      );

      return ChartData(
        section: PieChartSectionData(
          value: entry.value,
          color: category.color,
          badgeWidget: Icon(category.icon),
          showTitle: false,
        ),
        category: category,
      );
    }).toList();
  }
}

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
        dataMap.isEmpty
            ? const NoDataPlaceHolder()
            : PieChartWidget(dataMap: dataMap),
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
