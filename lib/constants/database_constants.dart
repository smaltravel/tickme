class DatabaseConstants {
  // Database Configuration
  static const String dbName = 'tickme.db';
  static const int dbVersion = 1;

  // Tables
  static const String timeEntriesTable = 'time_entries';

  // Columns
  static const String idColumn = 'id';
  static const String categoryIdColumn = 'categoryId';
  static const String startTimeColumn = 'startTime';
  static const String endTimeColumn = 'endTime';

  // SQL Queries
  static const String createTimeEntriesTable = '''
    CREATE TABLE $timeEntriesTable (
      $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
      $categoryIdColumn STRING NOT NULL UNIQUE,
      $startTimeColumn STRING NOT NULL,
      $endTimeColumn STRING NOT NULL
    )
  ''';

  static const String selectAllTimeEntries = 'SELECT * FROM $timeEntriesTable';
  static const String selectTimeEntriesByRange = '''
    $startTimeColumn >= ? AND $endTimeColumn >= ? 
    AND $startTimeColumn <= ? AND $endTimeColumn <= ?
  ''';

  static const String deleteByCategoryId =
      'DELETE FROM $timeEntriesTable WHERE $categoryIdColumn = ?';
  static const String deleteAllEntries = 'DELETE FROM $timeEntriesTable';
  static const String countAllEntries =
      'SELECT COUNT(*) FROM $timeEntriesTable';
  static const String orderByStartTime =
      '${DatabaseConstants.startTimeColumn} DESC';
}
