import 'package:flutter/material.dart';
import 'package:tickme/common/constants/app.dart';
import 'package:tickme/views/dialogs/color_picker_builder.dart';

class ColorPickerCard extends StatelessWidget {
  final Color color;
  final void Function(Color) onColorSelected;

  const ColorPickerCard({
    super.key,
    required this.color,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => showDialog(
            context: context,
            builder: (context) =>
                buildColorPickerDialog(context, color, onColorSelected)),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: color.withValues(alpha: AppConstants.defaultColorAlpha),
            borderRadius:
                BorderRadius.circular(AppConstants.defaultBorderRadius),
          ),
        ),
      );
}
