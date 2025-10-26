import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/views/widgets/common/tick_avatar.dart';
import 'package:tickme/views/widgets/home/timer_display.dart';

class TickAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<TickCategoryModel> categories;
  final ActiveTimerModel? activeTimer;
  final VoidCallback onStopTimer;

  const TickAppBar({
    super.key,
    required this.categories,
    this.activeTimer,
    required this.onStopTimer,
  });

  @override
  Widget build(BuildContext context) {
    final activeCategory =
        activeTimer != null ? categories.firstWhere((e) => e.id == activeTimer!.categoryId) : null;

    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: activeCategory != null
          ? Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: activeCategory.color.withValues(alpha: 0.3),
                    blurRadius: 8.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TickAvatar(category: activeCategory),
            )
          : null,
      title: activeTimer != null && activeCategory != null
          ? TimerDisplay(
              startTime: activeTimer!.start,
              categoryName: activeCategory.name,
            )
          : Text(
              'TickMe',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
      actions: [
        if (activeTimer != null)
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: MoonFilledButton(
              onTap: onStopTimer,
              backgroundColor: Colors.red.shade50,
              leading: Icon(Icons.stop, color: Colors.red.shade700, size: 20),
              buttonSize: MoonButtonSize.sm,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
