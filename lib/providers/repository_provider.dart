import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/repositories/impl/time_entry_repository_impl.dart';
import 'package:tickme/repositories/time_entry_repository.dart';

/// Provider for TimeEntryRepository
final timeEntryRepositoryProvider = Provider<TimeEntryRepository>((ref) {
  return TimeEntryRepositoryImpl();
});
