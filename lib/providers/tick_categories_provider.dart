import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/services/database.dart';

part 'generated/tick_categories_provider.g.dart';

typedef TickCategoriesState = List<TickCategoryModel>;

@Riverpod(keepAlive: true)
class TickCategories extends _$TickCategories {
  @override
  Future<TickCategoriesState> build() => DatabaseService.allTickCategories;

  Future<void> createCategory(TickCategoryModel category) async {
    await DatabaseService.tickCategories.insertOne(
        TickCategoriesCompanion.insert(
            name: category.name,
            icon: category.iconString,
            color: category.colorString));

    // Update the state with new categories
    ref.invalidateSelf();
  }

  Future<void> removeCategory(int id) async {
    await DatabaseService.tickCategories
        .deleteOne(TickCategoriesCompanion(id: Value<int>(id)));

    // Update the state with new categories
    ref.invalidateSelf();
  }

  Future<void> removeAllCategories() async {
    await DatabaseService.tickCategories.deleteAll();

    // Update the state with new categories
    ref.invalidateSelf();
  }

  Future<void> updateCategory(TickCategoryModel category) async {
    await DatabaseService.database
        .update(DatabaseService.tickCategories)
        .replace(TickCategoriesCompanion.insert(
          id: Value<int>(category.id!),
          name: category.name,
          icon: category.iconString,
          color: category.colorString,
        ));

    // Update the state with new categories
    ref.invalidateSelf();
  }
}
