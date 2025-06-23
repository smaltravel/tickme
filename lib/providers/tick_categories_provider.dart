import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/icon_picker_icon.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/database_provider.dart';
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
    final curr = <TickCategoryModel>[];

    for (final entry in (jsonDecode(pref.getString(_sharedPrefKey) ?? '[]')
        as List<dynamic>)) {
      final e = Map<String, dynamic>.from(entry);
      e['color'] = entry['color'] ??
          TickCategoryModel.serializeColor(
              Colors.primaries[(curr.length + 1) % Colors.primaries.length]);
      curr.add(TickCategoryModel.fromJson(e));
    }

    ref.listenSelf(
        (_, curr) => pref.setString(_sharedPrefKey, jsonEncode(curr)));

    return curr;
  }

  void add(String name, IconPickerIcon icon) {
    state = [
      ...state,
      TickCategoryModel(
        id: _uuid.v7(),
        name: name,
        icon: icon,
        color: Colors.primaries[(state.length + 1) % Colors.primaries.length],
      )
    ];
  }

  void remove(String id) {
    ref.read(databaseStateProvider.notifier).removeEntriesByCategoryId(id);

    state = [
      for (var category in state)
        if (category.id != id) category
    ];
  }

  void update({
    required String id,
    required String name,
    required IconPickerIcon icon,
  }) {
    state = [
      for (var category in state)
        if (category.id == id)
          TickCategoryModel(
            id: category.id,
            name: name,
            icon: icon,
            color: category.color,
          )
        else
          category
    ];
  }

  void erase() {
    ref.read(databaseStateProvider.notifier).eraseAllEntries();

    state = [];
  }
}
