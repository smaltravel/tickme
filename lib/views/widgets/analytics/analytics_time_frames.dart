import 'package:flutter/material.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/views/screens/analytics_screen.dart';

class AnalyticsTimeFrames extends StatelessWidget {
  final AnalyticsTimeFrame selectedTimeFrame;
  final Function(AnalyticsTimeFrame) onTimeFrameChanged;

  const AnalyticsTimeFrames({
    super.key,
    required this.selectedTimeFrame,
    required this.onTimeFrameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          _buildTimeFrameButton(
            context,
            AnalyticsTimeFrame.day,
            context.loc.day,
            Icons.today,
          ),
          _buildTimeFrameButton(
            context,
            AnalyticsTimeFrame.week,
            context.loc.week,
            Icons.date_range,
          ),
          _buildTimeFrameButton(
            context,
            AnalyticsTimeFrame.month,
            context.loc.month,
            Icons.calendar_month,
          ),
          _buildTimeFrameButton(
            context,
            AnalyticsTimeFrame.custom,
            context.loc.custom,
            Icons.tune,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeFrameButton(
    BuildContext context,
    AnalyticsTimeFrame timeFrame,
    String label,
    IconData icon,
  ) {
    final isSelected = selectedTimeFrame == timeFrame;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTimeFrameChanged(timeFrame),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
