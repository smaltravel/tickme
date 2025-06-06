import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickme/models/category.dart';
import 'package:tickme/models/time_entry.dart';

class DataManager {
  static const String _categoriesKey = 'categories';
  static const String _timeEntriesKey = 'time_entries';

  // Helper function to save data to SharedPreferences
  static Future<void> saveData(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonEncodeResult = jsonEncode(data);

    await prefs.setString(key, jsonEncodeResult);
  }

  // Helper function to load data from SharedPreferences
  static Future<dynamic> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString != null) {
      try {
        return jsonDecode(jsonString);
      } catch (e) {
        print('Error decoding JSON: $e');
        return null;
      }
    }
    return null;
  }

  // Example: Load Categories
  static Future<List<Category>> loadCategories() async {
    final categoriesData = await loadData(_categoriesKey);
    if (categoriesData == null) {
      return [];
    }
    return categoriesData.cast<Category>();
  }

  // Example: Load Time Entries
  static Future<List<TimeEntry>> loadTimeEntries() async {
    final timeEntriesData = await loadData(_timeEntriesKey);
    if (timeEntriesData == null) {
      return [];
    }
    return timeEntriesData.cast<TimeEntry>();
  }

  // Example: Save Categories (for demonstration purposes)
  static void saveCategories(List<Category> categories) async {
    await saveData(_categoriesKey, categories);
  }

  // Example: Save Time Entries (for demonstration purposes)
  static void saveTimeEntries(List<TimeEntry> timeEntries) async {
    await saveData(_timeEntriesKey, timeEntries);
  }
}
