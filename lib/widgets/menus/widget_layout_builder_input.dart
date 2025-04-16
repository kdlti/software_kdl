import 'package:flutter/material.dart';

class WidgetLayoutBuilderInput<T> extends StatelessWidget {
  final Future<T> futureFunction;
  final Stream<T?>? stream;
  final List<String> costumerList;
  final String? Function(T?)? errorTextBuilder;
  final Function(String?)? onChanged;
  
  const WidgetLayoutBuilderInput({
    super.key,
    required this.futureFunction,
    this.stream,
    required this.costumerList,
    this.errorTextBuilder, 
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(5);

    // final presenter = Provider.of<CreateArPresenter?>(context);

    return FutureBuilder<T>(
      future: futureFunction,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar clientes'));
        }

        // List<String> costumerList = ["Selecione o Cliente", ...snapshot.data!];
        String selectedCostumer = costumerList[0];

        return StreamBuilder<T?>(
          stream: stream,
          builder: (context, errorSnapshot) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    errorText: errorTextBuilder != null
                        ? errorTextBuilder!(snapshot.data)
                        : null,
                  ),
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
                  onChanged: onChanged
                );
              },
            );
          },
        );
      },
    );
  }
}
