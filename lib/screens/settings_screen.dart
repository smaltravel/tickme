import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/providers/time_entries_provider.dart';

class SettingsScreen extends ConsumerWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Reset Data'),
          trailing: const Icon(Icons.delete_forever),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Confirm Reset'),
                content:
                    const Text('Are you sure you want to reset all records?'),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    child: const Text('Reset'),
                    onPressed: () {
                      ref.read(timeEntriesProvider.notifier).erase();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Delete Categories'),
          trailing: const Icon(Icons.delete_forever),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Confirm Deleting'),
                content: const Text(
                    'Are you sure you want to delete all categories?'),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    child: const Text('Delete'),
                    onPressed: () {
                      ref.read(tickCategoriesProvider.notifier).erase();
                      ref.read(timeEntriesProvider.notifier).erase();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
