import 'package:tickme/models/time_range.dart';

class AppDateUtils {
  /// Formats a duration into a readable string (HH:MM:SS)
  static String formatDuration(Duration duration) {
    return formatDurationAsList(duration).join();
  }

  /// Formats a duration into a list of strings for display
  static List<String> formatDurationAsList(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return [hours, ':', minutes, ':', seconds];
  }

  /// Calculates the start of the day for a given date
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Calculates the end of the day for a given date
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day + 1);
  }

  /// Calculates the start of the week for a given date
  static DateTime startOfWeek(DateTime date) {
    final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return DateTime(
        firstDayOfWeek.year, firstDayOfWeek.month, firstDayOfWeek.day);
  }

  /// Calculates the end of the week for a given date
  static DateTime endOfWeek(DateTime date) {
    final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return DateTime(
        firstDayOfWeek.year, firstDayOfWeek.month, firstDayOfWeek.day + 7);
  }

  /// Calculates the start of the month for a given date
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Calculates the end of the month for a given date
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 1);
  }

  /// Checks if a date is within a time range
  static bool isDateInRange(DateTime date, TimeRangeModel range) {
    return date.isAfter(range.start) && date.isBefore(range.end);
  }

  /// Gets the current time range based on calendar type
  static TimeRangeModel getCurrentTimeRange(Calendar calendar) {
    final now = DateTime.now();
    switch (calendar) {
      case Calendar.day:
        return TimeRangeModel(
          calendar: calendar,
          start: startOfDay(now),
          end: endOfDay(now),
        );
      case Calendar.week:
        return TimeRangeModel(
          calendar: calendar,
          start: startOfWeek(now),
          end: endOfWeek(now),
        );
      case Calendar.month:
        return TimeRangeModel(
          calendar: calendar,
          start: startOfMonth(now),
          end: endOfMonth(now),
        );
    }
  }
}
