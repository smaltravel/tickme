import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/widgets/home/category_dialog.dart';

class AddCategoryButton extends ConsumerWidget {
  const AddCategoryButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () =>
          CategoryDialog.show(context: context, ref: ref, category: null),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, size: 40.0),
              Text(
                context.loc.add,
                style: TextTheme.of(context).titleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
