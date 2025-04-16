import 'package:flutter/material.dart';
import 'package:ide_modular/export.dart';
import 'package:provider/provider.dart';
import 'package:teste_git_hub/ui/ui_tables/simuc/in_progress_table/ui/atoms/atoms_comands_row/delete_item.dart';
// import 'package:websocket_service_package/export.dart';
import '../../../../../domain/entities/entities.dart';
import '../../../../../foundations/foundations.dart';

import '../../../../../infra/infra.dart';
import '../../../../../presentation/presenters.dart';
import '../../../../../utils/tables/tables.dart';
import '../../../../../widgets/widget.dart';
import '../ui/atoms/atoms.dart';
import '../ui/molecules/molecules.dart';

class CreateRows extends StatefulWidget {
  final SideMenuController controller;
  final String id;
  final WebSocketService webSocketService;
  const CreateRows({
    super.key,
    required this.id,
    required this.webSocketService,
    required this.controller,
  });

  @override
  State<CreateRows> createState() => _CreateRowsState();
}

class _CreateRowsState extends State<CreateRows> {
  List<Widget> desktopList(GetxTableSimucPresenter controller) {
    List<Widget> widgets = [];
    final dadosRelacionados =
        controller.source.where((item) => item.arId == widget.id).toList();

    for (var index = 0; index < dadosRelacionados.length; index++) {
      var data = dadosRelacionados[index];

      widgets.add(
        StreamBuilder(
            stream: WebSocketService().getChannelStream("updateTableItem"),
            builder: (context, snapshot) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(controller.showSelect ? 0 : 11),
                    decoration: controller.selecteds.contains(data)
                        ? Decorations.selectedDecoration
                        : Decorations.rowDecoration,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onLongPress: () => {widget.controller.open()},
                      onTap: () {
                        setState(() {
                          controller.expanded![index] =
                              !controller.expanded![index];
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (controller.showSelect)
                              Row(
                                children: [
                                  data.status == "4" 
                                  ? Container(
                                      width: 17,
                                      height: 17,
                                      margin: const EdgeInsets.all(8.0),
                                    )
                                  : CheckboxWidget(
                                      value: controller.selecteds.contains(data),
                                      onChanged: (value) =>
                                          controller.onSelect(value, data),
                                    ),
                                ],
                              ),
                            ...headerItem
                                .where((header) => header.show == true)
                                .map(
                                  (header) => Expanded(
                                    flex: header.flex,
                                    child: header.sourceBuilder != null
                                        ? header.sourceBuilder!(
                                            data.getProperty(header.value),
                                            data)
                                        : header.comands
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  if (data.status != "4" &&
                                                      data.status != "1")
                                                    IncludeComponents(
                                                      id: data.id,
                                                      arId: data.arId,
                                                    ),
                                                  if (data.status == "2" ||
                                                      data.status == "1")
                                                    IncludeDefects(
                                                      id: data.id,
                                                      arId: data.arId,
                                                      controller: controller,
                                                    ),
                                                  // DeleteItem(
                                                  //   simuc: data.numberSerie,
                                                  //   id: data.id,
                                                  //   arId: data.arId,
                                                  //   onPressed: () {},
                                                  // )
                                                ],
                                              )
                                            : Text(
                                                "${data.getProperty(header.value)}",
                                                textAlign: header.textAlign,
                                                style: controller.selecteds
                                                        .contains(data)
                                                    ? TextDecoration
                                                        .selectedTextStyle
                                                    : TextDecoration
                                                        .rowTextStyle(header),
                                              ),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (controller.isExpandRows && controller.expanded![index])
                    ExpandedRowMolecule(
                      id: data.id,
                      arid: data.arId,
                      simuc: data.numberSerie,
                    )
                ],
              );
            }),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxTableSimucPresenter>(context);
    return ListView(
      children: desktopList(controller),
    );
  }
}
