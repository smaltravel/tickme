import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/shared_preferences_provider.dart';
import 'package:uuid/uuid.dart';

part 'generated/tick_categories_provider.g.dart';

const _sharedPrefKey = 'categories_list';
const _uuid = Uuid();

typedef TickCategoriesStorage = List<TickCategoryModel>;

@Riverpod(keepAlive: true)
class TickCategories extends _$TickCategories {
  @override
  TickCategoriesStorage build() {
    final pref = ref.watch(sharedPreferencesProvider);
    final currentState = [
      for (var entry in (jsonDecode(pref.getString(_sharedPrefKey) ?? '[]')
          as List<dynamic>))
        TickCategoryModel.fromJson(entry as Map<String, dynamic>)
    ];

    ref.listenSelf(
        (_, curr) => pref.setString(_sharedPrefKey, jsonEncode(curr)));

    return currentState;
  }

  void add(String name) {
    state = [...state, TickCategoryModel(id: _uuid.v7(), name: name)];
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
          TickCategoryModel(id: category.id, name: name)
        else
          category
    ];
  }

  void erase() {
    state = [];
  }
}
