import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:tickme/l10n/app_localizations_context.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final Color? confirmColor;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    this.confirmColor,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        MoonTextButton(
          onTap: () => Navigator.of(context).pop(),
          label: Text(context.loc.cancel),
        ),
        confirmColor != null
            ? MoonFilledButton(
                onTap: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
                backgroundColor: confirmColor,
                label: Text(confirmText),
              )
            : MoonTextButton(
                onTap: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
                label: Text(confirmText),
              ),
      ],
    );
  }
}
