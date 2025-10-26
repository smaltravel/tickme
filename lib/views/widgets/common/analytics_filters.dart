import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/providers/tick_categories_provider.dart';

class AnalyticsFilters extends ConsumerStatefulWidget {
  final Set<int> selectedCategories;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(Set<int>, DateTime?, DateTime?) onFiltersChanged;

  const AnalyticsFilters({
    super.key,
    required this.selectedCategories,
    this.startDate,
    this.endDate,
    required this.onFiltersChanged,
  });

  @override
  ConsumerState<AnalyticsFilters> createState() => _AnalyticsFiltersState();
}

class _AnalyticsFiltersState extends ConsumerState<AnalyticsFilters> {
  late Set<int> _selectedCategories;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _useWholeTime = true;

  @override
  void initState() {
    super.initState();
    _selectedCategories = Set.from(widget.selectedCategories);
    _startDate = widget.startDate;
    _endDate = widget.endDate;
    _useWholeTime = _startDate == null && _endDate == null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              MoonButton(
                onTap: () => Navigator.pop(context),
                leading: const Icon(Icons.close, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Date Range Toggle
          Row(
            children: [
              Expanded(
                child: Text(
                  context.loc.date_range,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Switch(
                value: !_useWholeTime,
                onChanged: (value) {
                  setState(() {
                    _useWholeTime = !value;
                    if (_useWholeTime) {
                      _startDate = null;
                      _endDate = null;
                    } else {
                      _startDate = DateTime.now();
                      _endDate = DateTime.now();
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Show "Whole time" or date fields
          if (_useWholeTime)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.all_inclusive, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 8),
                  Text(
                    context.loc.whole_time,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            )
          else ...[
            Row(
              children: [
                Expanded(
                  child: _buildDateField(
                    context.loc.start_date,
                    _startDate ?? DateTime.now(),
                    (date) => setState(() => _startDate = date),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateField(
                    context.loc.end_date,
                    _endDate ?? DateTime.now(),
                    (date) => setState(() => _endDate = date),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 24),

          // Categories
          Text(
            'Categories',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ref.watch(tickCategoriesProvider).when(
                  data: (categories) => categories.map((category) {
                    final categoryId = category.id!;
                    final categoryName = category.name;
                    final isSelected = _selectedCategories.contains(categoryId);

                    return FilterChip(
                      label: Text(categoryName),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedCategories.add(categoryId);
                          } else {
                            _selectedCategories.remove(categoryId);
                          }
                        });
                      },
                      selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                      checkmarkColor: Theme.of(context).primaryColor,
                    );
                  }).toList(),
                  loading: () => [const Center(child: CircularProgressIndicator())],
                  error: (error, stack) => [Center(child: Text('Error: $error'))],
                ),
          ),
          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: MoonOutlinedButton(
                  onTap: _resetFilters,
                  isFullWidth: true,
                  label: Text(context.loc.reset),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MoonFilledButton(
                  onTap: _applyFilters,
                  isFullWidth: true,
                  label: Text(context.loc.apply),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime date, Function(DateTime) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: () => _selectDate(date, onChanged),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(DateTime initialDate, Function(DateTime) onChanged) async {
    final now = DateTime.now();
    final firstDate = DateTime(2020);
    final lastDate = now;

    // Ensure initialDate is within the valid range
    final validInitialDate = initialDate.isAfter(lastDate)
        ? lastDate
        : initialDate.isBefore(firstDate)
            ? firstDate
            : initialDate;

    final date = await showDatePicker(
      context: context,
      initialDate: validInitialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date != null) {
      onChanged(date);
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedCategories.clear();
      _useWholeTime = true;
      _startDate = null;
      _endDate = null;
    });
  }

  void _applyFilters() {
    widget.onFiltersChanged(
      _selectedCategories,
      _useWholeTime ? null : _startDate,
      _useWholeTime ? null : _endDate,
    );
    Navigator.pop(context);
  }
}
