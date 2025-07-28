import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tickme/utils/validation_utils.dart';

void main() {
  group('ValidationUtils Tests', () {
    test('should validate valid string', () {
      expect(ValidationUtils.isValidString('test'), isTrue);
      expect(ValidationUtils.isValidString('  test  '), isTrue);
    });

    test('should reject invalid strings', () {
      expect(ValidationUtils.isValidString(null), isFalse);
      expect(ValidationUtils.isValidString(''), isFalse);
      expect(ValidationUtils.isValidString('   '), isFalse);
    });

    test('should validate string length', () {
      expect(ValidationUtils.isValidStringLength('test', 1, 10), isTrue);
      expect(ValidationUtils.isValidStringLength('test', 4, 4), isTrue);
      expect(ValidationUtils.isValidStringLength('test', 1, 3), isFalse);
      expect(ValidationUtils.isValidStringLength('test', 5, 10), isFalse);
    });

    test('should validate category name', () {
      expect(ValidationUtils.isValidCategoryName('Test Category'), isTrue);
      expect(ValidationUtils.isValidCategoryName('A'), isTrue);
      expect(
          ValidationUtils.isValidCategoryName(
              'Very Long Category Name That Exceeds Limit'),
          isFalse);
      expect(ValidationUtils.isValidCategoryName(''), isFalse);
      expect(ValidationUtils.isValidCategoryName(null), isFalse);
    });

    test('should validate duration', () {
      expect(ValidationUtils.isValidDuration(Duration(seconds: 1)), isTrue);
      expect(ValidationUtils.isValidDuration(Duration(hours: 1)), isTrue);
      expect(ValidationUtils.isValidDuration(Duration.zero), isFalse);
      expect(ValidationUtils.isValidDuration(Duration(seconds: -1)), isFalse);
    });

    test('should check if date is in past', () {
      final pastDate = DateTime.now().subtract(const Duration(days: 1));
      final futureDate = DateTime.now().add(const Duration(days: 1));

      expect(ValidationUtils.isDateInPast(pastDate), isTrue);
      expect(ValidationUtils.isDateInPast(futureDate), isFalse);
    });

    test('should check if date is in future', () {
      final pastDate = DateTime.now().subtract(const Duration(days: 1));
      final futureDate = DateTime.now().add(const Duration(days: 1));

      expect(ValidationUtils.isDateInFuture(pastDate), isFalse);
      expect(ValidationUtils.isDateInFuture(futureDate), isTrue);
    });

    test('should validate date range', () {
      final start = DateTime(2023, 1, 1);
      final end = DateTime(2023, 1, 2);
      final invalidEnd = DateTime(2023, 1, 1);

      expect(ValidationUtils.isValidDateRange(start, end), isTrue);
      expect(ValidationUtils.isValidDateRange(start, invalidEnd), isFalse);
    });

    test('should validate color', () {
      expect(ValidationUtils.isValidColor(Colors.blue), isTrue);
      expect(ValidationUtils.isValidColor(null), isFalse);
    });

    test('should validate icon', () {
      expect(ValidationUtils.isValidIcon(Icons.star), isTrue);
      expect(ValidationUtils.isValidIcon(null), isFalse);
    });
  });
}
