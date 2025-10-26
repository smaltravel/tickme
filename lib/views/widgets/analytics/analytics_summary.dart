import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/time_entry.dart';

class AnalyticsSummary extends StatelessWidget {
  final List<TimeEntryModel> timeEntries;
  final DateTime startDate;
  final DateTime endDate;
  final Set<int> selectedCategories;
  final VoidCallback onFilterPressed;

  const AnalyticsSummary({
    super.key,
    required this.timeEntries,
    required this.startDate,
    required this.endDate,
    required this.selectedCategories,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    final totalDuration = _calculateTotalDuration(timeEntries);
    final activeFiltersCount = _getActiveFiltersCount();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.loc.stats_total_time,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                    Text(
                      _formatDuration(totalDuration),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (activeFiltersCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          context.loc.stats_active_filters(activeFiltersCount),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    MoonButton(
                      onTap: onFilterPressed,
                      leading: const Icon(Icons.filter_list, size: 20),
                      buttonSize: MoonButtonSize.sm,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _getDateRangeText(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Duration _calculateTotalDuration(List<TimeEntryModel> entries) {
    int totalSeconds = 0;
    for (final entry in entries) {
      final startTime = entry.startTime;
      final endTime = entry.endTime;
      totalSeconds += endTime.difference(startTime).inSeconds;
    }
    return Duration(seconds: totalSeconds);
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String _getDateRangeText() {
    if (startDate.year == endDate.year && startDate.month == endDate.month && startDate.day == endDate.day) {
      return 'Today';
    } else if (startDate.year == endDate.year && startDate.month == endDate.month) {
      return '${startDate.day} - ${endDate.day} ${_getMonthName(startDate.month)}';
    } else {
      return '${startDate.day}/${startDate.month} - ${endDate.day}/${endDate.month}';
    }
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  int _getActiveFiltersCount() {
    int count = 0;
    if (selectedCategories.isNotEmpty) count++;
    // Add more filter counts as needed
    return count;
  }
}
