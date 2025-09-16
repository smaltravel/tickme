import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/models/time_entry.dart';

@immutable
class _ChartData {
  final String name;
  final int count;
  final Color color;

  const _ChartData({
    required this.name,
    required this.count,
    required this.color,
  });
}

class UsageFrequencyChart extends StatelessWidget {
  final List<TimeEntryModel> timeEntries;
  final List<TickCategoryModel> categories;

  const UsageFrequencyChart({
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
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: chartData
                  .map((e) => e.count)
                  .reduce((a, b) => a > b ? a : b)
                  .toDouble() +
              1,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${chartData[group.x].name}\n${chartData[group.x].count} sessions',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < chartData.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        chartData[value.toInt()].name,
                        style: const TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: chartData.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data.count.toDouble(),
                  color: data.color,
                  width: 20,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  List<_ChartData> _calculateChartData() {
    if (timeEntries.isEmpty) return [];

    // Count sessions per category
    final categoryCounts = <int, int>{};
    for (final entry in timeEntries) {
      final categoryId = entry.categoryId;
      categoryCounts[categoryId] = (categoryCounts[categoryId] ?? 0) + 1;
    }

    if (categoryCounts.isEmpty) return [];

    final chartData = <_ChartData>[];

    for (final category in categories) {
      final categoryId = category.id;
      if (categoryId == null || !categoryCounts.containsKey(categoryId)) {
        continue;
      }

      final count = categoryCounts[categoryId]!;

      chartData.add(_ChartData(
        name: category.name,
        count: count,
        color: category.color,
      ));
    }

    // Sort by count descending
    chartData.sort((a, b) => b.count.compareTo(a.count));

    return chartData;
  }
}
