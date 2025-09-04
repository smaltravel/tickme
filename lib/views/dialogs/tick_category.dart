import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconpicker/Models/icon_picker_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/tick_category.dart';

Future<void> showTickCategoryDialog(
    BuildContext context, WidgetRef ref, TickCategoryModel? current) {
  final nameController = TextEditingController(text: current?.name ?? '');
  IconPickerIcon currentIcon = current?.icon ?? unknownTickIcon;

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(current == null
            ? context.loc.home_new_category
            : context.loc.home_edit_category),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(currentIcon.data, size: 40.0),
            const SizedBox(height: 8.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: context.loc.home_edit_category_name),
              inputFormatters: [LengthLimitingTextInputFormatter(20)],
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () async {
                IconPickerIcon? icon = await showIconPicker(
                  context,
                  configuration: SinglePickerConfiguration(
                    showTooltips: false,
                    showSearchBar: false,
                    iconPackModes: [IconPack.custom],
                    customIconPack: categoriesIconPack,
                  ),
                );
                if (icon != null) {
                  setState(() {
                    currentIcon = icon;
                  });
                }
              },
              child: Text(context.loc.home_choose_icon),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.loc.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (current == null) {
                ref
                    .read(tickCategoriesProvider.notifier)
                    .add(nameController.text, currentIcon);
              } else {
                ref.read(tickCategoriesProvider.notifier).update(
                      id: current.id,
                      name: nameController.text,
                      icon: currentIcon,
                    );
              }
              Navigator.of(context).pop();
            },
            child: Text(current == null
                ? context.loc.add
                : context.loc.home_edit_category_update),
          ),
        ],
      ),
    ),
  );
}
