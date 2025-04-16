import 'package:flutter/material.dart';
import '../../../../../../presentation/presenters.dart';
import '../atoms.dart';

class AtomIconRomaneio extends StatelessWidget {
  final GetxArPresenter controller;
  final String ar;
  const AtomIconRomaneio({super.key, required this.controller, required this.ar});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Tooltip(
        message: "Romaneios",
        child: Icon(
          color: Colors.red,
          Icons.picture_as_pdf,
          size: 20,
        ),
      ),
      onTap: () async {
        atomDialogRomaneio(context, controller, ar);
      },
    );
  }
}
