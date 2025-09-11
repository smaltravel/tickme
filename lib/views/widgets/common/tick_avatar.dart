import 'package:flutter/material.dart';
import 'package:tickme/models/tick_category.dart';

// Icon with background circle
class TickAvatar extends StatelessWidget {
  final TickCategoryModel category;

  const TickAvatar({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: category.color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: category.color.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Icon(
        category.icon.data,
        size: 20.0,
        color: category.color,
      ),
    );
  }
}
