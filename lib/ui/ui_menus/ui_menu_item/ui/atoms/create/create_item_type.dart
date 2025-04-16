import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../forms/create/create.dart';
import 'simuc/simuc.dart';

class CreateItemType extends StatefulWidget {
  const CreateItemType({super.key});

  @override
  State<CreateItemType> createState() => _CreateItemTypeState();
}

class _CreateItemTypeState extends State<CreateItemType> {
  BorderRadius borderRadius = BorderRadius.circular(5);

  List<String> itemList = [
    'Selecione o Item',
    'SIMUC',
    'SIMCON',
    'LUMINÁRIA',
  ];
  
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateSimucPresenter?>(context);
    return Column(
      children: [
        StreamBuilder<String?>(
            stream: presenter?.itemErrorStream,
            builder: (context, snapshot) {
              return DropdownButtonFormField<String>(
                elevation: 1,
                isDense: true,
                isExpanded: false,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                focusColor: Colors.transparent,
                borderRadius: borderRadius,
                value: itemList[0],
                items: itemList.map((costumer) {
                  return DropdownMenuItem<String>(
                    value: costumer,
                    child: Text(costumer),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value!;
                    presenter?.validateItem(value);
                  });
                },
              );
            }),
        if (selectedItem == 'SIMUC') const CreateSimucSubForm(),
        if (selectedItem == 'SIMCOM')
          Container(color: Colors.red, width: 100, height: 100),
        if (selectedItem == 'LUMINÁRIA')
          Container(color: Colors.black, width: 100, height: 100),
      ],
    );
  }
}
