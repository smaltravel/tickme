import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/models/tick_filter.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/providers/time_entries_prodiver.dart';
import 'package:tickme/providers/tick_filter_provider.dart';
import 'package:tickme/views/widgets/analytics/analytics_charts.dart';
import 'package:tickme/views/widgets/common/analytics_filters.dart';
import 'package:tickme/views/widgets/analytics/analytics_summary.dart';
import 'package:tickme/views/widgets/analytics/analytics_time_frames.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeFrame = ref.watch(tickFilterProvider);
    final timeEntries = ref.watch(timeEntriesProvider);
    final categories = ref.watch(tickCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.bottom_bar_stats),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: categories.when(
        data: (categoriesData) => timeEntries.when(
            data: (timeEntriesData) =>
                _buildContent(categoriesData, timeEntriesData, timeFrame, context, ref),
            error: (error, stack) => Center(child: Text('Error: $error')),
            loading: () => const Center(child: CircularProgressIndicator())),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildContent(List<TickCategoryModel> categories, List<TimeEntryModel> timeEntries,
      TickFilterModel filter, BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time frame toggles - always visible
          AnalyticsTimeFrames(
            timeFrame: filter,
            onTimeFrameChanged: (timeFrameType) =>
                ref.read(tickFilterProvider.notifier).updateTimeFrame(type: timeFrameType),
          ),
          const SizedBox(height: 16),

          // Summary and filters - always visible
          AnalyticsSummary(
            timeEntries: timeEntries,
            startDate: filter.start,
            endDate: filter.end,
            selectedCategories: filter.categories,
            onFilterPressed: () => _showFilterModal(filter, context, ref),
          ),
          const SizedBox(height: 24),

          // Charts or empty state
          if (timeEntries.isEmpty)
            _buildEmptyState(context)
          else
            AnalyticsCharts(
              timeEntries: timeEntries,
              categories: categories,
              startDate: filter.start,
              endDate: filter.end,
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              context.loc.stats_no_data,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey.shade600,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'No data found for the selected time range. Try changing the time period or filters above.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterModal(TickFilterModel filter, BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AnalyticsFilters(
          selectedCategories: filter.categories,
          startDate: filter.start,
          endDate: filter.end,
          onFiltersChanged: (categories, startDate, endDate) => startDate == null || endDate == null
              ? ref.read(tickFilterProvider.notifier).updateCategories(categories)
              : ref.read(tickFilterProvider.notifier).update(
                  type: TimeFrameType.custom, start: startDate, end: endDate, categories: categories)),
    );
  }
}
