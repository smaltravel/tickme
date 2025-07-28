import 'package:flutter_test/flutter_test.dart';
import 'package:tickme/models/active_timer.dart';

void main() {
  group('ActiveTimer Model Tests', () {
    test('should create active timer with category ID and start time', () {
      const categoryId = 'test-category-1';
      final startTime = DateTime.now();

      final timer = ActiveTimerModel(
        categoryId: categoryId,
        start: startTime,
      );

      expect(timer.categoryId, equals(categoryId));
      expect(timer.start, equals(startTime));
    });

    test('should convert to and from JSON', () {
      const categoryId = 'test-category-1';
      final startTime = DateTime(2023, 1, 1, 12, 0, 0);

      final timer = ActiveTimerModel(
        categoryId: categoryId,
        start: startTime,
      );

      final json = timer.toJson();
      final fromJson = ActiveTimerModel.fromJson(json);

      expect(fromJson.categoryId, equals(timer.categoryId));
      expect(fromJson.start, equals(timer.start));
    });

    test('should have different start times for different instances', () {
      const categoryId = 'test-category-1';

      final timer1 = ActiveTimerModel(
        categoryId: categoryId,
        start: DateTime.now(),
      );

      // Wait a bit
      Future.delayed(const Duration(milliseconds: 10));

      final timer2 = ActiveTimerModel(
        categoryId: categoryId,
        start: DateTime.now(),
      );

      expect(timer1.start, isNot(equals(timer2.start)));
    });

    test('should handle null values in JSON', () {
      final json = {
        'categoryId': 'test-category-1',
        'start': '2023-01-01T12:00:00.000Z',
      };

      final timer = ActiveTimerModel.fromJson(json);

      expect(timer.categoryId, equals('test-category-1'));
      expect(timer.start, isA<DateTime>());
    });
  });
}
