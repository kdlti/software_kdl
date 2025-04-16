import 'package:flutter/material.dart';

class TitleAtoms extends StatelessWidget {
  final String label;
  const TitleAtoms({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Roboto',
              color: Color.fromARGB(255, 99, 99, 99),
              fontWeight: FontWeight.w700,
              fontSize: 28,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
