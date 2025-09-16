import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/models/time_entry.dart';

@immutable
class _ChartData {
  final String name;
  final double value;
  final double percentage;
  final Color color;

  const _ChartData({
    required this.name,
    required this.value,
    required this.percentage,
    required this.color,
  });
}

class CategoryDistributionChart extends StatelessWidget {
  final List<TimeEntryModel> timeEntries;
  final List<TickCategoryModel> categories;

  const CategoryDistributionChart({
    super.key,
    required this.timeEntries,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final chartData = _calculateChartData();

    if (chartData.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(context.loc.stats_no_data),
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: Row(
        children: [
          // Pie Chart
          Expanded(
            flex: 2,
            child: PieChart(
              PieChartData(
                sections: chartData
                    .map((data) => PieChartSectionData(
                          color: data.color,
                          value: data.value,
                          title: '${data.percentage}%',
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ))
                    .toList(),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Legend
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: chartData
                  .map((data) => _buildLegendItem(context, data))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, _ChartData data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: data.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              data.name,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  List<_ChartData> _calculateChartData() {
    if (timeEntries.isEmpty) return [];

    // Calculate total time per category
    final categoryTimes = <int, int>{};
    for (final entry in timeEntries) {
      final categoryId = entry.categoryId;
      final startTime = entry.startTime;
      final endTime = entry.endTime;
      final duration = endTime.difference(startTime).inSeconds;

      categoryTimes[categoryId] = (categoryTimes[categoryId] ?? 0) + duration;
    }

    if (categoryTimes.isEmpty) return [];

    final totalTime = categoryTimes.values.reduce((a, b) => a + b);
    final chartData = <_ChartData>[];

    for (final category in categories) {
      final categoryId = category.id;
      if (categoryId == null || !categoryTimes.containsKey(categoryId)) {
        continue;
      }

      final time = categoryTimes[categoryId]!;
      final percentage = (time / totalTime * 100).round();

      if (percentage > 0) {
        chartData.add(_ChartData(
          name: category.name,
          value: time.toDouble(),
          percentage: percentage.toDouble(),
          color: category.color,
        ));
      }
    }

    // Sort by value descending
    chartData.sort((a, b) => b.value.compareTo(a.value));

    return chartData;
  }
}
