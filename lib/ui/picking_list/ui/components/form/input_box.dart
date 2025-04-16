import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/input_controllers.dart';
import '../../presenters/page_presenter.dart';

class InputBox extends StatelessWidget {
  const InputBox({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PagePresenter>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return TextFormField(
        controller: inputBoxText,
        decoration: const InputDecoration(
          labelText: 'Inserir Caixa',
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        onChanged: (value) => presenter.inputBox(value),
      );
    });
  }
} 