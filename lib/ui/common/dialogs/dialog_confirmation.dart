import 'package:flutter/material.dart';

class MaterialConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String confirmButtonText;
  final String cancelButtonText;
  final Color confirmButtonColor;
  final Color confirmTextColor;
  final IconData? icon;
  final Color? iconColor;
  const MaterialConfirmationDialog({
    Key? key,
    required this.title,
    required this.message,
    this.onConfirm,
    this.onCancel,
    this.confirmButtonText = 'Confirmar',
    this.cancelButtonText = 'Cancelar',
    this.confirmButtonColor = Colors.blue,
    this.confirmTextColor = Colors.white,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: iconColor,
              size: 35,
            ),
            const SizedBox(width: 8),
          ],
          Text(title),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) {
              onCancel!();
            }
          },
          child: Text(cancelButtonText),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmButtonColor,
            foregroundColor: confirmTextColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            if (onConfirm != null) {
              onConfirm!();
            }
          },
          child: Text(confirmButtonText),
        ),
      ],
    );
  }
}

Future<void> showMaterialConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  String confirmButtonText = 'Confirmar',
  String cancelButtonText = 'Cancelar',
  Color confirmButtonColor = Colors.blue,
  Color confirmTextColor = Colors.white,
  IconData? icon,
  Color? iconColor,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return MaterialConfirmationDialog(
        title: title,
        message: message,
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmButtonText: confirmButtonText,
        cancelButtonText: cancelButtonText,
        confirmButtonColor: confirmButtonColor,
        confirmTextColor: confirmTextColor,
        icon: icon,
        iconColor: iconColor,
      );
    },
  );
} 