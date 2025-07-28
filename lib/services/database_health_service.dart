import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tickme/constants/database_constants.dart';
import 'package:tickme/services/database_service.dart';

/// Service to monitor database health and performance
class DatabaseHealthService {
  /// Check database health and return status
  static Future<DatabaseHealthStatus> checkHealth() async {
    try {
      final db = await DatabaseService.database;

      // Check database integrity
      final integrityCheck = await _checkIntegrity(db);
      if (!integrityCheck.isHealthy) {
        return integrityCheck;
      }

      // Check performance
      final performanceCheck = await _checkPerformance(db);
      if (!performanceCheck.isHealthy) {
        return performanceCheck;
      }

      // Check data consistency
      final consistencyCheck = await _checkDataConsistency(db);
      if (!consistencyCheck.isHealthy) {
        return consistencyCheck;
      }

      return DatabaseHealthStatus.healthy();
    } catch (e) {
      debugPrint('Database health check error: $e');
      return DatabaseHealthStatus.unhealthy(
        'Database connection failed: $e',
        DatabaseHealthIssue.connection,
      );
    }
  }

  /// Check database integrity
  static Future<DatabaseHealthStatus> _checkIntegrity(Database db) async {
    try {
      // Check if tables exist
      final tables = await db.query('sqlite_master',
          where: 'type = ? AND name = ?',
          whereArgs: ['table', DatabaseConstants.timeEntriesTable]);

      if (tables.isEmpty) {
        return DatabaseHealthStatus.unhealthy(
          'Required table ${DatabaseConstants.timeEntriesTable} not found',
          DatabaseHealthIssue.missingTable,
        );
      }

      // Check if indexes exist
      final indexes = await db.query('sqlite_master',
          where: 'type = ? AND name LIKE ?', whereArgs: ['index', 'idx_%']);

      if (indexes.length < 3) {
        return DatabaseHealthStatus.unhealthy(
          'Missing database indexes for optimal performance',
          DatabaseHealthIssue.missingIndexes,
        );
      }

      return DatabaseHealthStatus.healthy();
    } catch (e) {
      return DatabaseHealthStatus.unhealthy(
        'Database integrity check failed: $e',
        DatabaseHealthIssue.integrity,
      );
    }
  }

  /// Check database performance
  static Future<DatabaseHealthStatus> _checkPerformance(Database db) async {
    try {
      // Check table size
      final countResult = await db.rawQuery(DatabaseConstants.countAllEntries);
      final rowCount = Sqflite.firstIntValue(countResult) ?? 0;

      if (rowCount > 10000) {
        return DatabaseHealthStatus.unhealthy(
          'Large dataset detected ($rowCount rows). Consider data cleanup.',
          DatabaseHealthIssue.performance,
        );
      }

      // Check for slow queries (simplified check)
      final startTime = DateTime.now();
      await db.query(DatabaseConstants.timeEntriesTable, limit: 1);
      final queryTime = DateTime.now().difference(startTime);

      if (queryTime.inMilliseconds > 100) {
        return DatabaseHealthStatus.unhealthy(
          'Slow query performance detected',
          DatabaseHealthIssue.performance,
        );
      }

      return DatabaseHealthStatus.healthy();
    } catch (e) {
      return DatabaseHealthStatus.unhealthy(
        'Performance check failed: $e',
        DatabaseHealthIssue.performance,
      );
    }
  }

  /// Check data consistency
  static Future<DatabaseHealthStatus> _checkDataConsistency(Database db) async {
    try {
      // Check for orphaned entries (entries without valid category)
      final orphanedQuery = '''
        SELECT COUNT(*) FROM ${DatabaseConstants.timeEntriesTable} 
        WHERE ${DatabaseConstants.categoryIdColumn} IS NULL 
        OR ${DatabaseConstants.categoryIdColumn} = ''
      ''';

      final orphanedResult = await db.rawQuery(orphanedQuery);
      final orphanedCount = Sqflite.firstIntValue(orphanedResult) ?? 0;

      if (orphanedCount > 0) {
        return DatabaseHealthStatus.unhealthy(
          'Found $orphanedCount orphaned time entries',
          DatabaseHealthIssue.dataConsistency,
        );
      }

      // Check for invalid date ranges
      final invalidDateQuery = '''
        SELECT COUNT(*) FROM ${DatabaseConstants.timeEntriesTable} 
        WHERE ${DatabaseConstants.startTimeColumn} >= ${DatabaseConstants.endTimeColumn}
      ''';

      final invalidDateResult = await db.rawQuery(invalidDateQuery);
      final invalidDateCount = Sqflite.firstIntValue(invalidDateResult) ?? 0;

      if (invalidDateCount > 0) {
        return DatabaseHealthStatus.unhealthy(
          'Found $invalidDateCount entries with invalid date ranges',
          DatabaseHealthIssue.dataConsistency,
        );
      }

      return DatabaseHealthStatus.healthy();
    } catch (e) {
      return DatabaseHealthStatus.unhealthy(
        'Data consistency check failed: $e',
        DatabaseHealthIssue.dataConsistency,
      );
    }
  }

  /// Get database statistics
  static Future<DatabaseStats> getStats() async {
    try {
      final db = await DatabaseService.database;

      final countResult = await db.rawQuery(DatabaseConstants.countAllEntries);
      final totalEntries = Sqflite.firstIntValue(countResult) ?? 0;

      // Get database file size (approximate)
      final dbInfo = await db.getVersion();

      return DatabaseStats(
        totalEntries: totalEntries,
        databaseVersion: dbInfo,
        lastCheck: DateTime.now(),
      );
    } catch (e) {
      debugPrint('Get database stats error: $e');
      rethrow;
    }
  }
}

/// Database health status
class DatabaseHealthStatus {
  final bool isHealthy;
  final String? message;
  final DatabaseHealthIssue? issue;

  const DatabaseHealthStatus._({
    required this.isHealthy,
    this.message,
    this.issue,
  });

  factory DatabaseHealthStatus.healthy() {
    return const DatabaseHealthStatus._(isHealthy: true);
  }

  factory DatabaseHealthStatus.unhealthy(
      String message, DatabaseHealthIssue issue) {
    return DatabaseHealthStatus._(
      isHealthy: false,
      message: message,
      issue: issue,
    );
  }
}

/// Database health issues
enum DatabaseHealthIssue {
  connection,
  missingTable,
  missingIndexes,
  integrity,
  performance,
  dataConsistency,
}

/// Database statistics
class DatabaseStats {
  final int totalEntries;
  final int databaseVersion;
  final DateTime lastCheck;

  const DatabaseStats({
    required this.totalEntries,
    required this.databaseVersion,
    required this.lastCheck,
  });
}
