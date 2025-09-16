import 'package:flutter/material.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/views/widgets/analytics/category_distribution_chart.dart';
import 'package:tickme/views/widgets/analytics/usage_frequency_chart.dart';
import 'package:tickme/views/widgets/analytics/daily_pattern_chart.dart';
import 'package:tickme/views/widgets/analytics/quick_stats_section.dart';

class AnalyticsCharts extends StatelessWidget {
  final List<TimeEntryModel> timeEntries;
  final List<TickCategoryModel> categories;

  const AnalyticsCharts({
    super.key,
    required this.timeEntries,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Distribution (Pie Chart)
        _buildChartCard(
          context,
          'Category Distribution',
          Icons.pie_chart,
          CategoryDistributionChart(
            timeEntries: timeEntries,
            categories: categories,
          ),
        ),
        const SizedBox(height: 16),

        // Usage Frequency (Bar Chart)
        _buildChartCard(
          context,
          'Usage Frequency',
          Icons.bar_chart,
          UsageFrequencyChart(
            timeEntries: timeEntries,
            categories: categories,
          ),
        ),
        const SizedBox(height: 16),

        // Daily Activity Pattern (Line Chart)
        _buildChartCard(
          context,
          'Daily Activity Pattern',
          Icons.timeline,
          DailyPatternChart(timeEntries: timeEntries),
        ),
        const SizedBox(height: 16),

        // Quick Stats
        _buildChartCard(
          context,
          'Quick Stats',
          Icons.analytics,
          QuickStatsSection(
            timeEntries: timeEntries,
            categories: categories,
          ),
        ),
      ],
    );
  }

  Widget _buildChartCard(
      BuildContext context, String title, IconData icon, Widget child) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
