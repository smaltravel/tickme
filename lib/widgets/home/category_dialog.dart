import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/common/icon_pack.dart';
import 'package:tickme/constants/app_constants.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/utils/error_handler.dart';
import 'package:tickme/utils/validation_utils.dart';

class CategoryDialog {
  static Future<void> show({
    required BuildContext context,
    required WidgetRef ref,
    TickCategoryModel? category,
  }) {
    final nameController = TextEditingController(text: category?.name ?? '');
    IconPickerIcon currentIcon = category?.icon ?? unknownTickIcon;

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(category == null
              ? context.loc.home_new_category
              : context.loc.home_edit_category),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(currentIcon.data, size: AppConstants.defaultIconSize),
              const SizedBox(height: AppConstants.cardSpacing),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: context.loc.home_edit_category_name),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                      AppConstants.maxCategoryNameLength)
                ],
              ),
              const SizedBox(height: AppConstants.cardSpacing),
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
                final categoryName = nameController.text.trim();

                if (!ValidationUtils.isValidCategoryName(categoryName)) {
                  AppErrorHandler.handleValidationError(context,
                      'Please enter a valid category name (1-20 characters)');
                  return;
                }

                try {
                  if (category == null) {
                    ref
                        .read(tickCategoriesProvider.notifier)
                        .add(categoryName, currentIcon);
                    AppErrorHandler.showSuccessMessage(
                        context, 'Category added successfully');
                  } else {
                    ref.read(tickCategoriesProvider.notifier).update(
                          id: category.id,
                          name: categoryName,
                          icon: currentIcon,
                        );
                    AppErrorHandler.showSuccessMessage(
                        context, 'Category updated successfully');
                  }
                  Navigator.of(context).pop();
                } catch (e) {
                  AppErrorHandler.handleError(context, e, null);
                }
              },
              child: Text(category == null
                  ? context.loc.add
                  : context.loc.home_edit_category_update),
            ),
          ],
        ),
      ),
    );
  }
}
