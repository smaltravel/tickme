import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/models/time_range.dart';

/// Test helper utilities
class TestHelpers {
  /// Create a test widget with Riverpod
  static Widget createTestWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
      ),
    );
  }

  /// Create a test widget with Riverpod and overrides
  static Widget createTestWidgetWithOverrides(
    Widget child,
    List<Override> overrides,
  ) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  /// Create a mock tick category for testing
  static TickCategoryModel createMockCategory({
    String? id,
    String? name,
    IconPickerIcon? icon,
    Color? color,
  }) {
    return TickCategoryModel(
      id: id ?? 'test-category-1',
      name: name ?? 'Test Category',
      icon: icon ?? unknownTickIcon,
      color: color ?? Colors.blue,
    );
  }

  /// Create a mock active timer for testing
  static ActiveTimerModel createMockActiveTimer({
    String? categoryId,
    DateTime? start,
  }) {
    return ActiveTimerModel(
      categoryId: categoryId ?? 'test-category-1',
      start: start ?? DateTime.now().subtract(const Duration(hours: 1)),
    );
  }

  /// Create a mock time entry for testing
  static TimeEntryModel createMockTimeEntry({
    String? categoryId,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    final now = DateTime.now();
    return TimeEntryModel(
      categoryId: categoryId ?? 'test-category-1',
      startTime: startTime ?? now.subtract(const Duration(hours: 1)),
      endTime: endTime ?? now,
    );
  }

  /// Create a mock time range for testing
  static TimeRangeModel createMockTimeRange({
    Calendar? calendar,
    DateTime? start,
    DateTime? end,
  }) {
    final now = DateTime.now();
    return TimeRangeModel(
      calendar: calendar ?? Calendar.day,
      start: start ?? DateTime(now.year, now.month, now.day),
      end: end ?? DateTime(now.year, now.month, now.day + 1),
    );
  }

  /// Create a list of mock categories for testing
  static List<TickCategoryModel> createMockCategories(int count) {
    return List.generate(count, (index) {
      return createMockCategory(
        id: 'test-category-$index',
        name: 'Test Category $index',
        color: Colors.primaries[index % Colors.primaries.length],
      );
    });
  }

  /// Create a list of mock time entries for testing
  static List<TimeEntryModel> createMockTimeEntries(int count) {
    return List.generate(count, (index) {
      final now = DateTime.now();
      return createMockTimeEntry(
        categoryId: 'test-category-${index % 3}',
        startTime: now.subtract(Duration(hours: index + 1)),
        endTime: now.subtract(Duration(hours: index)),
      );
    });
  }

  /// Wait for async operations to complete
  static Future<void> waitForAsync() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  /// Pump widget and wait for async operations
  static Future<void> pumpAndWait(WidgetTester tester) async {
    await tester.pump();
    await waitForAsync();
    await tester.pump();
  }

  /// Find widget by type and key
  static T? findWidgetByType<T extends Widget>(WidgetTester tester) {
    try {
      return tester.widget<T>(find.byType(T));
    } catch (e) {
      return null;
    }
  }

  /// Find widget by key
  static T? findWidgetByKey<T extends Widget>(
    WidgetTester tester,
    Key key,
  ) {
    try {
      return tester.widget<T>(find.byKey(key));
    } catch (e) {
      return null;
    }
  }

  /// Check if widget exists
  static bool widgetExists<T extends Widget>(WidgetTester tester) {
    return find.byType(T).evaluate().isNotEmpty;
  }

  /// Check if widget with key exists
  static bool widgetWithKeyExists(WidgetTester tester, Key key) {
    return find.byKey(key).evaluate().isNotEmpty;
  }
}
