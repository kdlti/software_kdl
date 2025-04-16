import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/errors/errors.dart';
import '../../forms/create/create.dart';

class CreateArUser extends StatelessWidget {
  const CreateArUser({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateArPresenter?>(context);
    return StreamBuilder<UIError?>(
      stream: presenter?.userErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: "Usuário",
            errorText: snapshot.data?.description,
          ),
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(20),
          ],
          onChanged: presenter?.validateUser,
        );
      },
    );
  }
}
