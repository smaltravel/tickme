import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickme/common/constants/database.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/services/database.dart';

part 'generated/tick_categories_provider.g.dart';

typedef TickCategoriesState = List<TickCategoryModel>;

@Riverpod(keepAlive: true)
class TickCategories extends _$TickCategories {
  @override
  Future<TickCategoriesState> build() async =>
      (await DatabaseService.query(DatabaseConstants.tickCategoriesTable))
          .map((row) => TickCategoryModel.fromJson(row))
          .toList();

  Future<void> add(TickCategoryModel category) async {
    await DatabaseService.insert(
        DatabaseConstants.tickCategoriesTable, category.toJson());

    // Update the state with new categories
    ref.invalidateSelf();
  }

  Future<void> remove(String id) async {
    await DatabaseService.delete(
        DatabaseConstants.tickCategoriesTable, 'id = ?', [id]);

    // Update the state with new categories
    ref.invalidateSelf();
  }

  Future<void> refresh(TickCategoryModel category) async {
    await DatabaseService.update(DatabaseConstants.tickCategoriesTable,
        category.toJson(), 'id = ?', [category.id]);

    // Update the state with new categories
    ref.invalidateSelf();
  }
}
