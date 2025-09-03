import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tickme/common/constants/database.dart';

/// Database service that provides a common interface
class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final path =
        '${await getApplicationCacheDirectory()}${DatabaseConstants.databaseName}';

    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: (db, version) async {
        // Create categories table
        await db.execute('''
          CREATE TABLE ${DatabaseConstants.tickCategoriesTable} (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            icon TEXT NOT NULL,
            color TEXT NOT NULL
          )
        ''');

        // Create time entries table
        await db.execute('''
          CREATE TABLE ${DatabaseConstants.timeEntriesTable} (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            categoryId INTEGER NOT NULL,
            startTime TEXT NOT NULL,
            endTime TEXT NOT NULL,
            FOREIGN KEY (categoryId) REFERENCES ${DatabaseConstants.tickCategoriesTable} (id) ON DELETE CASCADE
          )
        ''');

        // Create indexes for better performance
        await db.execute('''
          CREATE INDEX idx_${DatabaseConstants.timeEntriesTable}_categoryId 
          ON ${DatabaseConstants.timeEntriesTable} (categoryId)
        ''');

        await db.execute('''
          CREATE INDEX idx_${DatabaseConstants.timeEntriesTable}_startTime 
          ON ${DatabaseConstants.timeEntriesTable} (startTime)
        ''');

        await db.execute('''
          CREATE INDEX idx_${DatabaseConstants.timeEntriesTable}_endTime 
          ON ${DatabaseConstants.timeEntriesTable} (endTime)
        ''');

        await db.execute('''
          CREATE INDEX idx_${DatabaseConstants.tickCategoriesTable}_name 
          ON ${DatabaseConstants.tickCategoriesTable} (name)
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Handle database upgrades here
        if (oldVersion < 2) {
          // Future upgrade logic
        }
      },
    );
  }

  /// Generic insert method for any table
  static Future<int> insert(String tableName, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Generic update method for any table
  static Future<int> update(
    String tableName,
    Map<String, dynamic> data,
    String where,
    List<Object?> whereArgs,
  ) async {
    final db = await database;
    return await db.update(
      tableName,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }

  /// Generic delete method for any table
  static Future<int> delete(
    String tableName,
    String where,
    List<Object?> whereArgs,
  ) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }

  /// Generic query method for any table
  static Future<List<Map<String, dynamic>>> query(
    String tableName, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    return await db.query(
      tableName,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  /// Generic raw query method
  static Future<List<Map<String, dynamic>>> rawQuery(
    String sql,
    List<Object?>? arguments,
  ) async {
    final db = await database;
    return await db.rawQuery(sql, arguments);
  }

  /// Get row count for any table
  static Future<int> getRowCount(String tableName) async {
    final result = await rawQuery('SELECT COUNT(*) FROM $tableName', null);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Close the database connection
  static Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  /// Check if database is open
  static bool get isOpen => _database != null;
}
