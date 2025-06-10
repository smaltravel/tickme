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
    final path = '${await getDatabasesPath()}$_dbName';

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
}
