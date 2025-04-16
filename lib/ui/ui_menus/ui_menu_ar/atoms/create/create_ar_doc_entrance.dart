import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/errors/errors.dart';
import '../../forms/create/create.dart';

class CreateArDocEntrance extends StatefulWidget {
  const CreateArDocEntrance({super.key});

  @override
  State<CreateArDocEntrance> createState() => _CreateArDocEntranceState();
}

class _CreateArDocEntranceState extends State<CreateArDocEntrance> {

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateArPresenter?>(context);

    return Column(
      children: [
        StreamBuilder<UIError?>(
            stream: presenter?.docEntranceErrorStream,
            builder: (context, snapshot) {
              return Column(
                children: [
                  TextFormField(
                    enabled: true,
                    decoration: InputDecoration(
                      labelText: "Doc. de Entrada",
                      errorText: snapshot.data?.description,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    onChanged: presenter!.validateDocEntrance,
                  ),
                ],
              );
            }),
      ],
    );
  }
}
