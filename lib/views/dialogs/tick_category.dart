import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/icon_picker_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/views/widgets/tick_category_edit.dart';

Future<void> showTickCategoryDialog(
    BuildContext context, WidgetRef ref, TickCategoryModel? category) {
  final nameController = TextEditingController(text: category?.name ?? '');
  IconPickerIcon currentIcon = category?.icon ?? unknownTickIcon;
  Color currentColor = category?.color ?? Colors.grey;

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(category == null
            ? context.loc.home_new_category
            : context.loc.home_edit_category),
        content: TickCategoryEdit(
          icon: currentIcon,
          color: currentColor,
          nameController: nameController,
          onIconSelected: (icon) => currentIcon = icon ?? unknownTickIcon,
          onColorSelected: (color) => currentColor = color,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.loc.cancel),
          ),
          ElevatedButton(
            onPressed: () => _saveChanges(
                ref, category, nameController.text, currentIcon, currentColor),
            child: Text(category == null
                ? context.loc.add
                : context.loc.home_edit_category_update),
          ),
        ],
      ),
    ),
  );
}

void _saveChanges(WidgetRef ref, TickCategoryModel? category, String name,
    IconPickerIcon icon, Color color) {
  final provider = ref.read(tickCategoriesProvider.notifier);
  if (category != null) {
    provider.updateCategory(
        category.copyWith(name: name, icon: icon, color: color));
  } else {
    provider.createCategory(
        TickCategoryModel(name: name, icon: icon, color: color));
  }
}
