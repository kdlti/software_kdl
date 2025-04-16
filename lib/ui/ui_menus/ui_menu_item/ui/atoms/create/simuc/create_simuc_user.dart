import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../../errors/errors.dart';
import '../../../../../../../utils/errors/ui_error.dart';
import '../../../forms/create/create.dart';

class CreateSimucUser extends StatelessWidget {
  const CreateSimucUser({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateSimucPresenter?>(context);
    return StreamBuilder<UIError?>(
      stream: presenter?.userErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: "Usuário",
            errorText: snapshot.data?.description,
          ),
          onChanged: (value) => presenter?.validateUser(value),
        );
      }
    );
  }
}
