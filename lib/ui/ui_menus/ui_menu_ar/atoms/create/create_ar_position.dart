import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/errors/errors.dart';
import '../../forms/create/create.dart';

class CreateArPosition extends StatelessWidget {
  const CreateArPosition({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateArPresenter?>(context);
    return StreamBuilder<UIError?>(
        stream: presenter?.positionErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: "Posição",
              errorText: snapshot.data?.description,
            ),
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(10),
            ],
            onChanged: presenter?.validatePosition,
          );
        });
  }
}
