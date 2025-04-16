import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../utils/errors/ui_error.dart';
import '../../../forms/create/create.dart';

class CreateSimucInspEntrance extends StatefulWidget {
  const CreateSimucInspEntrance({super.key});

  @override
  State<CreateSimucInspEntrance> createState() =>
      _CreateSimucInspEntranceState();
}

class _CreateSimucInspEntranceState extends State<CreateSimucInspEntrance> {
  BorderRadius borderRadius = BorderRadius.circular(5);

  List<String> itemList = [
    'Inspeção de Entrada',
    'SEM DANOS INTERNO',
    'APRESENTA DANOS INTERNO',
    'CARBONIZADA',
    'APRESENTA COPO AVARIADO',
    'PARTES SOLTAS',
    'BASE DANIFICADA',
    'CONTATOS AVARIADOS',
    'INFILTRAÇÃO DE ÁGUA',
    'S/ ETIQUETA',
    'S/ COPO',
    'SEM RECUPERAÇÃO',
    'ETIQUETA DANIFICADA'
  ];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateSimucPresenter?>(context);
    return StreamBuilder<UIError?>(
        stream: presenter?.inspEntranceErrorStream,
        builder: (context, snapshot) {
          return DropdownButtonFormField<String>(
            decoration: InputDecoration(
              errorText: snapshot.data?.description,
            ),
            elevation: 1,
            isDense: true,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            focusColor: Colors.transparent,
            borderRadius: borderRadius,
            value: itemList[0],
            items: itemList.map((costumer) {
              return DropdownMenuItem<String>(
                value: costumer,
                child: AutoSizeText(
                  costumer,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              );
            }).toList(),
            onChanged: (value) {
              presenter?.validateInspEntrance(value!);
              selectedItem = value!;
            },
          );
        });
  }
}
