import 'package:tickme/models/time_entry.dart';

/// Split a time entry by days if it spans multiple days
List<TimeEntryModel> splitEntryByDays(TimeEntryModel entry) {
  final startDate = DateTime(
      entry.startTime.year, entry.startTime.month, entry.startTime.day);
  final endDate =
      DateTime(entry.endTime.year, entry.endTime.month, entry.endTime.day);

  // If the entry is within the same day, return as is
  if (startDate.isAtSameMomentAs(endDate)) {
    return [entry];
  }

  final List<TimeEntryModel> splitEntries = [];
  DateTime currentDate = startDate;

  while (
      currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
    final dayStart = currentDate.isAtSameMomentAs(startDate)
        ? entry.startTime
        : DateTime(currentDate.year, currentDate.month, currentDate.day);

    final dayEnd = currentDate.isAtSameMomentAs(endDate)
        ? entry.endTime
        : DateTime(currentDate.year, currentDate.month, currentDate.day, 23, 59,
            59, 999);

    splitEntries.add(entry.copyWith(
      startTime: dayStart,
      endTime: dayEnd,
    ));

    currentDate = currentDate.add(const Duration(days: 1));
  }

  return splitEntries;
}

List<String> formatDuration(Duration duration) {
  return [
    duration.inHours.toString().padLeft(2, '0'),
    duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
    duration.inSeconds.remainder(60).toString().padLeft(2, '0'),
  ];
}
