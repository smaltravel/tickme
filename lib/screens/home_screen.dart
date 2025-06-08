import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/models/category.dart';
import 'package:tickme/providers/active_timer_provider.dart';
import 'package:tickme/providers/tick_category_provider.dart';

final _tickCard = Provider<Category>((ref) => throw UnimplementedError());

class TickTileHook extends HookConsumerWidget {
  const TickTileHook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(_tickCard);
    final activeTimer = ref.watch(activeTickProvider);

    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.blueAccent,
      child: Center(
        child: InkWell(
          onTap: () => _startStopTimer(ref, card, activeTimer),
          onLongPress: () => _showEditCategoryDialog(context, ref, card),
          child: Text(
            card.name,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void _startStopTimer(
      WidgetRef ref, Category timerCategory, ActiveTimer? timer) {
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
      BuildContext context, WidgetRef ref, Category old) {
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
                  .read(tickCategoryProvider.notifier)
                  .rename(id: old.id, name: nameController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Rename'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(tickCategoryProvider.notifier).remove(old.id);
              Navigator.of(context).pop();
            },
            child: const Text('Remove'),
          )
        ],
      ),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticks = ref.watch(tickCategoryProvider);

    return GridView.builder(
      itemCount: ticks.length + 1,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) => index < ticks.length
          ? ProviderScope(
              overrides: [_tickCard.overrideWithValue(ticks[index])],
              child: const GridTile(child: TickTileHook()),
            )
          : GridTile(
              child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showNewCategoryDialog(context, ref),
            )),
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
              ref.read(tickCategoryProvider.notifier).add(nameController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
