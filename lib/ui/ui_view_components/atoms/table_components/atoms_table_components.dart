import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../widgets/widget.dart';
import '../../components_presenter.dart';
import '../../mixins/mixins.dart';

class AtomsTableComponent extends StatefulWidget with LoadingManager {
  final ComponentsPresenter presenter;
  const AtomsTableComponent({super.key, required this.presenter});

  @override
  State<AtomsTableComponent> createState() => _AtomsTableComponentState();
}

class _AtomsTableComponentState extends State<AtomsTableComponent> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.presenter.isLoadingStream.listen((loading) {
      setState(() {
        isLoading = loading;
      });
    });

    widget.presenter.total;
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ComponentsPresenter>(context);

    return FutureBuilder<List<ComponentsEntity>>(
      future: Future.delayed(const Duration(seconds: 1))
          .then((_) => presenter.fetchData()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: 400,
            height: 180,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.3),
              color: const Color.fromARGB(255, 204, 204, 204),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar dados'));
        } else if (snapshot.data!.isNotEmpty) {
          return Stack(
            children: [
              WidgetsTableComponent(
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Código'),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Descrição'),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Valor'),
                      ),
                    ),
                  ),
                ],
                rows: presenter.listComponents.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(Align(
                        alignment: Alignment.center,
                        child: Text(
                          item.code,
                          style: const TextStyle(fontSize: 12),
                        ),
                      )),
                      DataCell(Align(
                        alignment: Alignment.center,
                        child: Text(
                          item.description,
                          style: const TextStyle(fontSize: 12),
                        ),
                      )),
                      DataCell(
                        Align(
                          alignment: Alignment.center,
                          child: Text(item.value),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              if (isLoading) const AtomsLoading(),
            ],
          );
        } else {
          return Container(
            width: 400,
            height: 180,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.3),
              color: const Color.fromARGB(255, 204, 204, 204),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings_input_component_rounded,
                  size: 60,
                  color: Colors.black26,
                ),
                SizedBox(height: 10),
                Text("Sem Componentes")
              ],
            ),
          );
        }
      },
    );
  }
}
