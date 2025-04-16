import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:teste_git_hub/domain/entities/entities.dart';

// import '../../../errors/errors.dart';
import '../../../../../../../utils/errors/ui_error.dart';
import '../../../forms/create/create.dart';

class CreateSimucNumberSerie extends StatelessWidget {
  const CreateSimucNumberSerie({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateSimucPresenter?>(context);
    return StreamBuilder<UIError?>(
      stream: presenter?.numberSerieErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          // controller: TextEditingController(text: ""),
          decoration: InputDecoration(
            labelText: "Número de Série",
            errorText: snapshot.data?.description,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),  
          ],
          onChanged: (value) => presenter?.validateNumberSerie(value),
        );
      },
    );
  }
}
