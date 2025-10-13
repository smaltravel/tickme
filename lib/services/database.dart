import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tickme/common/constants/database.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/models/time_entry.dart';

part 'generated/database.g.dart';

@DriftDatabase(tables: [TickCategories, TimeEntries])
class TickMeDatabase extends _$TickMeDatabase {
  TickMeDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  @override
  int get schemaVersion => DatabaseConstants.databaseVersion;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: DatabaseConstants.databaseName,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationDocumentsDirectory,
      ),
    );
  }
}

/// Database service that provides a common interface
class DatabaseService {
  static final database = TickMeDatabase();

  static $TickCategoriesTable get tickCategories => database.tickCategories;

  static $TimeEntriesTable get timeEntries => database.timeEntries;

  static Future<List<TickCategoryModel>> get allTickCategories =>
      database.select(tickCategories).get();

  static Future<List<TimeEntryModel>> get allTimeEntries =>
      database.select(timeEntries).get();
}
