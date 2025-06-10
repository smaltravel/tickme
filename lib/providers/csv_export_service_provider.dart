import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/services/csv_export_service.dart';

final csvExportServiceProvider = Provider((ref) {
  final categories = ref.watch(tickCategoriesProvider);
  return CsvExportService(categories);
});
