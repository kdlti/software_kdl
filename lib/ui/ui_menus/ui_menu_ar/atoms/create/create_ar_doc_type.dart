import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/errors/errors.dart';
import '../../forms/create/create.dart';

class CreateArDocType extends StatelessWidget {
  const CreateArDocType({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> docTypeList = [
      'Tipo de Documento',
      'DANFE',
      'CARTA',
      'GUIA DE REMESSA',
      'OUTROS',
      'SEM DOCUMENTO'
    ];

    String selectedDocType = docTypeList[0];
    BorderRadius borderRadius = BorderRadius.circular(5);
    
    final presenter = Provider.of<CreateArPresenter?>(context);
    return StreamBuilder<UIError?>(
      stream: presenter?.docTypeErrorStream,
      builder: (context, snapshot) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return DropdownButtonFormField<String>(
              decoration: InputDecoration(
                errorText: snapshot.data?.description
              ),
              elevation: 1,
              isDense: true,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_outlined),
              focusColor: Colors.transparent,
              borderRadius: borderRadius,
              value: selectedDocType,
              items: docTypeList.map((docType) {
                return DropdownMenuItem<String>(
                  value: docType,
                  child: FittedBox( 
                    fit: BoxFit.scaleDown,
                    child: Text(
                      docType,
                      overflow: TextOverflow.ellipsis, 
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                presenter?.validateDocType(value!);
              },
            );
          },
        );
      }
    );
  }
}
