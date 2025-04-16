import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../components_presenter.dart';
import '../mixins/loading_manager.dart';

class TableRight extends StatefulWidget with LoadingManager {
  const TableRight({super.key});

  @override
  State<TableRight> createState() => _TableRightState();
}

class _TableRightState extends State<TableRight> {
  // bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ComponentsPresenter>(context);

    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.3),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                    headingTextStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    headingRowHeight: 40,
                    dataTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                    columnSpacing: 15,
                    columns: const [
                      DataColumn(label: Text('Código')),
                      DataColumn(label: Text('Descrição')),
                      DataColumn(label: Text('Valor')),
                      DataColumn(label: Text('Nivel')),
                    ],
                    rows: presenter.rightTableData.map((item) {
                      return DataRow(
                        selected: presenter.selectedRightItems.contains(item),
                        onSelectChanged: (selected) {
                          if (selected!) {
                            presenter.selectedRightItems.add(item);
                          } else {
                            presenter.selectedRightItems.remove(item);
                          }
                        },
                        cells: [
                          DataCell(Align(
                            alignment: Alignment.center,
                            child: Text(item.code,
                                style: const TextStyle(fontSize: 12)),
                          )),
                          DataCell(Text(item.description,
                              style: const TextStyle(fontSize: 12))),
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: Text(item.value),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: Text(item.nivel),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
