import 'package:flutter/material.dart';
import 'package:tickme/common/constants/app.dart';
import 'package:tickme/l10n/app_localizations_context.dart';

class NoCategoriesCard extends StatelessWidget {
  const NoCategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.category_outlined,
              size: AppConstants.defaultIconSize * 1.5, color: Colors.grey),
          const SizedBox(height: AppConstants.defaultSizedBox * 2),
          Text(
            context.loc.home_no_categories,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: AppConstants.defaultSizedBox),
          Text(
            context.loc.home_tap_to_add_category,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
