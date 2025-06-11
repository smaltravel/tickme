import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/active_timer_provider.dart';
import 'package:tickme/providers/tick_categories_provider.dart';

final _tickCard =
    Provider<TickCategoryModel>((ref) => throw UnimplementedError());

class TickTileHook extends HookConsumerWidget {
  const TickTileHook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(_tickCard);
    final activeTimer = ref.watch(activeTickProvider);

    return InkWell(
      onTap: () => _startStopTimer(ref, card, activeTimer),
      onLongPress: () => _showEditCategoryDialog(context, ref, card),
      child: Card(
        child: Center(
          child: Text(
            card.name,
            style: TextTheme.of(context).titleMedium,
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

  Future<void> _showEditCategoryDialog(
      BuildContext context, WidgetRef ref, TickCategoryModel old) {
    final nameController = TextEditingController(text: old.name);

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Edit Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'name'),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(tickCategoriesProvider.notifier)
                  .rename(id: old.id, name: nameController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Rename'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(tickCategoriesProvider.notifier).remove(old.id);
              Navigator.of(context).pop();
            },
            child: const Text('Remove'),
          )
        ],
      ),
    );
  }
}

class ElapsedTimeWidget extends ConsumerWidget {
  final String categoryName;

  const ElapsedTimeWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elapsedTime = ref.watch(elapsedTimeNotifierProvider);

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                'Active Timer',
                style: TextTheme.of(context).headlineMedium,
              ),
              subtitle: Text(categoryName),
            ),
            Center(
              child: Text(
                _formatDuration(elapsedTime),
                style: TextTheme.of(context).headlineMedium,
              ),
            ),
            TextButton(
              onPressed: () => ref.read(activeTickProvider.notifier).stop(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Stop',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}

class AddTickCategoryButton extends ConsumerWidget {
  const AddTickCategoryButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => _showNewCategoryDialog(context, ref),
      child: const Card(
        child: Center(
          child: Icon(Icons.add, size: 40.0),
        ),
      ),
    );
  }

  Future<void> _showNewCategoryDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('New Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'name'),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(tickCategoriesProvider.notifier)
                  .add(nameController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  static const routeName = '/home';
  static const double _runSpacing = 8.0;
  static const double _spacing = 4.0;
  static const int _columns = 5;

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticks = ref.watch(tickCategoriesProvider);
    final activeTimer = ref.watch(activeTickProvider);
    final width =
        (MediaQuery.of(context).size.width - _runSpacing * (_columns - 1)) /
            _columns;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 8.0,
      children: [
        if (activeTimer != null)
          ElapsedTimeWidget(
              categoryName: ticks
                  .singleWhere((t) => t.id == activeTimer.categoryId)
                  .name),
        SingleChildScrollView(
          child: Wrap(
            runSpacing: _runSpacing,
            spacing: _spacing,
            alignment: WrapAlignment.center,
            children: [
              ...ticks.map((t) => SizedBox(
                    width: width,
                    height: width,
                    child: ProviderScope(
                      overrides: [_tickCard.overrideWithValue(t)],
                      child: const TickTileHook(),
                    ),
                  )),
              SizedBox(
                width: width,
                height: width,
                child: const AddTickCategoryButton(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
