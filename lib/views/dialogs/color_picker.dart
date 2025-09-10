import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tickme/l10n/app_localizations_context.dart';

Future<void> showPickColorDialog(
    BuildContext context, Color color, void Function(Color) onColorSelected) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(context.loc.home_color_picker_title),
      content: SingleChildScrollView(
        child: MaterialPicker(
          pickerColor: color,
          onColorChanged: onColorSelected,
          portraitOnly: true,
        ),
      ),
    ),
  );
}
