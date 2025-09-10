import 'package:flutter/material.dart';
import 'package:tickme/models/tick_category.dart';
import 'package:tickme/common/constants/app.dart';

class TickCategoryCard extends StatelessWidget {
  final TickCategoryModel category;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;

  const TickCategoryCard({
    super.key,
    required this.category,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.defaultIconSize * 2,
      height: AppConstants.defaultIconSize * 2,
      child: Material(
        color: isSelected
            ? category.color.withValues(alpha: AppConstants.defaultColorAlpha)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          child: Container(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultBorderRadius),
              border: isSelected
                  ? Border.all(color: category.color, width: 2.0)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with background circle
                Container(
                  width: AppConstants.defaultIconSize,
                  height: AppConstants.defaultIconSize,
                  decoration: BoxDecoration(
                    color: category.color
                        .withValues(alpha: AppConstants.defaultColorAlpha),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    category.icon.data,
                    size: AppConstants.defaultIconSize * 0.6,
                    color: category.color,
                  ),
                ),
                const SizedBox(height: AppConstants.defaultSizedBox),
                // Category name
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isSelected ? category.color : null,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
