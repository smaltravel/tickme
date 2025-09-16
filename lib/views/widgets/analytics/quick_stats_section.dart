import 'package:flutter/material.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/models/time_entry.dart';

@immutable
class _ChartData {
  final int sessionCount;
  final String avgSession;
  final String longestSession;
  final String mostActiveCategory;

  const _ChartData({
    required this.sessionCount,
    required this.avgSession,
    required this.longestSession,
    required this.mostActiveCategory,
  });
}

class QuickStatsSection extends StatelessWidget {
  final List<TimeEntryModel> timeEntries;
  final List<TickCategoryModel> categories;

  const QuickStatsSection({
    super.key,
    required this.timeEntries,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStats();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                'Sessions',
                stats.sessionCount.toString(),
                Icons.play_circle_outline,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                'Avg Session',
                stats.avgSession,
                Icons.timer,
                Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                'Longest Session',
                stats.longestSession,
                Icons.trending_up,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                'Most Active',
                stats.mostActiveCategory,
                Icons.star,
                Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  _ChartData _calculateStats() {
    if (timeEntries.isEmpty) {
      return _ChartData(
        sessionCount: 0,
        avgSession: '0m',
        longestSession: '0m',
        mostActiveCategory: 'None',
      );
    }

    // Calculate session count
    final sessionCount = timeEntries.length;

    // Calculate average session duration
    int totalMinutes = 0;
    int longestMinutes = 0;

    for (final entry in timeEntries) {
      final startTime = entry.startTime;
      final endTime = entry.endTime;
      final duration = endTime.difference(startTime).inMinutes;

      totalMinutes += duration;
      if (duration > longestMinutes) {
        longestMinutes = duration;
      }
    }

    final avgMinutes = sessionCount > 0 ? totalMinutes ~/ sessionCount : 0;

    // Calculate most active category
    final categoryCounts = <int, int>{};
    for (final entry in timeEntries) {
      final categoryId = entry.categoryId;
      categoryCounts[categoryId] = (categoryCounts[categoryId] ?? 0) + 1;
    }

    String mostActiveCategory = 'None';
    if (categoryCounts.isNotEmpty) {
      final mostActiveId = categoryCounts.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;
      final category = categories.firstWhere(
        (cat) => cat.id == mostActiveId,
        orElse: () => unknownTickCategory,
      );
      mostActiveCategory = category.name;
    }

    return _ChartData(
      sessionCount: sessionCount,
      avgSession: _formatMinutes(avgMinutes),
      longestSession: _formatMinutes(longestMinutes),
      mostActiveCategory: mostActiveCategory,
    );
  }

  String _formatMinutes(int minutes) {
    if (minutes < 60) {
      return '${minutes}m';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      return '${hours}h ${remainingMinutes}m';
    }
  }
}
