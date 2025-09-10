import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/active_timer_provider.dart';
import 'package:tickme/views/dialogs/tick_category.dart';
import 'package:tickme/views/widgets/home/timer_display.dart';

class TickAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final List<TickCategoryModel> categories;

  const TickAppBar({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTimer = ref.watch(activeTickProvider);
    final activeCategory = activeTimer != null
        ? categories.firstWhere((e) => e.id == activeTimer.categoryId)
        : null;

    return AppBar(
      leading: activeCategory != null
          ? CircleAvatar(
              backgroundColor: activeCategory.color,
              child: Icon(activeCategory.icon.data),
            )
          : null,
      title: activeTimer != null && activeCategory != null
          ? TimerDisplay(
              startTime: activeTimer.start,
              categoryName: activeCategory.name,
            )
          : null,
      actions: [
        if (activeTimer != null)
          IconButton(
            onPressed: () => ref
                .read(activeTickProvider.notifier)
                .update(activeTimer.categoryId),
            icon: const Icon(Icons.stop),
          ),
        IconButton(
            onPressed: () => showTickCategoryDialog(context, ref, null),
            icon: const Icon(Icons.add))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
