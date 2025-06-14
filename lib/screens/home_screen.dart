import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/active_timer_provider.dart';
import 'package:tickme/providers/tick_categories_provider.dart';

final _tickCard =
    Provider<TickCategoryModel>((ref) => throw UnimplementedError());

Future<void> _showNewUpdateTickCategoryDialog(
    BuildContext context, WidgetRef ref, TickCategoryModel? current) {
  final nameController = TextEditingController(text: current?.name ?? '');
  IconData currentIcon = current?.icon ?? Icons.question_mark;

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(current == null
            ? context.loc.home_new_category
            : context.loc.home_edit_category),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(currentIcon, size: 40.0),
            const SizedBox(height: 8.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: context.loc.home_edit_category_name),
              inputFormatters: [LengthLimitingTextInputFormatter(20)],
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () async {
                IconData? icon = await showIconPicker(context);
                if (icon != null) {
                  setState(() {
                    currentIcon = icon;
                  });
                }
              },
              child: Text(context.loc.home_choose_icon),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.loc.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (current == null) {
                ref
                    .read(tickCategoriesProvider.notifier)
                    .add(nameController.text, currentIcon);
              } else {
                ref.read(tickCategoriesProvider.notifier).update(
                      id: current.id,
                      name: nameController.text,
                      icon: currentIcon,
                    );
              }
              Navigator.of(context).pop();
            },
            child: Text(current == null
                ? context.loc.add
                : context.loc.home_edit_category_update),
          ),
        ],
      ),
    ),
  );
}

class TickTileHook extends HookConsumerWidget {
  const TickTileHook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(_tickCard);
    final activeTimer = ref.watch(activeTickProvider);

    final isActive = activeTimer != null && activeTimer.categoryId == card.id;

    return InkWell(
      onTap: () => _startStopTimer(ref, card, activeTimer),
      onLongPress: () => _showNewUpdateTickCategoryDialog(context, ref, card),
      child: Card(
        color: isActive ? Colors.lightBlueAccent.shade100 : null,
        shape: isActive
            ? RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.lightBlueAccent.shade700, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              )
            : null,
        child: Container(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(card.icon, size: 40.0),
              Text(
                card.name,
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
                context.loc.home_active_timer,
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
              child: Text(
                context.loc.home_stop,
                style: const TextStyle(color: Colors.white),
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
      onTap: () => _showNewUpdateTickCategoryDialog(context, ref, null),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, size: 40.0),
              Text(
                context.loc.add,
                style: TextTheme.of(context).titleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
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
                    height: width * 1.5,
                    child: ProviderScope(
                      overrides: [_tickCard.overrideWithValue(t)],
                      child: const TickTileHook(),
                    ),
                  )),
              SizedBox(
                width: width,
                height: width * 1.5,
                child: const AddTickCategoryButton(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
