import 'dart:typed_data';

import 'package:flutter/material.dart';

class CamDialog extends StatelessWidget {
  final String title;
  final Uint8List? snapshot;
  final VoidCallback onPressed;
  const CamDialog(
      {super.key,
      required this.title,
      required this.snapshot,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: snapshot != null
          ? SizedBox(
            width: 700,
            height: 450,
            child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.14159), 
                child: Image.memory(snapshot!),
              ),
          )
          : const Center(child: Icon(Icons.camera_enhance)),
      actions: [
        IconButton(
          icon: const Icon(Icons.done, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
