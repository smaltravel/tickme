import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tickme/common/constants/database.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/models/tick_category.dart';
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

    // Get time entries with filters
    final entries = await _getTimeEntries(start, end, categories);

    // Get categories for lookup
    final categoriesData = await _getCategories();
    final categoryMap = {
      for (final category in categoriesData) category.id: category.name
    };

    // Sort entries by start time
    final sortedEntries = List<TimeEntryModel>.from(entries)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    // Add data rows
    for (final entry in sortedEntries) {
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
    Set<int> categories,
  ) async {
    final whereConditions = <String>[];
    final whereArgs = <Object?>[];

    if (start != null) {
      whereConditions.add('startTime >= ?');
      whereArgs.add(start.toIso8601String());
    }

    if (end != null) {
      whereConditions.add('endTime <= ?');
      whereArgs.add(end.toIso8601String());
    }

    if (categories.isNotEmpty) {
      final placeholders = List.filled(categories.length, '?').join(',');
      whereConditions.add('categoryId IN ($placeholders)');
      whereArgs.addAll(categories);
    }

    final whereClause =
        whereConditions.isNotEmpty ? whereConditions.join(' AND ') : null;

    final results = await DatabaseService.query(
      DatabaseConstants.timeEntriesTable,
      where: whereClause,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'startTime ASC',
    );

    return results.map((row) => TimeEntryModel.fromJson(row)).toList();
  }

  /// Get all categories
  static Future<List<TickCategoryModel>> _getCategories() async {
    final results =
        await DatabaseService.query(DatabaseConstants.tickCategoriesTable);
    return results.map((row) => TickCategoryModel.fromJson(row)).toList();
  }

  /// Escape CSV values to handle special characters
  static String _escapeCsvValue(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }
}
