import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Test configuration and setup
class TestConfig {
  /// Global test timeout
  static const Duration timeout = Duration(seconds: 30);

  /// Test data directory
  static const String testDataDir = 'test/data';

  /// Mock database path
  static const String mockDbPath = ':memory:';

  /// Test categories
  static const List<String> testCategories = [
    'Work',
    'Study',
    'Exercise',
    'Reading',
    'Coding',
  ];

  /// Test time ranges
  static const List<Map<String, dynamic>> testTimeRanges = [
    {'start': '2023-01-01T00:00:00Z', 'end': '2023-01-02T00:00:00Z'},
    {'start': '2023-01-01T00:00:00Z', 'end': '2023-01-08T00:00:00Z'},
    {'start': '2023-01-01T00:00:00Z', 'end': '2023-02-01T00:00:00Z'},
  ];
}

/// Test utilities
class TestUtils {
  /// Create a test widget with common configuration
  static Widget createTestWidget(Widget child) {
    return MaterialApp(
      home: child,
      debugShowCheckedModeBanner: false,
    );
  }

  /// Wait for async operations
  static Future<void> waitForAsync() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  /// Pump widget and wait
  static Future<void> pumpAndWait(WidgetTester tester) async {
    await tester.pump();
    await waitForAsync();
    await tester.pump();
  }
}
