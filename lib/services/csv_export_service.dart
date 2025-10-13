import 'dart:io';
import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/services/database.dart';

class ExportService {
  /// Export time entries to CSV file
  /// Returns the file path of the created CSV file
  static Future<String> exportToCsv(
    DateTime? start,
    DateTime? end,
    Set<int> categories,
  ) async {
    // Create temporary file
    final directory = await getTemporaryDirectory();
    final fileName =
        'tickme_export_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.csv';
    final file = File('${directory.path}/$fileName');

    // Generate CSV content
    final csvContent = await _generateCsvContent(start, end, categories);

    // Write CSV content to file
    await file.writeAsString(csvContent);

    return file.path;
  }

  /// Share CSV file using the system share dialog
  /// Returns the share result
  static Future<ShareResult> shareCsv(
    DateTime? start,
    DateTime? end,
    Set<int> categories,
  ) async {
    final filePath = await exportToCsv(start, end, categories);
    return SharePlus.instance.share(
      ShareParams(files: [XFile(filePath)]),
    );
  }

  /// Generate CSV content from database data
  static Future<String> _generateCsvContent(
    DateTime? start,
    DateTime? end,
    Set<int> categories,
  ) async {
    final buffer = StringBuffer();

    // CSV Header
    buffer.writeln('category,start,end');

    // Get categories for lookup
    final categoriesData = await DatabaseService.allTickCategories;
    final categoryMap = {
      for (final category in categoriesData) category.id: category.name
    };

    // Get and sort entries by start time
    final entries = List<TimeEntryModel>.from(await _getTimeEntries(start, end))
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    // Add data rows
    for (final entry in entries) {
      if (categories.isNotEmpty && !categories.contains(entry.categoryId)) {
        continue;
      }

      final startTime = entry.startTime;
      final endTime = entry.endTime;
      final categoryName = categoryMap[entry.categoryId] ?? 'Unknown';

      buffer.writeln('${_escapeCsvValue(categoryName)},'
          '${_escapeCsvValue(DateFormat('yyyy-MM-dd HH:mm:ss').format(startTime))},'
          '${_escapeCsvValue(DateFormat('yyyy-MM-dd HH:mm:ss').format(endTime))}');
    }

    return buffer.toString();
  }

  /// Get time entries with optional filters
  static Future<List<TimeEntryModel>> _getTimeEntries(
    DateTime? start,
    DateTime? end,
  ) =>
      start == null || end == null
          ? DatabaseService.allTimeEntries
          : (DatabaseService.database.select(DatabaseService.timeEntries)
                ..where((e) =>
                    e.startTime.isBiggerOrEqualValue(start) &
                    e.endTime.isSmallerOrEqualValue(end)))
              .get();

  /// Escape CSV values to handle special characters
  static String _escapeCsvValue(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }
}
