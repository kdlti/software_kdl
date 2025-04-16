import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../../errors/errors.dart';
import '../../../../../../../utils/errors/ui_error.dart';
import '../../../forms/create/create.dart';

class CreateSimucRelatedDefect extends StatefulWidget {
  const CreateSimucRelatedDefect({super.key});

  @override
  State<CreateSimucRelatedDefect> createState() =>
      _CreateSimucRelatedDefectState();
}

class _CreateSimucRelatedDefectState extends State<CreateSimucRelatedDefect> {
  BorderRadius borderRadius = BorderRadius.circular(5);

  List<String> itemList = [
    'Defeito Relatado',
    'CORRENTE BAIXA',
    'CORRENTE ALTA',
    'TENSÃO ALTA',
    'TENSÃO BAIXA',
    'ÁGUA INTERNA',
    'SURTO DE ENERGIA',
    'ERRO DE RÁDIO',
    'LUX ALTO',
    'LUX BAIXO',
    'RSSI BAIXO',
    'REPROVADO',
    'SINAL RF BAIXO',
    'NÃO'
  ];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateSimucPresenter?>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return StreamBuilder<UIError?>(
            stream: presenter?.relatedDefectErrorStream,
            builder: (context, snapshot) {
              return DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  errorText: snapshot.data?.description,
                ),
                elevation: 1,
                isDense: true,
                isExpanded: true, // Alterado para true
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
                      maxLines: 1, // Ajustado para uma linha
                      minFontSize: 12, // Adicionado para limitar o tamanho mínimo da fonte
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  presenter?.validateRelatedDefect(value!);
                  selectedItem = value!;
                },
              );
            });
      },
    );
  }
}
