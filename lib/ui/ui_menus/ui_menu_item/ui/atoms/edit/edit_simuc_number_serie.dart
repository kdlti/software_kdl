import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/entities/entities.dart';
import '../../forms/edit/edit.dart';

class EditSimucNumberSerie extends StatefulWidget {
  final SimucEditReceivedEntity data;
  const EditSimucNumberSerie({super.key, required this.data});

  @override
  State<EditSimucNumberSerie> createState() => _EditSimucNumberSerieState();
}

class _EditSimucNumberSerieState extends State<EditSimucNumberSerie> {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateEditPresenter>(context);
    presenter.editNumberSerie(widget.data.numberSerie);
    return TextFormField(
      // initialValue: data.numberSerie,
      controller: TextEditingController(text: widget.data.numberSerie),
      decoration: const InputDecoration(
        labelText: "Número de Série",
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      onChanged: (value){
        presenter.editNumberSerie(value);
      }
    );
  }
}
