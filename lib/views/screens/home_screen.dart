import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/common/icon_pack.dart';
import 'package:tickme/common/tickme_light_theme.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
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

    final isActive = activeTimer != null && activeTimer.categoryId == card.id;

    return InkWell(
      onTap: () => _startStopTimer(ref, card, activeTimer),
      onLongPress: () => _showNewUpdateTickCategoryDialog(context, ref, card),
      child: Card(
        color: isActive ? TickmeCardThemeData.selected.surfaceTintColor : null,
        shape: isActive ? TickmeCardThemeData.selected.shape : null,
        child: Container(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(card.icon.data, size: 40.0),
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

class TimeBlockAtom extends StatelessWidget {
  final String val;
  final double width;

  const TimeBlockAtom({super.key, required this.val, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(
          val,
          style: EstimatedTimerTextTheme.style,
        ),
      ),
    );
  }
}

class ElapsedTimeWidget extends ConsumerWidget {
  final ActiveTimerModel activeTimer;

  const ElapsedTimeWidget({super.key, required this.activeTimer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref
        .watch(tickCategoriesProvider)
        .firstWhere((e) => e.id == activeTimer.categoryId);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                context.loc.home_active_timer,
                style: TextTheme.of(context).titleMedium,
              ),
              subtitle: Text(category.name),
            ),
            Center(
              child: StreamBuilder<DateTime>(
                initialData: DateTime.now(),
                stream: Stream.periodic(
                    const Duration(seconds: 1), (_) => DateTime.now()),
                builder: (context, snapshot) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _formatDuration(
                          snapshot.data!.difference(activeTimer.start))
                      .asMap()
                      .entries
                      .map((e) => TimeBlockAtom(
                            val: e.value,
                            width: e.key % 2 == 0 ? 50.0 : 5,
                          ))
                      .toList(),
                ),
              ),
            ),
            TextButton(
              onPressed: () => ref.read(activeTickProvider.notifier).stop(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                context.loc.home_stop,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return [hours, ':', minutes, ':', seconds];
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
            activeTimer: activeTimer,
          ),
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
