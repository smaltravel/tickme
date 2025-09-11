import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/common/constants/app.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/providers/active_timer_provider.dart';
import 'package:tickme/views/dialogs/tick_category_modal.dart';
import 'package:tickme/views/widgets/home/no_categories.dart';
import 'package:tickme/views/widgets/home/tick_app_bar.dart';
import 'package:tickme/views/widgets/home/tick_category.dart';
import 'package:tickme/views/dialogs/tick_category_builder.dart';

@RoutePage(name: 'CategoriesTab')
class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(tickCategoriesProvider);
    final activeTimer = ref.watch(activeTickProvider);

    return repository.when(
      data: (categories) => Scaffold(
        appBar: TickAppBar(categories: categories),
        body: _buildBody(context, ref, categories, activeTimer),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) =>
                  buildTickCategoryDialog(context, ref, null)),
          child: const Icon(Icons.add),
        ),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Error: $error')),
      ),
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Loading')),
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    TickCategoriesState categories,
    ActiveTimerModel? activeTimer,
  ) {
    if (categories.isEmpty) return const NoCategoriesCard();

    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isActive =
              activeTimer != null && activeTimer.categoryId == category.id;

          return TickCategoryCard(
            category: category,
            isSelected: isActive,
            onTap: () =>
                ref.read(activeTickProvider.notifier).update(category.id!),
            onLongPress: () => showTickCategoryModal(context, ref, category),
          );
        },
      ),
    );
  }
}
