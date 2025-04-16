import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WidgetCommonInput<T> extends StatefulWidget {
  final String labelText;
  final String? Function(T?)? errorTextBuilder;
  final Stream<T?>? stream;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;

  const WidgetCommonInput({
    super.key,
    required this.labelText,
    this.errorTextBuilder,
    required this.stream,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  State<WidgetCommonInput<T>> createState() => _WidgetCommonInputState<T>();
}

class _WidgetCommonInputState<T> extends State<WidgetCommonInput<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T?>(
      stream: widget.stream,
      builder: (context, AsyncSnapshot<T?> snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: widget.labelText,
            errorText: widget.errorTextBuilder != null
                ? widget.errorTextBuilder!(snapshot.data)
                : null,
          ),
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
        );
      },
    );
  }
}
