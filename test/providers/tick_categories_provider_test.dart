import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/providers/tick_categories_provider.dart';

void main() {
  group('TickCategories Provider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should initialize with empty list', () {
      final categories = container.read(tickCategoriesProvider);
      expect(categories, isEmpty);
    });

    test('should add a new category', () {
      final notifier = container.read(tickCategoriesProvider.notifier);
      final testIcon = IconPickerIcon(
        name: 'test',
        data: Icons.star,
        pack: IconPack.material,
      );

      notifier.add('Test Category', testIcon);

      final categories = container.read(tickCategoriesProvider);
      expect(categories.length, equals(1));
      expect(categories.first.name, equals('Test Category'));
      expect(categories.first.icon.data, equals(Icons.star));
    });

    test('should remove a category by id', () {
      final notifier = container.read(tickCategoriesProvider.notifier);
      final testIcon = IconPickerIcon(
        name: 'test',
        data: Icons.star,
        pack: IconPack.material,
      );

      // Add a category
      notifier.add('Test Category', testIcon);
      final categories = container.read(tickCategoriesProvider);
      final categoryId = categories.first.id;

      // Remove the category
      notifier.remove(categoryId);

      final updatedCategories = container.read(tickCategoriesProvider);
      expect(updatedCategories, isEmpty);
    });

    test('should update a category', () {
      final notifier = container.read(tickCategoriesProvider.notifier);
      final testIcon = IconPickerIcon(
        name: 'test',
        data: Icons.star,
        pack: IconPack.material,
      );

      // Add a category
      notifier.add('Original Name', testIcon);
      final categories = container.read(tickCategoriesProvider);
      final categoryId = categories.first.id;

      // Update the category
      final newIcon = IconPickerIcon(
        name: 'new_test',
        data: Icons.favorite,
        pack: IconPack.material,
      );
      notifier.update(
        id: categoryId,
        name: 'Updated Name',
        icon: newIcon,
      );

      final updatedCategories = container.read(tickCategoriesProvider);
      expect(updatedCategories.first.name, equals('Updated Name'));
      expect(updatedCategories.first.icon.data, equals(Icons.favorite));
    });

    test('should erase all categories', () {
      final notifier = container.read(tickCategoriesProvider.notifier);
      final testIcon = IconPickerIcon(
        name: 'test',
        data: Icons.star,
        pack: IconPack.material,
      );

      // Add multiple categories
      notifier.add('Category 1', testIcon);
      notifier.add('Category 2', testIcon);

      // Erase all
      notifier.erase();

      final categories = container.read(tickCategoriesProvider);
      expect(categories, isEmpty);
    });

    test('should assign different colors to categories', () {
      final notifier = container.read(tickCategoriesProvider.notifier);
      final testIcon = IconPickerIcon(
        name: 'test',
        data: Icons.star,
        pack: IconPack.material,
      );

      notifier.add('Category 1', testIcon);
      notifier.add('Category 2', testIcon);

      final categories = container.read(tickCategoriesProvider);
      expect(categories.length, equals(2));
      expect(categories[0].color, isNot(equals(categories[1].color)));
    });

    test('should generate unique IDs for categories', () {
      final notifier = container.read(tickCategoriesProvider.notifier);
      final testIcon = IconPickerIcon(
        name: 'test',
        data: Icons.star,
        pack: IconPack.material,
      );

      notifier.add('Category 1', testIcon);
      notifier.add('Category 2', testIcon);

      final categories = container.read(tickCategoriesProvider);
      expect(categories.length, equals(2));
      expect(categories[0].id, isNot(equals(categories[1].id)));
    });
  });
}
