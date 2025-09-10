import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:tickme/common/constants/app.dart';
import 'package:tickme/common/icon_pack.dart';
import 'package:tickme/l10n/app_localizations_context.dart';
import 'package:tickme/views/dialogs/color_picker.dart';

class TickCategoryEdit extends StatelessWidget {
  const TickCategoryEdit(
      {super.key,
      required this.icon,
      required this.color,
      required this.nameController,
      required this.onIconSelected,
      required this.onColorSelected});

  final IconPickerIcon icon;
  final Color color;
  final TextEditingController nameController;
  final void Function(IconPickerIcon?) onIconSelected;
  final void Function(Color) onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: AppConstants.defaultSizedBox),
        GestureDetector(
          onTap: () async => onIconSelected(await showIconPicker(
            context,
            configuration: SinglePickerConfiguration(
              showTooltips: false,
              showSearchBar: false,
              iconPackModes: [IconPack.custom],
              customIconPack: categoriesIconPack,
            ),
          )),
          child: Container(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            decoration: BoxDecoration(
              color: color.withValues(alpha: AppConstants.defaultColorAlpha),
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultBorderRadius),
            ),
            child: Icon(icon.data,
                size: AppConstants.defaultIconSize, color: color),
          ),
        ),
        const SizedBox(height: AppConstants.defaultSizedBox),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: context.loc.home_edit_category_name,
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        ElevatedButton(
          onPressed: () => showPickColorDialog(context, color, onColorSelected),
          child: Text(context.loc.home_select_color),
        ),
      ],
    );
  }
}
