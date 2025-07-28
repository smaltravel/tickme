import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tickme/models/time_entry.dart';

class DatabaseService {
  static Database? _database;
  static const String _dbName = 'tickme.db';
  static const int _dbVersion = 1;
  static const String _tableName = 'time_entries';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final path = '${await getApplicationDocumentsDirectory()}$_dbName';

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            categoryId STRING NOT NULL UNIQUE,
            startTime STRING NOT NULL,
            endTime STRING NOT NULL
          )
        ''');
      },
    );
  }

  // --- CRUD Operations ---

  static Future<int> insertTimeEntry(TimeEntryModel entry) async {
    final db = await database;
    return await db.insert(
      _tableName,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> removeEntriesByCategoryId(String categoryId) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );
  }

  static Future<int> eraseAllEntries() async {
    final db = await database;
    return await db.delete(_tableName);
  }

  static Future<List<TimeEntryModel>> readTimeEntriesPartition(
      int offset, int limit) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy:
          'startTime DESC', // Order by start time for consistent pagination
      limit: limit,
      offset: offset,
    );

    return List.generate(maps.length, (i) {
      return TimeEntryModel.fromMap(maps[i]);
    });
  }

  static Future<int> countAllEntries() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $_tableName');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<List<TimeEntryModel>> getTimeEntriesByRange(
      DateTime start, DateTime end) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where:
          'startTime >= ? AND endTime >= ? AND startTime <= ? AND endTime <= ?',
      whereArgs: [
        start.toIso8601String(),
        start.toIso8601String(),
        end.toIso8601String(),
        end.toIso8601String()
      ],
      orderBy: 'startTime DESC',
    );

    return List.generate(maps.length, (i) {
      return TimeEntryModel.fromMap(maps[i]);
    });
  }
}
