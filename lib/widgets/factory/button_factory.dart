import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../menus/menus.dart';

class ButtonFactory {
  static Widget createButton(
    ButtonType type,
    String label,
    Stream<bool?>? stream,
    VoidCallback onPressed,
    BuildContext context,
  ) {
    switch (type) {
      case ButtonType.primary:
        return WidgetCommonButton<bool>(
          onPressed: (value) => value == true ? onPressed : null,
          stream: stream,
          style: (style) => style != true
              ? const ButtonStyle(
                  foregroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(255, 70, 70, 70)),
                  backgroundColor: WidgetStatePropertyAll(
                      Color.fromARGB(255, 214, 214, 214)),
                )
              : Theme.of(context).elevatedButtonTheme.style,
          label: label,
        );
      case ButtonType.secondary:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.grey),
          ),
          child: Text(label),
        );
      case ButtonType.danger:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          child: Text(label),
        );
      default:
        throw Exception('Tipo de botão desconhecido');
    }
  }
}
