import 'package:flutter/material.dart';

class CamFloatingAction extends StatelessWidget {
  final VoidCallback onPressed;
  const CamFloatingAction({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.red,
      highlightElevation: 0,
      focusElevation: 0,
      focusColor: Colors.transparent,
      hoverElevation: 0,
      elevation: 0,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      onPressed: onPressed,
      child: const Icon(Icons.camera, size: 25),
    );
  }
}
