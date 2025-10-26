import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:moon_design/moon_design.dart';
import 'package:tickme/l10n/app_localizations_context.dart';

Widget buildColorPickerDialog(BuildContext context, Color color, void Function(Color) onColorSelected) {
  var currentColor = color.withValues();

  return StatefulBuilder(
    builder: (context, setState) => AlertDialog(
      title: Text(context.loc.home_color_picker_title),
      content: SingleChildScrollView(
        child: BlockPicker(
            pickerColor: currentColor, onColorChanged: (color) => setState(() => currentColor = color)),
      ),
      actions: [
        MoonTextButton(
          onTap: () => Navigator.of(context).pop(),
          label: Text(context.loc.cancel),
        ),
        MoonFilledButton(
          onTap: () {
            Navigator.of(context).pop();
            onColorSelected(currentColor);
          },
          label: Text(context.loc.apply),
        ),
      ],
    ),
  );
}
