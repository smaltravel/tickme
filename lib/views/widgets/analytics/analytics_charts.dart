import 'package:flutter/material.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/views/widgets/analytics/category_distribution_chart.dart';
import 'package:tickme/views/widgets/analytics/usage_frequency_chart.dart';
import 'package:tickme/views/widgets/analytics/interruption_frequency_chart.dart';
import 'package:tickme/views/widgets/analytics/quick_stats_section.dart';

class AnalyticsCharts extends StatelessWidget {
  final List<TimeEntryModel> timeEntries;
  final List<TickCategoryModel> categories;
  final DateTime startDate;
  final DateTime endDate;

  const AnalyticsCharts({
    super.key,
    required this.timeEntries,
    required this.categories,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
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

        // Interruption Frequency (Line Chart)
        _buildChartCard(
          context,
          'Interruption Frequency',
          Icons.timeline,
          InterruptionFrequencyChart(
            timeEntries: timeEntries,
            startDate: startDate,
            endDate: endDate,
          ),
        ),

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

  Widget _buildChartCard(BuildContext context, String title, IconData icon, Widget child) {
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
