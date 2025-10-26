import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/tick_filter.dart';
import 'package:tickme/providers/tick_filter_provider.dart';

/// A horizontal scrollable row of filter chips for selecting time range presets.
/// Automatically centers the selected chip with smooth animation.
class TimeRangeChips extends ConsumerStatefulWidget {
  const TimeRangeChips({super.key});

  @override
  ConsumerState<TimeRangeChips> createState() => _TimeRangeChipsState();
}

class _TimeRangeChipsState extends ConsumerState<TimeRangeChips> {
  final ScrollController _scrollController = ScrollController();
  final Map<TimeFrameType, GlobalKey> _chipKeys = {
    TimeFrameType.day: GlobalKey(),
    TimeFrameType.week: GlobalKey(),
    TimeFrameType.month: GlobalKey(),
    TimeFrameType.custom: GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleTimeFrameChange(TimeFrameType type) {
    ref.read(tickFilterProvider.notifier).updateTimeFrame(type: type);
    _scrollToChip(type);
  }

  void _scrollToChip(TimeFrameType type) {
    // Use post frame callback to ensure the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final key = _chipKeys[type];
      if (key?.currentContext == null) return;

      final RenderBox chipBox = key!.currentContext!.findRenderObject() as RenderBox;
      final chipPosition = chipBox.localToGlobal(Offset.zero);
      final chipWidth = chipBox.size.width;

      // Get the scroll view's render box
      final scrollViewBox =
          _scrollController.position.context.storageContext.findRenderObject() as RenderBox?;
      if (scrollViewBox == null) return;

      final scrollViewWidth = scrollViewBox.size.width;

      // Calculate the chip's position relative to the scroll view
      final chipRelativePosition = chipPosition.dx - scrollViewBox.localToGlobal(Offset.zero).dx;

      // Calculate target scroll position to center the chip
      final targetScrollPosition =
          _scrollController.offset + chipRelativePosition - (scrollViewWidth / 2) + (chipWidth / 2);

      // Clamp to valid scroll range
      final maxScroll = _scrollController.position.maxScrollExtent;
      final minScroll = _scrollController.position.minScrollExtent;
      final clampedPosition = targetScrollPosition.clamp(minScroll, maxScroll);

      // Animate to the position
      _scrollController.animateTo(
        clampedPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(tickFilterProvider);

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _buildChip(
            context: context,
            type: TimeFrameType.day,
            icon: Icons.today,
            label: context.loc.day,
            isSelected: filter.type == TimeFrameType.day,
          ),
          const SizedBox(width: 8),
          _buildChip(
            context: context,
            type: TimeFrameType.week,
            icon: Icons.date_range,
            label: context.loc.week,
            isSelected: filter.type == TimeFrameType.week,
          ),
          const SizedBox(width: 8),
          _buildChip(
            context: context,
            type: TimeFrameType.month,
            icon: Icons.calendar_month,
            label: context.loc.month,
            isSelected: filter.type == TimeFrameType.month,
          ),
          const SizedBox(width: 8),
          _buildChip(
            context: context,
            type: TimeFrameType.custom,
            icon: Icons.tune,
            label: context.loc.custom,
            isSelected: filter.type == TimeFrameType.custom,
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required BuildContext context,
    required TimeFrameType type,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return FilterChip(
      key: _chipKeys[type],
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => _handleTimeFrameChange(type),
      selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      checkmarkColor: Theme.of(context).primaryColor,
      labelStyle: TextStyle(
        color: isSelected ? Theme.of(context).primaryColor : null,
      ),
    );
  }
}
