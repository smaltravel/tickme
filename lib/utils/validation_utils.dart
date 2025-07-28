class ValidationUtils {
  /// Validates if a string is not null, not empty, and not just whitespace
  static bool isValidString(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Validates if a string length is within the specified range
  static bool isValidStringLength(String? value, int minLength, int maxLength) {
    if (!isValidString(value)) return false;
    final length = value!.trim().length;
    return length >= minLength && length <= maxLength;
  }

  /// Validates if a string is a valid category name
  static bool isValidCategoryName(String? value) {
    return isValidStringLength(value, 1, 20);
  }

  /// Validates if a duration is positive
  static bool isValidDuration(Duration duration) {
    return duration.inSeconds > 0;
  }

  /// Validates if a date is in the past
  static bool isDateInPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Validates if a date is in the future
  static bool isDateInFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  /// Validates if a start date is before an end date
  static bool isValidDateRange(DateTime start, DateTime end) {
    return start.isBefore(end);
  }

  /// Validates if a color is not null
  static bool isValidColor(dynamic color) {
    return color != null;
  }

  /// Validates if an icon is not null
  static bool isValidIcon(dynamic icon) {
    return icon != null;
  }
}
