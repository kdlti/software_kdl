import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/entities/entities.dart';
import '../../forms/edit/edit.dart';

class EditSimucInspEntrance extends StatefulWidget {
  final SimucEditReceivedEntity data;
  const EditSimucInspEntrance({super.key, required this.data});

  @override
  State<EditSimucInspEntrance> createState() => _EditSimucInspEntranceState();
}

class _EditSimucInspEntranceState extends State<EditSimucInspEntrance> {
  BorderRadius borderRadius = BorderRadius.circular(5);

  List<String> itemList = [
   'Inspeção de Entrada',
    'PEÇA INTEIRA SEM DEFEITO APARENTE',
    'PEÇA INTEIRA APRESENTA DEFEITO INTERNO',
    'PEÇA CARBONIZADA',
    'APRESENTA MARCA DE QUEIMADO NOS CONTATOS',
    'APRESENTA COPO AVARIADO',
    'PARTES SOLTAS',
    'CONTATOS AVARIADOS',
    'PEÇA S/ ETIQUETA',
    'PEÇA S/ COPO',
    'SEM RECUPERAÇÃO',
  ];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateEditPresenter>(context);
    presenter.editInspEntrance(widget.data.inspEntrance);
    return DropdownButtonFormField<String>(
      elevation: 1,
      isDense: true,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      focusColor: Colors.transparent,
      borderRadius: borderRadius,
      value: widget.data.inspEntrance,
      items: itemList.map((costumer) {
        return DropdownMenuItem<String>(
          value: costumer,
          child: AutoSizeText(
            costumer,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: const TextStyle(fontSize: 14),
          ),
        );
      }).toList(),
      onChanged: (value) {
        presenter.editInspEntrance(value!);
        selectedItem = value;
      },
    );
  }
}
