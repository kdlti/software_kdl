import 'package:flutter/material.dart';
import '../atoms/atoms.dart';

class FooterMolecule extends StatelessWidget {
  const FooterMolecule({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Spacer(),
          RowsPerPageAtom(),
          PageViewsAtom(),
          NavigatePagesAtom(),
        ],
      ),
    );
  }
}
