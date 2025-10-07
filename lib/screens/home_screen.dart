import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moon_design/moon_design.dart';
import 'package:tickme/common/icon_pack.dart';
import 'package:tickme/common/tickme_light_theme.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/models/active_timer.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/active_timer_provider.dart';
import 'package:tickme/providers/tick_categories_provider.dart';

final _tickCard = Provider<TickCategoryModel>((ref) => throw UnimplementedError());

Future<void> _showNewUpdateTickCategoryDialog(
    BuildContext context, WidgetRef ref, TickCategoryModel? current) {
  final nameController = TextEditingController(text: current?.name ?? '');
  IconPickerIcon currentIcon = current?.icon ?? unknownTickIcon;
  final moonSizes = context.moonTheme!.tokens.sizes;

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(moonSizes.md)),
        child: Padding(
          padding: EdgeInsets.all(moonSizes.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                current == null ? context.loc.home_new_category : context.loc.home_edit_category,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: moonSizes.lg),
              Icon(currentIcon.data, size: moonSizes.x2l),
              SizedBox(height: moonSizes.md),
              MoonTextInput(
                controller: nameController,
                hintText: context.loc.home_edit_category_name,
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
              ),
              SizedBox(height: moonSizes.md),
              MoonButton(
                onTap: () async {
                  IconPickerIcon? icon = await showIconPicker(
                    context,
                    configuration: SinglePickerConfiguration(
                      showTooltips: false,
                      showSearchBar: false,
                      iconPackModes: [IconPack.custom],
                      customIconPack: categoriesIconPack,
                    ),
                  );
                  if (icon != null) {
                    setState(() {
                      currentIcon = icon;
                    });
                  }
                },
                label: Text(context.loc.home_choose_icon),
              ),
              SizedBox(height: moonSizes.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MoonButton(
                    buttonSize: MoonButtonSize.sm,
                    backgroundColor: Colors.transparent,
                    onTap: () => Navigator.of(context).pop(),
                    label: Text(context.loc.cancel),
                  ),
                  SizedBox(width: moonSizes.xs),
                  MoonButton(
                    buttonSize: MoonButtonSize.sm,
                    onTap: () {
                      if (current == null) {
                        ref.read(tickCategoriesProvider.notifier).add(nameController.text, currentIcon);
                      } else {
                        ref.read(tickCategoriesProvider.notifier).update(
                              id: current.id,
                              name: nameController.text,
                              icon: currentIcon,
                            );
                      }
                      Navigator.of(context).pop();
                    },
                    label: Text(current == null ? context.loc.add : context.loc.home_edit_category_update),
                  ),
                ],
              ),
            ],
          ),
        ),
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
    final moonSizes = context.moonTheme!.tokens.sizes;

    final isActive = activeTimer != null && activeTimer.categoryId == card.id;

    return GestureDetector(
      onTap: () => _startStopTimer(ref, card, activeTimer),
      onLongPress: () => _showNewUpdateTickCategoryDialog(context, ref, card),
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Colors.lightBlueAccent.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(moonSizes.md),
          border: Border.all(
            color: isActive ? const Color(0xFF0091EA) : const Color(0xFFE2E8F0),
            width: 1.0,
          ),
        ),
        padding: EdgeInsets.all(moonSizes.x2s),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(card.icon.data, size: moonSizes.x2l),
            Text(
              card.name,
              style: TextTheme.of(context).titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _startStopTimer(WidgetRef ref, TickCategoryModel timerCategory, ActiveTimerModel? timer) {
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
    final category = ref.watch(tickCategoriesProvider).firstWhere((e) => e.id == activeTimer.categoryId);
    final moonSizes = context.moonTheme!.tokens.sizes;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: moonSizes.xs),
      padding: EdgeInsets.all(moonSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(moonSizes.md),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.home_active_timer,
                style: TextTheme.of(context).titleMedium,
              ),
              SizedBox(height: moonSizes.x2s),
              Text(
                category.name,
                style: TextTheme.of(context).bodyMedium,
              ),
            ],
          ),
          SizedBox(height: moonSizes.md),
          Center(
            child: StreamBuilder<DateTime>(
              initialData: DateTime.now(),
              stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
              builder: (context, snapshot) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _formatDuration(snapshot.data!.difference(activeTimer.start))
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
          SizedBox(height: moonSizes.md),
          MoonButton(
            onTap: () => ref.read(activeTickProvider.notifier).stop(),
            backgroundColor: Colors.red,
            label: Text(
              context.loc.home_stop,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
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
    final moonSizes = context.moonTheme!.tokens.sizes;

    return GestureDetector(
      onTap: () => _showNewUpdateTickCategoryDialog(context, ref, null),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(moonSizes.md),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.0,
          ),
        ),
        padding: EdgeInsets.all(moonSizes.x2s),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: moonSizes.x2l),
            Text(
              context.loc.add,
              style: TextTheme.of(context).titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  List<TickCategoryModel> _filterCategories(List<TickCategoryModel> categories) {
    if (_searchQuery.isEmpty) {
      return categories;
    }
    return categories.where((category) {
      return category.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final ticks = ref.watch(tickCategoriesProvider);
    final activeTimer = ref.watch(activeTickProvider);
    final moonSizes = context.moonTheme!.tokens.sizes;

    // Filter categories based on search query
    final filteredTicks = _filterCategories(ticks);

    // Create a list including filtered ticks + add button
    final allItems = [...filteredTicks, null]; // null represents the add button

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: moonSizes.x2s),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (activeTimer != null)
              ElapsedTimeWidget(
                activeTimer: activeTimer,
              ),
            Expanded(
              child: ListView.builder(
                itemCount: allItems.length,
                itemBuilder: (context, index) {
                  final item = allItems[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: moonSizes.xs),
                    child: item != null
                        ? ProviderScope(
                            overrides: [_tickCard.overrideWithValue(item)],
                            child: const TickTileHook(),
                          )
                        : const AddTickCategoryButton(),
                  );
                },
              ),
            ),
            // Search bar at bottom
            Padding(
              padding: EdgeInsets.symmetric(vertical: moonSizes.x4s),
              child: MoonTextInput(
                controller: _searchController,
                hintText: 'Search categories...',
                leading: const Icon(Icons.search),
                trailing: _searchQuery.isNotEmpty
                    ? MoonButton.icon(
                        buttonSize: MoonButtonSize.xs,
                        icon: const Icon(Icons.clear, size: 16),
                        onTap: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
