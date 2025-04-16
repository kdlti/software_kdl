import 'package:flutter/material.dart';

import '../../../../../ui_view_components/view_components.dart';

class ExpandedRowMolecule extends StatelessWidget {
  final String id;
  final String arid;
  final String simuc;
  const ExpandedRowMolecule({
    super.key,
    required this.id,
    required this.arid,
    required this.simuc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Color.fromARGB(255, 221, 221, 221),
      ),
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ViewComponents(
            id: id,
            arid: arid,
            simuc: simuc,
          ),
        ],
      ),
    );
  }
}
