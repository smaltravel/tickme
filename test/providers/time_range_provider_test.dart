import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/models/time_range.dart';
import 'package:tickme/providers/time_range_provider.dart';

void main() {
  group('TimeRange Provider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should initialize with default day range', () {
      final timeRange = container.read(timeRangeNotifierProvider);
      expect(timeRange.calendar, equals(Calendar.day));
      expect(timeRange.start, isA<DateTime>());
      expect(timeRange.end, isA<DateTime>());
    });

    test('should set range to day', () {
      final notifier = container.read(timeRangeNotifierProvider.notifier);

      notifier.setRange(Calendar.day);

      final timeRange = container.read(timeRangeNotifierProvider);
      expect(timeRange.calendar, equals(Calendar.day));
    });

    test('should set range to week', () {
      final notifier = container.read(timeRangeNotifierProvider.notifier);

      notifier.setRange(Calendar.week);

      final timeRange = container.read(timeRangeNotifierProvider);
      expect(timeRange.calendar, equals(Calendar.week));
    });

    test('should set range to month', () {
      final notifier = container.read(timeRangeNotifierProvider.notifier);

      notifier.setRange(Calendar.month);

      final timeRange = container.read(timeRangeNotifierProvider);
      expect(timeRange.calendar, equals(Calendar.month));
    });

    test('should calculate correct day range', () {
      final notifier = container.read(timeRangeNotifierProvider.notifier);

      notifier.setRange(Calendar.day);

      final timeRange = container.read(timeRangeNotifierProvider);
      final now = DateTime.now();
      final expectedStart = DateTime(now.year, now.month, now.day);
      final expectedEnd = DateTime(now.year, now.month, now.day + 1);

      expect(timeRange.start.year, equals(expectedStart.year));
      expect(timeRange.start.month, equals(expectedStart.month));
      expect(timeRange.start.day, equals(expectedStart.day));
      expect(timeRange.end.year, equals(expectedEnd.year));
      expect(timeRange.end.month, equals(expectedEnd.month));
      expect(timeRange.end.day, equals(expectedEnd.day));
    });

    test('should calculate correct week range', () {
      final notifier = container.read(timeRangeNotifierProvider.notifier);

      notifier.setRange(Calendar.week);

      final timeRange = container.read(timeRangeNotifierProvider);
      final now = DateTime.now();
      final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final expectedStart = DateTime(
          firstDayOfWeek.year, firstDayOfWeek.month, firstDayOfWeek.day);
      final expectedEnd = DateTime(
          firstDayOfWeek.year, firstDayOfWeek.month, firstDayOfWeek.day + 7);

      expect(timeRange.start.year, equals(expectedStart.year));
      expect(timeRange.start.month, equals(expectedStart.month));
      expect(timeRange.start.day, equals(expectedStart.day));
      expect(timeRange.end.year, equals(expectedEnd.year));
      expect(timeRange.end.month, equals(expectedEnd.month));
      expect(timeRange.end.day, equals(expectedEnd.day));
    });

    test('should calculate correct month range', () {
      final notifier = container.read(timeRangeNotifierProvider.notifier);

      notifier.setRange(Calendar.month);

      final timeRange = container.read(timeRangeNotifierProvider);
      final now = DateTime.now();
      final expectedStart = DateTime(now.year, now.month, 1);
      final expectedEnd = DateTime(now.year, now.month + 1, 1);

      expect(timeRange.start.year, equals(expectedStart.year));
      expect(timeRange.start.month, equals(expectedStart.month));
      expect(timeRange.start.day, equals(expectedStart.day));
      expect(timeRange.end.year, equals(expectedEnd.year));
      expect(timeRange.end.month, equals(expectedEnd.month));
      expect(timeRange.end.day, equals(expectedEnd.day));
    });

    test('should maintain start time before end time', () {
      final notifier = container.read(timeRangeNotifierProvider.notifier);

      notifier.setRange(Calendar.day);
      final timeRange = container.read(timeRangeNotifierProvider);

      expect(timeRange.start.isBefore(timeRange.end), isTrue);
    });
  });
}
