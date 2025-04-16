import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../components_presenter.dart';
import '../mixins/loading_manager.dart';

class TableLeft extends StatefulWidget with LoadingManager {
  final ComponentsPresenter presenter;
  const TableLeft({super.key, required this.presenter});

  @override
  State<TableLeft> createState() => _TableLeftState();
}

class _TableLeftState extends State<TableLeft> {
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
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ComponentsPresenter>(context);

    return Builder(builder: (context) {
      return Stack(
        children: [
          Container(
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
                  child: Obx(() {
                    return SingleChildScrollView(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DataTable(
                          headingTextStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          headingRowHeight: 40,
                          dataTextStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          columnSpacing: 15,
                          columns: const [
                            DataColumn(label: Text('Código')),
                            DataColumn(label: Text('Descrição')),
                            DataColumn(label: Text('Valor')),
                            DataColumn(label: Text('Nível')),
                          ],
                          rows: presenter.leftTableData.map((item) {
                            return DataRow( 
                              selected:
                                  presenter.selectedLeftItems.contains(item),
                              onSelectChanged: (selected) => presenter
                                  .onSelectChangedLeftTable(selected, item),
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
                      ),
                    );
                  }),
                ),
                Obx(() {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                              'Total Items: ${presenter.leftTableData.length}'),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => presenter.backPage(),
                          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () => presenter.nextPage(),
                          icon: const Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
          if (isLoading)
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            )
        ],
      );
    });
  }
}
