import 'package:flutter/material.dart';
import 'package:tickme/constants/app_constants.dart';
import 'package:tickme/l10n/app_localizations_context.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Color(AppConstants.noDataBackgroundColor),
            radius: 50,
            child: Icon(
              Icons.timer_off_outlined,
              color: Color(AppConstants.noDataIconColor),
              size: AppConstants.largeIconSize,
            ),
          ),
          Text(
            context.loc.stats_no_data,
            style: TextTheme.of(context).headlineSmall,
          ),
        ],
      ),
    );
  }
}
