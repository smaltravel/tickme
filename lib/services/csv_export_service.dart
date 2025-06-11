import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/services/database_service.dart';

class CsvExportService {
  final Map<String, String> _categoryMap = {};

  CsvExportService(TickCategoriesStorage categories) {
    // Initialize the category map with category IDs and names
    for (var category in categories) {
      _categoryMap[category.id] = category.name;
    }
  }

  Future<String?> exportToCsv() async {
    // 1. Request Storage Permission
    if (await Permission.storage.request().isGranted) {
      // 2. Setup file path and headers
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/tickme_export_${DateTime.now().microsecondsSinceEpoch}.csv';
      final file = File(filePath);

      // Define headers
      final headers = ['Category', 'Start Time', 'End Time'];

      // Write headers to the file. Use FileMode.write to create/overwrite the file.
      await file.writeAsString('${headers.join(',')}\n', mode: FileMode.write);

      // 3. Read data by partitions and append to file
      const int pageSize = 1000; // Number of entries to read per partition
      int offset = 0;

      while (true) {
        final entries =
            await DatabaseService.readTimeEntriesPartition(offset, pageSize);

        if (entries.isEmpty) {
          break; // No more data to read
        }

        // Convert entries to CSV format
        final csvRows = entries.map((entry) {
          final categoryName = _categoryMap[entry.categoryId] ?? 'Unknown';
          return '"$categoryName","${entry.startTime}","${entry.endTime}"';
        }).join('\n');

        // Append the CSV rows to the file
        await file.writeAsString(csvRows, mode: FileMode.append);
        offset += pageSize; // Move to the next partition
      }

      return filePath; // Return the path of the created CSV file
    }

    return null; // Return null if permission is not granted
  }
}
