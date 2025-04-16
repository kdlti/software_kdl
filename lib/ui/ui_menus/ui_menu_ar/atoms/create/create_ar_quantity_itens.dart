import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/errors/errors.dart';
import '../../forms/create/create.dart';

class CreateArTotalItens extends StatelessWidget {
  const CreateArTotalItens({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateArPresenter?>(context);
    return StreamBuilder<UIError?>(
        stream: presenter?.quantityItensErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: "Qtd. Recebida",
              errorText: snapshot.data?.description,
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            onChanged: presenter?.validateQuantityitens,
          );
        });
  }
}
