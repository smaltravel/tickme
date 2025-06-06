import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/models/category.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';
import 'package:uuid/uuid.dart';

part 'generated/tick_category_provider.g.dart';

const _sharedPrefKey = 'categories_list';
const _uuid = Uuid();

typedef TickCategoryStorage = List<Category>;

@Riverpod(keepAlive: true)
class TickCategory extends _$TickCategory {
  @override
  TickCategoryStorage build() {
    final pref = ref.watch(sharedPreferencesProvider);
    final currentState = [
      for (var entry in (jsonDecode(pref.getString(_sharedPrefKey) ?? '[]')
          as List<dynamic>))
        Category.fromJson(entry as Map<String, dynamic>)
    ];

    ref.listenSelf(
        (_, curr) => pref.setString(_sharedPrefKey, jsonEncode(curr)));

    return currentState;
  }

  void add(String name) {
    state = [...state, Category(id: _uuid.v7(), name: name)];
  }

  void remove(String id) {
    state = [
      for (var category in state)
        if (category.id != id) category
    ];
  }

  void rename({required String id, required String name}) {
    state = [
      for (var category in state)
        if (category.id == id)
          Category(id: category.id, name: name)
        else
          category
    ];
  }

  void erase() {
    state = [];
  }
}
