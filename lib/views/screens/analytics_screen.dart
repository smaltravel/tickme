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

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize TabController with the current time frame
    final currentTimeFrame = ref.read(tickFilterProvider).type;
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: _timeFrameTypeToIndex(currentTimeFrame),
    );

    // Listen to tab changes and update the time frame
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      final timeFrameType = _indexToTimeFrameType(_tabController.index);
      ref.read(tickFilterProvider.notifier).updateTimeFrame(type: timeFrameType);
    }
  }

  int _timeFrameTypeToIndex(TimeFrameType type) {
    switch (type) {
      case TimeFrameType.day:
        return 0;
      case TimeFrameType.week:
        return 1;
      case TimeFrameType.month:
        return 2;
      case TimeFrameType.custom:
        return 3;
    }
  }

  TimeFrameType _indexToTimeFrameType(int index) {
    switch (index) {
      case 0:
        return TimeFrameType.day;
      case 1:
        return TimeFrameType.week;
      case 2:
        return TimeFrameType.month;
      case 3:
        return TimeFrameType.custom;
      default:
        return TimeFrameType.day;
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeFrame = ref.watch(tickFilterProvider);
    final timeEntries = ref.watch(timeEntriesProvider);
    final categories = ref.watch(tickCategoriesProvider);

    // Sync tab controller with external time frame changes
    final expectedIndex = _timeFrameTypeToIndex(timeFrame.type);
    if (_tabController.index != expectedIndex && !_tabController.indexIsChanging) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _tabController.index != expectedIndex) {
          _tabController.animateTo(expectedIndex);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.bottom_bar_stats),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: Theme.of(context).primaryColor,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.today, size: 20),
                  const SizedBox(width: 8),
                  Text(context.loc.day),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.date_range, size: 20),
                  const SizedBox(width: 8),
                  Text(context.loc.week),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_month, size: 20),
                  const SizedBox(width: 8),
                  Text(context.loc.month),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.tune, size: 20),
                  const SizedBox(width: 8),
                  Text(context.loc.custom),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: categories.when(
          data: (categoriesData) => timeEntries.when(
              data: (timeEntriesData) => TabBarView(
                    controller: _tabController,
                    children: List.generate(
                      4,
                      (index) => _buildContent(
                        categoriesData,
                        timeEntriesData,
                        timeFrame,
                        context,
                      ),
                    ),
                  ),
              error: (error, stack) => Center(child: Text('Error: $error')),
              loading: () => const Center(child: CircularProgressIndicator())),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  Widget _buildContent(List<TickCategoryModel> categories, List<TimeEntryModel> timeEntries,
      TickFilterModel filter, BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary and filters - always visible
          AnalyticsSummary(
            timeEntries: timeEntries,
            startDate: filter.start,
            endDate: filter.end,
            selectedCategories: filter.categories,
            onFilterPressed: () => _showFilterModal(filter, context),
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

  void _showFilterModal(TickFilterModel filter, BuildContext context) {
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
