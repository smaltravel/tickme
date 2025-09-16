import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/time_entry.dart';

@immutable
class _ChartData {
  final int hour;
  final int minutes;

  const _ChartData({required this.hour, required this.minutes});
}

class DailyPatternChart extends StatelessWidget {
  final List<TimeEntryModel> timeEntries;

  const DailyPatternChart({
    super.key,
    required this.timeEntries,
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
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.shade300,
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey.shade300,
                strokeWidth: 1,
              );
            },
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
                  final hour = value.toInt();
                  if (hour >= 6 && hour <= 22 && hour % 2 == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${hour.toString().padLeft(2, '0')}:00',
                        style: const TextStyle(fontSize: 10),
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
                    '${value.toInt()}m',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.shade300),
          ),
          minX: 6,
          maxX: 22,
          minY: 0,
          lineBarsData: [
            LineChartBarData(
              spots: chartData
                  .map((data) =>
                      FlSpot(data.hour.toDouble(), data.minutes.toDouble()))
                  .toList(),
              isCurved: true,
              color: Theme.of(context).primaryColor,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_ChartData> _calculateChartData() {
    if (timeEntries.isEmpty) return [];

    // Group entries by hour
    final hourlyData = <int, int>{};

    for (final entry in timeEntries) {
      final startTime = entry.startTime;
      final endTime = entry.endTime;
      final duration = endTime.difference(startTime).inMinutes;

      final hour = startTime.hour;
      hourlyData[hour] = (hourlyData[hour] ?? 0) + duration;
    }

    // Create data points for hours 6-22
    final chartData = <_ChartData>[];
    for (int hour = 6; hour <= 22; hour++) {
      chartData.add(_ChartData(hour: hour, minutes: hourlyData[hour] ?? 0));
    }

    return chartData;
  }
}
