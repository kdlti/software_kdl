import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/entities/entities.dart';
import '../../forms/edit/edit.dart';

class EditSimucDefectFound extends StatefulWidget {
  final SimucEditReceivedEntity data;
  const EditSimucDefectFound({super.key, required this.data});

  @override
  State<EditSimucDefectFound> createState() => _EditSimucDefectFoundState();
}

class _EditSimucDefectFoundState extends State<EditSimucDefectFound> {
  BorderRadius borderRadius = BorderRadius.circular(5);

  List<String> itemList = [
    'Defeito Encontrado',
    'PEÇA INTEIRA SEM DEFEITO APARENTE',
    'ANTENA SOLTA',
    'COMPONENTE MAL SOLDADO',
    'COMPONENTES SOLTOS',
    'QUEIMA DOS COMPONENTES DE PROTEÇÃO',
    'FALHA NO MEDIDOR DE ENERGIA',
    'FALHA DE NÍVEL 2',
    'PEÇA S/ RECUPERAÇÃO',
    'TROCA DE ANTENA'
  ];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateEditPresenter>(context);
    presenter.editDefectFound(widget.data.defectFound);
    return DropdownButtonFormField<String>(
      elevation: 1,
      isDense: true,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      focusColor: Colors.transparent,
      borderRadius: borderRadius,
      value: widget.data.defectFound.isEmpty
          ? itemList[0]
          : widget.data.defectFound,
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
        presenter.editDefectFound(value!);
        selectedItem = value;
      },
    );
  }
}
