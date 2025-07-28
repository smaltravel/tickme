import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tickme/constants/database_constants.dart';
import 'package:tickme/models/time_entry.dart';
import 'package:tickme/services/database_migration_service.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final path =
        '${await getApplicationCacheDirectory()}${DatabaseConstants.dbName}';

    try {
      return await openDatabase(
        path,
        version: DatabaseConstants.dbVersion,
        onCreate: (db, version) async {
          await DatabaseMigrationService.createInitialSchema(db);
          await DatabaseMigrationService.createIndexes(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          await DatabaseMigrationService.migrate(db, oldVersion, newVersion);
        },
      );
    } catch (e) {
      debugPrint('Database initialization error: $e');
      rethrow;
    }
  }

  // --- CRUD Operations ---

  static Future<int> insertTimeEntry(TimeEntryModel entry) async {
    try {
      final db = await database;
      return await db.insert(
        DatabaseConstants.timeEntriesTable,
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint('insertTimeEntry error: $e');
      rethrow;
    }
  }

  static Future<int> removeEntriesByCategoryId(String categoryId) async {
    try {
      final db = await database;
      return await db.delete(
        DatabaseConstants.timeEntriesTable,
        where: '${DatabaseConstants.categoryIdColumn} = ?',
        whereArgs: [categoryId],
      );
    } catch (e) {
      debugPrint('removeEntriesByCategoryId error: $e');
      rethrow;
    }
  }

  static Future<int> eraseAllEntries() async {
    try {
      final db = await database;
      return await db.delete(DatabaseConstants.timeEntriesTable);
    } catch (e) {
      debugPrint('eraseAllEntries error: $e');
      rethrow;
    }
  }

  static Future<List<TimeEntryModel>> readTimeEntriesPartition(
      int offset, int limit) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseConstants.timeEntriesTable,
        orderBy: DatabaseConstants.orderByStartTime,
        limit: limit,
        offset: offset,
      );

      return List.generate(maps.length, (i) {
        return TimeEntryModel.fromMap(maps[i]);
      });
    } catch (e) {
      debugPrint('readTimeEntriesPartition error: $e');
      rethrow;
    }
  }

  static Future<int> countAllEntries() async {
    try {
      final db = await database;
      final result = await db.rawQuery(DatabaseConstants.countAllEntries);
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      debugPrint('countAllEntries error: $e');
      rethrow;
    }
  }

  static Future<List<TimeEntryModel>> getTimeEntriesByRange(
      DateTime start, DateTime end) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseConstants.timeEntriesTable,
        where: DatabaseConstants.selectTimeEntriesByRange,
        whereArgs: [
          start.toIso8601String(),
          start.toIso8601String(),
          end.toIso8601String(),
          end.toIso8601String()
        ],
        orderBy: DatabaseConstants.orderByStartTime,
      );

      return List.generate(maps.length, (i) {
        return TimeEntryModel.fromMap(maps[i]);
      });
    } catch (e) {
      debugPrint('getTimeEntriesByRange error: $e');
      rethrow;
    }
  }

  /// Validate database integrity
  static Future<bool> validateDatabase() async {
    try {
      final db = await database;
      return await DatabaseMigrationService.validateDatabase(db);
    } catch (e) {
      debugPrint('validateDatabase error: $e');
      return false;
    }
  }

  /// Close database connection
  static Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
