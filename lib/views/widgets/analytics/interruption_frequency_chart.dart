import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/time_entry.dart';

@immutable
class _ChartData {
  final double timeSlot;
  final int sessionCount;
  final String label;

  const _ChartData({
    required this.timeSlot,
    required this.sessionCount,
    required this.label,
  });
}

class InterruptionFrequencyChart extends StatelessWidget {
  final List<TimeEntryModel> timeEntries;
  final DateTime startDate;
  final DateTime endDate;

  const InterruptionFrequencyChart({
    super.key,
    required this.timeEntries,
    required this.startDate,
    required this.endDate,
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
            verticalInterval: 2,
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
                  final index = value.toInt();
                  if (index < chartData.length) {
                    final data = chartData[index];
                    // Show every 2nd label (every hour)
                    final showLabel = index % 2 == 0;

                    if (showLabel) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          data.label,
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    }
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
                    '${value.toInt()}',
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
          minX: 0,
          maxX: 47, // 48 slots (24 hours * 2 slots per hour)
          minY: 0,
          lineBarsData: [
            LineChartBarData(
              spots: chartData
                  .asMap()
                  .entries
                  .map((entry) => FlSpot(entry.key.toDouble(),
                      entry.value.sessionCount.toDouble()))
                  .toList(),
              isCurved: true,
              color: Colors.orange.shade600,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false, // Remove dots for solid line appearance
              ),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.orange.shade600.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isDailyView() {
    final daysDifference = endDate.difference(startDate).inDays;
    return daysDifference <= 1;
  }

  List<_ChartData> _calculateChartData() {
    if (timeEntries.isEmpty) return _generateEmptyChartData();

    final isDaily = _isDailyView();

    if (isDaily) {
      return _calculateDailyData();
    } else {
      return _calculateMultiDayData();
    }
  }

  List<_ChartData> _generateEmptyChartData() {
    // Generate empty data for all 48 slots (24 hours * 2 slots per hour)
    final chartData = <_ChartData>[];
    for (int i = 0; i < 48; i++) {
      final hour = i ~/ 2;
      final minute = (i % 2) * 30;
      chartData.add(_ChartData(
        timeSlot: i.toDouble(),
        sessionCount: 0,
        label:
            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
      ));
    }
    return chartData;
  }

  List<_ChartData> _calculateDailyData() {
    // Count sessions per 30-minute slot (0-47)
    final slotSessions = <int, int>{};

    for (final entry in timeEntries) {
      final slotIndex = _getTimeSlotIndex(entry.startTime);
      if (slotIndex >= 0 && slotIndex < 48) {
        slotSessions[slotIndex] = (slotSessions[slotIndex] ?? 0) + 1;
      }
    }

    // Create data points for all 48 slots
    final chartData = <_ChartData>[];
    for (int i = 0; i < 48; i++) {
      final hour = i ~/ 2;
      final minute = (i % 2) * 30;
      chartData.add(_ChartData(
        timeSlot: i.toDouble(),
        sessionCount: slotSessions[i] ?? 0,
        label:
            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
      ));
    }

    return chartData;
  }

  List<_ChartData> _calculateMultiDayData() {
    // Count sessions per 30-minute slot across all days
    final slotSessions = <int, List<int>>{};

    for (final entry in timeEntries) {
      final slotIndex = _getTimeSlotIndex(entry.startTime);
      if (slotIndex >= 0 && slotIndex < 48) {
        slotSessions.putIfAbsent(slotIndex, () => []).add(1);
      }
    }

    // Calculate average sessions per slot
    final chartData = <_ChartData>[];
    for (int i = 0; i < 48; i++) {
      final sessions = slotSessions[i] ?? [];
      final averageSessions =
          sessions.isEmpty ? 0 : sessions.reduce((a, b) => a + b);

      final hour = i ~/ 2;
      final minute = (i % 2) * 30;
      chartData.add(_ChartData(
        timeSlot: i.toDouble(),
        sessionCount: averageSessions,
        label:
            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
      ));
    }

    return chartData;
  }

  int _getTimeSlotIndex(DateTime entryTime) {
    // Convert time to 30-minute slot index (0-47)
    final hour = entryTime.hour;
    final minute = entryTime.minute;
    final slotInHour = minute < 30 ? 0 : 1;
    return hour * 2 + slotInHour;
  }
}
