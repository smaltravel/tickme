import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tickme/common/constants/database.dart';

class DatabaseService {
  static Future<Database> get database async {
    final path =
        '${await getApplicationCacheDirectory()}${DatabaseConstants.databaseName}';

    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ${DatabaseConstants.tickCategoriesTable} (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name STRING NOT NULL,
            icon STRING NOT NULL,
            color STRING NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE ${DatabaseConstants.timeEntriesTable} (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            categoryId INTEGER NOT NULL,
            startTime STRING NOT NULL,
            endTime STRING NOT NULL,
            FOREIGN KEY (categoryId) REFERENCES ${DatabaseConstants.tickCategoriesTable} (id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE INDEX idx_${DatabaseConstants.timeEntriesTable}_startTime ON ${DatabaseConstants.timeEntriesTable} (startTime)
        ''');
        await db.execute('''
          CREATE INDEX idx_${DatabaseConstants.timeEntriesTable}_endTime ON ${DatabaseConstants.timeEntriesTable} (endTime)
        ''');
        await db.execute('''
          CREATE INDEX idx_${DatabaseConstants.tickCategoriesTable}_name ON ${DatabaseConstants.tickCategoriesTable} (name)
        ''');
      },
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    await db.insert(table, data);
  }

  static Future<void> update(String table, Map<String, dynamic> data) async {
    final db = await database;
    await db.update(table, data);
  }

  static Future<void> delete(String table, int id) async {
    final db = await database;
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> query(
      String table, String where, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }
}
