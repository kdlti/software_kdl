import 'package:flutter/material.dart';

class CamTemplate extends StatelessWidget {
  const CamTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      width: 100,
      height: 100,
      child: const Center(child: Icon(Icons.camera_enhance)),
    );
  }
}
