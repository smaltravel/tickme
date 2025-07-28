import 'package:flutter_test/flutter_test.dart';
import 'package:tickme/models/time_range.dart';
import 'package:tickme/utils/date_utils.dart';

void main() {
  group('DateUtils Tests', () {
    test('should format duration correctly', () {
      final duration = Duration(hours: 2, minutes: 30, seconds: 45);
      final formatted = AppDateUtils.formatDuration(duration);
      expect(formatted, equals('02:30:45'));
    });

    test('should format duration as list', () {
      final duration = Duration(hours: 1, minutes: 15, seconds: 30);
      final formatted = AppDateUtils.formatDurationAsList(duration);
      expect(formatted, equals(['01', ':', '15', ':', '30']));
    });

    test('should calculate start of day', () {
      final date = DateTime(2023, 12, 15, 14, 30, 45);
      final startOfDay = AppDateUtils.startOfDay(date);
      expect(startOfDay, equals(DateTime(2023, 12, 15)));
    });

    test('should calculate end of day', () {
      final date = DateTime(2023, 12, 15, 14, 30, 45);
      final endOfDay = AppDateUtils.endOfDay(date);
      expect(endOfDay, equals(DateTime(2023, 12, 16)));
    });

    test('should calculate start of week', () {
      // Monday
      final date = DateTime(2023, 12, 18, 14, 30, 45);
      final startOfWeek = AppDateUtils.startOfWeek(date);
      expect(startOfWeek, equals(DateTime(2023, 12, 18)));
    });

    test('should calculate end of week', () {
      // Monday
      final date = DateTime(2023, 12, 18, 14, 30, 45);
      final endOfWeek = AppDateUtils.endOfWeek(date);
      expect(endOfWeek, equals(DateTime(2023, 12, 25)));
    });

    test('should calculate start of month', () {
      final date = DateTime(2023, 12, 15, 14, 30, 45);
      final startOfMonth = AppDateUtils.startOfMonth(date);
      expect(startOfMonth, equals(DateTime(2023, 12, 1)));
    });

    test('should calculate end of month', () {
      final date = DateTime(2023, 12, 15, 14, 30, 45);
      final endOfMonth = AppDateUtils.endOfMonth(date);
      expect(endOfMonth, equals(DateTime(2024, 1, 1)));
    });

    test('should check if date is in range', () {
      final range = TimeRangeModel(
        calendar: Calendar.day,
        start: DateTime(2023, 12, 15),
        end: DateTime(2023, 12, 16),
      );

      final dateInRange = DateTime(2023, 12, 15, 12, 0, 0);
      final dateOutOfRange = DateTime(2023, 12, 17, 12, 0, 0);

      expect(AppDateUtils.isDateInRange(dateInRange, range), isTrue);
      expect(AppDateUtils.isDateInRange(dateOutOfRange, range), isFalse);
    });

    test('should get current time range for day', () {
      final timeRange = AppDateUtils.getCurrentTimeRange(Calendar.day);
      final now = DateTime.now();
      final expectedStart = DateTime(now.year, now.month, now.day);
      final expectedEnd = DateTime(now.year, now.month, now.day + 1);

      expect(timeRange.calendar, equals(Calendar.day));
      expect(timeRange.start.year, equals(expectedStart.year));
      expect(timeRange.start.month, equals(expectedStart.month));
      expect(timeRange.start.day, equals(expectedStart.day));
      expect(timeRange.end.year, equals(expectedEnd.year));
      expect(timeRange.end.month, equals(expectedEnd.month));
      expect(timeRange.end.day, equals(expectedEnd.day));
    });

    test('should get current time range for week', () {
      final timeRange = AppDateUtils.getCurrentTimeRange(Calendar.week);
      final now = DateTime.now();
      final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final expectedStart = DateTime(
          firstDayOfWeek.year, firstDayOfWeek.month, firstDayOfWeek.day);
      final expectedEnd = DateTime(
          firstDayOfWeek.year, firstDayOfWeek.month, firstDayOfWeek.day + 7);

      expect(timeRange.calendar, equals(Calendar.week));
      expect(timeRange.start.year, equals(expectedStart.year));
      expect(timeRange.start.month, equals(expectedStart.month));
      expect(timeRange.start.day, equals(expectedStart.day));
      expect(timeRange.end.year, equals(expectedEnd.year));
      expect(timeRange.end.month, equals(expectedEnd.month));
      expect(timeRange.end.day, equals(expectedEnd.day));
    });

    test('should get current time range for month', () {
      final timeRange = AppDateUtils.getCurrentTimeRange(Calendar.month);
      final now = DateTime.now();
      final expectedStart = DateTime(now.year, now.month, 1);
      final expectedEnd = DateTime(now.year, now.month + 1, 1);

      expect(timeRange.calendar, equals(Calendar.month));
      expect(timeRange.start.year, equals(expectedStart.year));
      expect(timeRange.start.month, equals(expectedStart.month));
      expect(timeRange.start.day, equals(expectedStart.day));
      expect(timeRange.end.year, equals(expectedEnd.year));
      expect(timeRange.end.month, equals(expectedEnd.month));
      expect(timeRange.end.day, equals(expectedEnd.day));
    });
  });
}
