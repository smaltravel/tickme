import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/constants/app_constants.dart';
import 'package:tickme/providers/active_timer_provider.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticks = ref.watch(tickCategoriesProvider);
    final activeTimer = ref.watch(activeTickProvider);
    final width = (MediaQuery.of(context).size.width -
            AppConstants.homeRunSpacing * (AppConstants.homeColumns - 1)) /
        AppConstants.homeColumns;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: AppConstants.cardSpacing,
      children: [
        if (activeTimer != null)
          ElapsedTimeWidget(
            activeTimer: activeTimer,
          ),
        SingleChildScrollView(
          child: Wrap(
            runSpacing: AppConstants.homeRunSpacing,
            spacing: AppConstants.homeSpacing,
            alignment: WrapAlignment.center,
            children: [
              ...ticks.map((t) => SizedBox(
                    width: width,
                    height: width * AppConstants.tickTileAspectRatio,
                    child: TickTileWidget(category: t),
                  )),
              SizedBox(
                width: width,
                height: width * AppConstants.tickTileAspectRatio,
                child: const AddCategoryButton(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
