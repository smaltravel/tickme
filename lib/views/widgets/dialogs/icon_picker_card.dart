import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:tickme/common/constants/app.dart';
import 'package:tickme/common/icon_pack.dart';

class IconPickerCard extends StatelessWidget {
  final IconPickerIcon icon;
  final Color color;
  final void Function(IconPickerIcon) onIconSelected;

  const IconPickerCard({
    super.key,
    required this.icon,
    required this.color,
    required this.onIconSelected,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _onChangeIcon(context),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: color.withValues(alpha: AppConstants.defaultColorAlpha),
            borderRadius:
                BorderRadius.circular(AppConstants.defaultBorderRadius),
          ),
          child:
              Icon(icon.data, size: AppConstants.defaultIconSize, color: color),
        ),
      );

  void _onChangeIcon(BuildContext context) async {
    final icon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        showTooltips: false,
        showSearchBar: false,
        iconPackModes: [IconPack.custom],
        customIconPack: categoriesIconPack,
      ),
    );

    if (icon != null) {
      onIconSelected(icon);
    }
  }
}
