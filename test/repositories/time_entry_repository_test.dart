import 'package:flutter_test/flutter_test.dart';
import 'package:tickme/repositories/impl/time_entry_repository_impl.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('TimeEntryRepository Tests', () {
    late TimeEntryRepositoryImpl repository;

    setUp(() {
      repository = TimeEntryRepositoryImpl();
    });

    test('should throw DatabaseException for getTimeEntriesByRange', () async {
      expect(
        () => repository.getTimeEntriesByRange(DateTime.now(), DateTime.now()),
        throwsA(isA<DatabaseException>()),
      );
    });

    test('should throw DatabaseException for insertTimeEntry', () async {
      final entry = TestHelpers.createMockTimeEntry();
      expect(
        () => repository.insertTimeEntry(entry),
        throwsA(isA<DatabaseException>()),
      );
    });

    test('should throw DatabaseException for removeEntriesByCategoryId',
        () async {
      expect(
        () => repository.removeEntriesByCategoryId('test-category'),
        throwsA(isA<DatabaseException>()),
      );
    });

    test('should throw DatabaseException for eraseAllEntries', () async {
      expect(
        () => repository.eraseAllEntries(),
        throwsA(isA<DatabaseException>()),
      );
    });

    test('should throw DatabaseException for getTimeEntriesPartition',
        () async {
      expect(
        () => repository.getTimeEntriesPartition(0, 10),
        throwsA(isA<DatabaseException>()),
      );
    });

    test('should throw DatabaseException for countAllEntries', () async {
      expect(
        () => repository.countAllEntries(),
        throwsA(isA<DatabaseException>()),
      );
    });
  });

  group('DatabaseException Tests', () {
    test('should create exception with message', () {
      const message = 'Test error message';
      final exception = DatabaseException(message);

      expect(exception.message, equals(message));
      expect(exception.toString(), contains(message));
    });

    test('should include DatabaseException in toString', () {
      const message = 'Test error message';
      final exception = DatabaseException(message);

      expect(exception.toString(), contains('DatabaseException'));
      expect(exception.toString(), contains(message));
    });
  });
}
