import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/constants/app_constants.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/active_timer_provider.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/utils/date_utils.dart';

class ElapsedTimeWidget extends ConsumerWidget {
  final ActiveTimerModel activeTimer;

  const ElapsedTimeWidget({
    required this.activeTimer,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(tickCategoriesProvider);
    final category = categories.firstWhere(
      (c) => c.id == activeTimer.categoryId,
      orElse: () => unknownTickCategory,
    );

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              context.loc.home_active_timer,
              style: TextTheme.of(context).titleMedium,
            ),
            subtitle: Text(category.name),
          ),
          Center(
            child: StreamBuilder<DateTime>(
              initialData: DateTime.now(),
              stream: Stream.periodic(
                  AppConstants.timerUpdateInterval, (_) => DateTime.now()),
              builder: (context, snapshot) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: AppDateUtils.formatDurationAsList(
                        snapshot.data!.difference(activeTimer.start))
                    .asMap()
                    .entries
                    .map((e) => TimeBlockAtom(
                          val: e.value,
                          width: e.key % 2 == 0 ? 50.0 : 5,
                        ))
                    .toList(),
              ),
            ),
          ),
          TextButton(
            onPressed: () => ref.read(activeTickProvider.notifier).stop(),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              context.loc.home_stop,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeBlockAtom extends StatelessWidget {
  final String val;
  final double width;

  const TimeBlockAtom({
    required this.val,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      child: Center(
        child: Text(
          val,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
