import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/providers/time_entries_prodiver.dart';
import 'package:tickme/views/widgets/analytics/analytics_charts.dart';
import 'package:tickme/views/widgets/analytics/analytics_filters.dart';
import 'package:tickme/views/widgets/analytics/analytics_summary.dart';
import 'package:tickme/views/widgets/analytics/analytics_time_frames.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  AnalyticsTimeFrame _selectedTimeFrame = AnalyticsTimeFrame.day;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  Set<int> _selectedCategories = {};

  @override
  void initState() {
    super.initState();
    _updateDateRange();
  }

  void _updateDateRange() {
    final now = DateTime.now();
    switch (_selectedTimeFrame) {
      case AnalyticsTimeFrame.day:
        _startDate = DateTime(now.year, now.month, now.day);
        _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
        break;
      case AnalyticsTimeFrame.week:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        _startDate =
            DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
        _endDate = _startDate
            .add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
        // Ensure end date is not in the future
        if (_endDate.isAfter(now)) {
          _endDate = now;
        }
        break;
      case AnalyticsTimeFrame.month:
        _startDate = DateTime(now.year, now.month, 1);
        _endDate = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
        // Ensure end date is not in the future
        if (_endDate.isAfter(now)) {
          _endDate = now;
        }
        break;
      case AnalyticsTimeFrame.custom:
        // Custom dates are set by the user
        break;
    }
  }

  void _onTimeFrameChanged(AnalyticsTimeFrame timeFrame) {
    setState(() {
      _selectedTimeFrame = timeFrame;
      _updateDateRange();
    });
  }

  void _onFiltersChanged(
      Set<int> categories, DateTime? startDate, DateTime? endDate) {
    setState(() {
      _selectedCategories = categories;
      final now = DateTime.now();

      if (startDate != null) {
        _startDate = startDate.isAfter(now) ? now : startDate;
      }
      if (endDate != null) {
        _endDate = endDate.isAfter(now) ? now : endDate;
      }

      // Ensure start date is not after end date
      if (_startDate.isAfter(_endDate)) {
        _endDate = _startDate;
      }

      if (startDate != null || endDate != null) {
        _selectedTimeFrame = AnalyticsTimeFrame.custom;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(tickCategoriesProvider);
    final timeEntriesNotifier = ref.read(timeEntriesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: categories.when(
        data: (categoriesData) => FutureBuilder<List<TimeEntryModel>>(
          future: timeEntriesNotifier.getInRange(_startDate, _endDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final entriesData = snapshot.data ?? [];
            return _buildContent(categoriesData, entriesData);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildContent(
      List<TickCategoryModel> categories, List<TimeEntryModel> timeEntries) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time frame toggles - always visible
          AnalyticsTimeFrames(
            selectedTimeFrame: _selectedTimeFrame,
            onTimeFrameChanged: _onTimeFrameChanged,
          ),
          const SizedBox(height: 16),

          // Summary and filters - always visible
          AnalyticsSummary(
            timeEntries: timeEntries,
            startDate: _startDate,
            endDate: _endDate,
            selectedCategories: _selectedCategories,
            onFilterPressed: () => _showFilterModal(categories),
          ),
          const SizedBox(height: 24),

          // Charts or empty state
          if (timeEntries.isEmpty)
            _buildEmptyState()
          else
            AnalyticsCharts(
              timeEntries: timeEntries,
              categories: categories,
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
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

  void _showFilterModal(List<TickCategoryModel> categories) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AnalyticsFilters(
        categories: categories,
        selectedCategories: _selectedCategories,
        startDate: _startDate,
        endDate: _endDate,
        onFiltersChanged: _onFiltersChanged,
      ),
    );
  }
}

enum AnalyticsTimeFrame {
  day,
  week,
  month,
  custom,
}
