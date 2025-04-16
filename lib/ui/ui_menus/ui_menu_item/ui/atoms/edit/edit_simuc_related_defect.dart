import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/entities/entities.dart';
import '../../forms/edit/edit.dart';

class EditSimucRelatedDefect extends StatefulWidget {
  final SimucEditReceivedEntity data;
  const EditSimucRelatedDefect({super.key, required this.data});

  @override
  State<EditSimucRelatedDefect> createState() => _EditSimucRelatedDefectState();
}

class _EditSimucRelatedDefectState extends State<EditSimucRelatedDefect> {
  BorderRadius borderRadius = BorderRadius.circular(5);

  List<String> itemList = [
    'Defeito Relatado',
    'SURTO DE ENERGIA',
    'ERRO DE RÁDIO',
    'LUX ALTO',
    'RSSI BAIXO',
    'NÃO'
  ];

  String? selectedItem;
  
  @override
  Widget build(BuildContext context) {
     final presenter = Provider.of<CreateEditPresenter>(context);
     presenter.editDefectRelated(widget.data.defectRelated);
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(),
      elevation: 1,
      isDense: true,
      isExpanded: false,
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      focusColor: Colors.transparent,
      borderRadius: borderRadius,
      value: widget.data.defectRelated,
      style: const TextStyle(fontSize: 14),
      items: itemList.map((costumer) {
        return DropdownMenuItem<String>(
          value: costumer,
          child: Text(costumer),
        );
      }).toList(),
      onChanged: (value) {
        presenter.editDefectRelated(value!);
        selectedItem = value;
      },
    );
  }
}
