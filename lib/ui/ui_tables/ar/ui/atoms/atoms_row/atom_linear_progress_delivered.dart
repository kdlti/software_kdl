import 'package:flutter/material.dart';
import 'package:teste_git_hub/domain/entities/tables/entity_ar.dart';

import '../../../../../../domain/entities/entities.dart';

class AtomLinearProgressDelivered extends StatelessWidget {
  final ArEntityTable row;
  final Color? color;
  const AtomLinearProgressDelivered({super.key, required this.row, this.color});

  @override
  Widget build(BuildContext context) {
    final value = [int.parse(row.delivered), int.parse(row.quantityItens)];
    List list = List.from(value);
    return Column(
      children: [
        SizedBox(
          width: 85,
          height: 8,
          child: LinearProgressIndicator(
            backgroundColor: Colors.black12,
            borderRadius: BorderRadius.circular(5),
            color: color,
            value: list.first / list.last,
          ),
        ),
        Text("${list.first} de ${list.last}")
      ],
    );
  }
}
