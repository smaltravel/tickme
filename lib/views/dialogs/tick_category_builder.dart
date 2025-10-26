import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';
import 'package:tickme/common/constants/app.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/views/widgets/dialogs/color_picker_card.dart';
import 'package:tickme/views/widgets/dialogs/icon_picker_card.dart';

Widget buildTickCategoryDialog(BuildContext context, WidgetRef ref, TickCategoryModel? category) {
  var currentCategory = category?.copyWith() ?? unknownTickCategory;
  final nameController = TextEditingController(text: currentCategory.id != null ? currentCategory.name : '');

  return StatefulBuilder(
    builder: (context, setState) => AlertDialog(
      title: Text(category == null ? context.loc.home_new_category : context.loc.home_edit_category),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: AppConstants.defaultSizedBox),
          IconPickerCard(
            color: currentCategory.color,
            icon: currentCategory.icon,
            onIconSelected: (icon) => setState(() => currentCategory = currentCategory.copyWith(
                  icon: icon,
                  name: nameController.text,
                )),
          ),
          const SizedBox(height: AppConstants.defaultSizedBox),
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: context.loc.home_edit_category_name),
          ),
          const SizedBox(height: AppConstants.defaultSizedBox),
          ColorPickerCard(
            color: currentCategory.color,
            onColorSelected: (color) => setState(() => currentCategory = currentCategory.copyWith(
                  color: color,
                  name: nameController.text,
                )),
          ),
        ],
      ),
      actions: <Widget>[
        MoonTextButton(
          onTap: () => Navigator.of(context).pop(),
          label: Text(context.loc.cancel),
        ),
        MoonFilledButton(
          onTap: () {
            Navigator.of(context).pop();
            _saveChanges(ref, currentCategory.copyWith(name: nameController.text));
          },
          label: Text(category == null ? context.loc.add : context.loc.home_edit_category_update),
        ),
      ],
    ),
  );
}

void _saveChanges(WidgetRef ref, TickCategoryModel category) {
  final repository = ref.read(tickCategoriesProvider.notifier);
  if (category.id != null) {
    repository.updateCategory(category);
  } else {
    repository.createCategory(category);
  }
}
