import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/input_controllers.dart';
import '../../presenters/page_presenter.dart';

class InputSimuc extends StatefulWidget {
  const InputSimuc({Key? key}) : super(key: key);

  @override
  State<InputSimuc> createState() => _InputSimucState();
}

class _InputSimucState extends State<InputSimuc> {
  
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PagePresenter>(context);

    return TextFormField(
      controller: inputNserlum,
      focusNode: presenter.focusNode,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9./]'),
        ),
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: const InputDecoration(
        labelText: 'Inserir Simuc',
      ),
      onChanged: (value) {
        if (value.length == 10) {
          presenter.getNserlum(value, context);
          presenter.focusNode.requestFocus();
        }
      },
    );
  }
} 