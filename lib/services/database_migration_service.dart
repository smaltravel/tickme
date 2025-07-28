import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tickme/constants/database_constants.dart';

/// Service to handle database migrations
class DatabaseMigrationService {
  /// Migrate database from one version to another
  static Future<void> migrate(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Add migration logic here when needed
      // Example:
      // if (oldVersion < 2) {
      //   await _migrateToVersion2(db);
      // }
      // if (oldVersion < 3) {
      //   await _migrateToVersion3(db);
      // }
    }
  }

  /// Create initial database schema
  static Future<void> createInitialSchema(Database db) async {
    await db.execute(DatabaseConstants.createTimeEntriesTable);
  }

  /// Add indexes for better performance
  static Future<void> createIndexes(Database db) async {
    // Index for faster category-based queries
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_category_id 
      ON ${DatabaseConstants.timeEntriesTable} (${DatabaseConstants.categoryIdColumn})
    ''');

    // Index for faster time-based queries
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_start_time 
      ON ${DatabaseConstants.timeEntriesTable} (${DatabaseConstants.startTimeColumn})
    ''');

    // Index for faster range queries
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_end_time 
      ON ${DatabaseConstants.timeEntriesTable} (${DatabaseConstants.endTimeColumn})
    ''');
  }

  /// Validate database integrity
  static Future<bool> validateDatabase(Database db) async {
    try {
      // Check if tables exist
      final tables = await db.query('sqlite_master',
          where: 'type = ? AND name = ?',
          whereArgs: ['table', DatabaseConstants.timeEntriesTable]);

      if (tables.isEmpty) {
        return false;
      }

      // Check if table has required columns
      final pragma = await db
          .rawQuery('PRAGMA table_info(${DatabaseConstants.timeEntriesTable})');
      final columnNames = pragma.map((col) => col['name'] as String).toList();

      final requiredColumns = [
        DatabaseConstants.idColumn,
        DatabaseConstants.categoryIdColumn,
        DatabaseConstants.startTimeColumn,
        DatabaseConstants.endTimeColumn,
      ];

      for (final column in requiredColumns) {
        if (!columnNames.contains(column)) {
          return false;
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Backup database before migration
  static Future<void> backupDatabase(Database db) async {
    // This would implement database backup logic
    // For now, we'll just log that backup would happen
    debugPrint('Database backup would be performed here');
  }

  /// Restore database from backup
  static Future<void> restoreDatabase(Database db) async {
    // This would implement database restore logic
    // For now, we'll just log that restore would happen
    debugPrint('Database restore would be performed here');
  }
}
