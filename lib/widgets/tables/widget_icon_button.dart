import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final Icon icon;
  final String? tooltip;
  final Function()? onPressed;
  final Color? highlightColor;
  final EdgeInsetsGeometry? padding;

  const IconButtonWidget({
    Key? key,
    this.tooltip,
    this.padding,
    this.onPressed,
    required this.icon,
    this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      padding: padding,
      tooltip: tooltip,
      onPressed: onPressed,
      highlightColor: highlightColor,
    );
  }
}
