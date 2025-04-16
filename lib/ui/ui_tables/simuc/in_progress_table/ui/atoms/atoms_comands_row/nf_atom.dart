import 'package:flutter/material.dart';

class NfAtom extends StatelessWidget {
  final String id;
  final String doc;
  const NfAtom({super.key, required this.doc, required this.id});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Column(
            children: [
              const Text(
                "AR",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                id,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(width: 30),
          Column(
            children: [
              const Text(
                "NF Entrada",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                doc,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
