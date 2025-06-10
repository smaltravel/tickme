import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/providers/csv_export_service_provider.dart';
import 'package:tickme/providers/tick_categories_provider.dart';

class SettingsScreen extends ConsumerWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Erase all data'),
          trailing: const Icon(Icons.delete_forever),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Confirm Erasing'),
                content: const Text('Are you sure you want to erase all data?'),
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
                    child: const Text('Erase'),
                    onPressed: () {
                      ref.read(tickCategoriesProvider.notifier).erase();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Export to CSV'),
          trailing: const Icon(Icons.file_download_outlined),
          onTap: () async {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Exporting data...')),
            );

            final csvExportService = ref.watch(csvExportServiceProvider);
            final filePath = await csvExportService.exportToCsv();

            if (filePath != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Data exported to $filePath')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to export data')),
              );
            }
          },
        ),
      ],
    );
  }
}
