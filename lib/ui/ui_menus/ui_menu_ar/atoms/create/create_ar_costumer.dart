import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/errors/errors.dart';
import '../../forms/create/create.dart';

class CreateArCostumer extends StatelessWidget {
  const CreateArCostumer({super.key});

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(5);

    final presenter = Provider.of<CreateArPresenter?>(context);

    return FutureBuilder<List<String>>(
      future: presenter?.loadListCostumers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar clientes'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum cliente disponível'));
        }

        List<String> costumerList = ["Selecione o Cliente", ...snapshot.data!];
        String selectedCostumer = costumerList[0];

        return StreamBuilder<UIError?>(
          stream: presenter?.costumerErrorStream,
          builder: (context, errorSnapshot) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      errorText: errorSnapshot.data?.description),
                  elevation: 1,
                  isDense: true,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  focusColor: Colors.transparent,
                  borderRadius: borderRadius,
                  value: selectedCostumer,
                  items: costumerList.map((costumer) {
                    return DropdownMenuItem<String>(
                      value: costumer,
                      child: Text(
                        costumer,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedCostumer = value!;
                    presenter?.validateCostumer(value);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
