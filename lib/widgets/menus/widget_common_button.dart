import 'package:flutter/material.dart';

class WidgetCommonButton<T> extends StatelessWidget {
  final String label;
  final Stream<T?>? stream;
  final Function(T?)? onPressed;
  final ButtonStyle? Function(T?)? style;

  const WidgetCommonButton({
    super.key,
    required this.label,
    this.stream,
    required this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T?>(
      stream: stream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: ElevatedButton(
            onPressed: onPressed!(snapshot.data),
            style: style != null ? style!(snapshot.data) : null,
            child: Text(label),
          ),
        );
      },
    );
  }
}
