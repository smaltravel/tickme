import 'package:duration/duration.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
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
            context.loc.stats_no_data,
            style: TextTheme.of(context).headlineSmall,
          ),
        ],
      ),
    );
  }
}

class ChartWithLegendWidget extends ConsumerWidget {
  final Map<String, double> dataMap;

  const ChartWithLegendWidget({super.key, required this.dataMap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(tickCategoriesProvider);
    final wholeTime =
        dataMap.values.reduce((value, element) => value + element);

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          spacing: 8.0,
          children: [
            Card(
              color: Colors.white,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: PieChart(
                    PieChartData(
                      sections: _buildSections(categories, wholeTime),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: <Widget>[..._buildLegend(categories)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ListTile> _buildLegend(TickCategoriesStorage categories) =>
      dataMap.entries.map(
        (e) {
          final category = categories.firstWhere(
            (c) => c.id == e.key,
            orElse: () => unknownTickCategory,
          );
          return ListTile(
            leading: CircleAvatar(
              radius: 8.0,
              backgroundColor: category.color,
            ),
            title: Text(category.name),
            subtitle: Text(Duration(seconds: e.value.toInt())
                .pretty(abbreviated: true, delimiter: ' ', spacer: '')),
            trailing: Icon(category.icon.data),
          );
        },
      ).toList();

  List<PieChartSectionData> _buildSections(
          TickCategoriesStorage categories, double wholeTime) =>
      dataMap.entries.map((e) {
        final category = categories.firstWhere(
          (c) => c.id == e.key,
          orElse: () => unknownTickCategory,
        );

        return PieChartSectionData(
          value: e.value,
          color: category.color,
          badgeWidget:
              e.value / wholeTime > 0.05 ? Icon(category.icon.data) : null,
          showTitle: false,
        );
      }).toList();
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
          if (dataMap.isEmpty) const NoDataPlaceHolder(),
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
