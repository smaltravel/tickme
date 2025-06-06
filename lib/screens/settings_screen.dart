import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/providers/tick_category_provider.dart';
import 'package:tickme/providers/time_entry_provider.dart';

class SettingsScreen extends ConsumerWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Reset Data'),
          trailing: Icon(Icons.delete_forever),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Confirm Reset'),
                content: Text('Are you sure you want to reset all records?'),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    child: Text('Reset'),
                    onPressed: () {
                      ref.read(timerProvider.notifier).erase();
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
          trailing: Icon(Icons.delete_forever),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Confirm Deleting'),
                content:
                    Text('Are you sure you want to delete all categories?'),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    child: Text('Reset'),
                    onPressed: () {
                      ref.read(tickCategoryProvider.notifier).erase();
                      ref.read(timerProvider.notifier).erase();
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
