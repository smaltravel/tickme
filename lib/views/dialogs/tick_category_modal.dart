import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/common/constants/app.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/views/dialogs/tick_category.dart';

Future<void> showTickCategoryModal(
    BuildContext context, WidgetRef ref, TickCategoryModel category) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(context.loc.category_modal_edit),
            onTap: () {
              Navigator.pop(context);
              showTickCategoryDialog(context, ref, category);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: Text(context.loc.category_modal_delete),
            onTap: () {
              Navigator.pop(context);
              ref
                  .read(tickCategoriesProvider.notifier)
                  .removeCategory(category.id!);
            },
          ),
        ],
      ),
    ),
  );
}
