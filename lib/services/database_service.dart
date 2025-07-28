import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tickme/constants/database_constants.dart';
import 'package:tickme/models/time_entry.dart';

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

    return await openDatabase(
      path,
      version: DatabaseConstants.dbVersion,
      onCreate: (db, version) async {
        await db.execute(DatabaseConstants.createTimeEntriesTable);
      },
    );
  }

  // --- CRUD Operations ---

  static Future<int> insertTimeEntry(TimeEntryModel entry) async {
    final db = await database;
    return await db.insert(
      DatabaseConstants.timeEntriesTable,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> removeEntriesByCategoryId(String categoryId) async {
    final db = await database;
    return await db.delete(
      DatabaseConstants.timeEntriesTable,
      where: '${DatabaseConstants.categoryIdColumn} = ?',
      whereArgs: [categoryId],
    );
  }

  static Future<int> eraseAllEntries() async {
    final db = await database;
    return await db.delete(DatabaseConstants.timeEntriesTable);
  }

  static Future<List<TimeEntryModel>> readTimeEntriesPartition(
      int offset, int limit) async {
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
  }

  static Future<int> countAllEntries() async {
    final db = await database;
    final result = await db.rawQuery(DatabaseConstants.countAllEntries);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<List<TimeEntryModel>> getTimeEntriesByRange(
      DateTime start, DateTime end) async {
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
  }
}
