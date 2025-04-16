import 'dart:typed_data';

import 'package:flutter/material.dart';

class CamDialog extends StatelessWidget {
  final String title;
  final Uint8List? snapshot;
  const CamDialog({
    super.key,
    required this.title,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 700,
        height: 350,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(3.14159), 
          child: Image.memory(snapshot!),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.done, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
