import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/common/tickme_light_theme.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/active_timer_provider.dart';
import 'package:tickme/widgets/home/category_dialog.dart';

class TickTileWidget extends HookConsumerWidget {
  final TickCategoryModel category;

  const TickTileWidget({
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTimer = ref.watch(activeTickProvider);
    final isActive =
        activeTimer != null && activeTimer.categoryId == category.id;

    return InkWell(
      onTap: () => _startStopTimer(ref, category, activeTimer),
      onLongPress: () => CategoryDialog.show(
        context: context,
        ref: ref,
        category: category,
      ),
      child: Card(
        color: isActive ? TickmeCardThemeData.selected.surfaceTintColor : null,
        shape: isActive ? TickmeCardThemeData.selected.shape : null,
        child: Container(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category.icon.data, size: 40.0),
              Text(
                category.name,
                style: TextTheme.of(context).titleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startStopTimer(
      WidgetRef ref, TickCategoryModel timerCategory, ActiveTimerModel? timer) {
    if (timer != null) {
      // Stop current activity
      ref.read(activeTickProvider.notifier).stop();

      // If user tapped on another activity start it immediately
      if (timer.categoryId != timerCategory.id) {
        ref.read(activeTickProvider.notifier).run(timerCategory.id);
      }
    } else {
      ref.read(activeTickProvider.notifier).run(timerCategory.id);
    }
  }
}
