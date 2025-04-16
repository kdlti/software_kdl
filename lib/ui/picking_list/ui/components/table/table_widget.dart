import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../domain/entities/entities.dart';
import '../../presenters/page_presenter.dart';

class TableWidget extends StatefulWidget {
  const TableWidget({Key? key}) : super(key: key);

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PagePresenter?>(context);
    return StreamBuilder<List<EntitySimucsPiclingList>>(
        stream: presenter?.simucEntityStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 214, 214, 214)),
                  child: const Center(
                      child: Text("Escaneie alguma peça para iniciar")),
                )
              : Container(
                  color: const Color.fromARGB(255, 214, 214, 214),
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Expanded(
                                child: Center(child: Text('SIMUC')),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(
                                    child: Text(
                                  'DEFEITO RELATADO',
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(child: Text('INSP. ENTRADA')),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(
                                    child: Text(
                                  'DEFEITO CONSTATADO',
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(child: Text('MATERIAIS')),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(child: Text('NÍVEL')),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(child: Text('OBS')),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(child: Text('REMOVER')),
                              ),
                            ),
                          ],
                          rows: snapshot.data!.asMap().entries.map((entry) {
                            final index = entry.key;
                            final dado = entry.value;
                            return DataRow(cells: [
                              DataCell(
                                Center(
                                  child: Text(
                                    dado.numberSerie,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    dado.defectRelated,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    dado.inspEntrance,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    dado.defectConst,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    dado.componentsConst,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    dado.nivel,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    dado.obsConst,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: IconButton(
                                    onPressed: () {
                                      presenter!.removerDado(index);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                );
        });
  }
} 