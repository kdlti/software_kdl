import 'package:flutter/material.dart';

import '../../../../../../../domain/entities/entities.dart';

class IconButtonEdit extends StatelessWidget {
  final SimucEntityTables data;
  const IconButtonEdit({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Romaneio de Envio",
      child: InkWell(
        onTap: () {},
        child: const Icon(
          Icons.picture_as_pdf,
          color: Colors.red,
          size: 18,
        ),
      ),
    );
  }
}
