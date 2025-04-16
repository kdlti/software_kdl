import 'package:flutter/material.dart';

import '../../atoms/atoms.dart';

class SimucEdit extends StatefulWidget {
  final VoidCallback onBack;
  const SimucEdit({super.key, required this.onBack});

  @override
  State<SimucEdit> createState() => _SimucEditState();
}

class _SimucEditState extends State<SimucEdit> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(children: [
        TabBarBackAtomMenu(title: "AR / Editar", onBack: widget.onBack),
      ]),
    );
  }
}
