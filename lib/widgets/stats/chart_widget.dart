import 'package:duration/duration.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickme/constants/app_constants.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/providers/tick_categories_provider.dart';

@immutable
class ChartData {
  final PieChartSectionData section;
  final TickCategoryModel category;

  const ChartData({
    required this.section,
    required this.category,
  });
}

class ChartWithLegendWidget extends ConsumerWidget {
  final Map<String, double> dataMap;

  const ChartWithLegendWidget({super.key, required this.dataMap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(tickCategoriesProvider);
    final wholeTime =
        dataMap.values.reduce((value, element) => value + element);

    return SingleChildScrollView(
      child: Container(
        margin:
            const EdgeInsets.symmetric(horizontal: AppConstants.chartMargin),
        child: Column(
          spacing: AppConstants.cardSpacing,
          children: [
            Card(
              color: Colors.white,
              child: Container(
                margin: const EdgeInsets.all(AppConstants.chartMargin),
                child: AspectRatio(
                  aspectRatio: AppConstants.chartAspectRatio,
                  child: PieChart(
                    PieChartData(
                      sections: _buildSections(categories, wholeTime),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: <Widget>[..._buildLegend(categories)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ListTile> _buildLegend(TickCategoriesStorage categories) =>
      dataMap.entries.map(
        (e) {
          final category = categories.firstWhere(
            (c) => c.id == e.key,
            orElse: () => unknownTickCategory,
          );
          return ListTile(
            leading: CircleAvatar(
              radius: AppConstants.legendAvatarRadius,
              backgroundColor: category.color,
            ),
            title: Text(category.name),
            subtitle: Text(Duration(seconds: e.value.toInt())
                .pretty(abbreviated: true, delimiter: ' ', spacer: '')),
            trailing: Icon(category.icon.data),
          );
        },
      ).toList();

  List<PieChartSectionData> _buildSections(
          TickCategoriesStorage categories, double wholeTime) =>
      dataMap.entries.map((e) {
        final category = categories.firstWhere(
          (c) => c.id == e.key,
          orElse: () => unknownTickCategory,
        );

        return PieChartSectionData(
          value: e.value,
          color: category.color,
          badgeWidget: e.value / wholeTime > AppConstants.chartThreshold
              ? Icon(category.icon.data)
              : null,
          showTitle: false,
        );
      }).toList();
}
