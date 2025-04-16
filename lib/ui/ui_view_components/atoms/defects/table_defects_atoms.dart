import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/entities.dart';
import '../../components_presenter.dart';

class TableDefectsAtoms extends StatefulWidget {
  final ComponentsPresenter presenter;
  const TableDefectsAtoms({super.key, required this.presenter});

  @override
  State<TableDefectsAtoms> createState() => _TableDefectsAtomsState();
}

class _TableDefectsAtomsState extends State<TableDefectsAtoms> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.presenter.isLoadingStream.listen((loading) {
      setState(() {
        isLoading = loading;
      });
    });

    widget.presenter.initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ComponentsPresenter>(context);
    return FutureBuilder<List<DefectsEntity>>(
      future: Future.delayed(const Duration(seconds: 1))
          .then((_) => presenter.fetchDefects()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              const Text("Defeito(s) Constatado(s):"),
              Container(
                  width: 270,
                  height: 170.0,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.3),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Center(
                      child: CircularProgressIndicator(color: Colors.orange))),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar dados'));
        } else if (snapshot.data!.isNotEmpty) {
          List<DefectsEntity> defects = snapshot.data!;
          return Column(
            children: [
              const Text("Defeito(s) Constatado(s):"),
              Container(
                width: 270,
                height: 170.0,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.3),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: defects.map((defect) {
                      return Chip(
                        labelPadding: const EdgeInsets.all(0),
                        label: Text(
                          defect.description,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              const Text("Defeito(s) Constatado(s):"),
              Container(
                  width: 270,
                  height: 170.0,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.3),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings_input_component_rounded,
                        size: 60,
                        color: Colors.black26,
                      ),
                      Text("Sem Defeitos")
                    ],
                  )),
            ],
          );
        }
      },
    );
  }
}
