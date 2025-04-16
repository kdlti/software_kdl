import 'package:flutter/material.dart';
import '../atoms/atoms.dart';
import '../atoms/atoms_footer/subtitles_atom.dart';

class FooterMolecule extends StatelessWidget {
  const FooterMolecule({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SubtitlesAtom(),
          Spacer(),
          RowsPerPageAtom(),
          PageViewsAtom(),
          NavigatePagesAtom()
        ],
      ),
    );
  }
}
