import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:teste_git_hub/ui/ui_tables/ar/core/create_header.dart';
import '../../../../foundations/foundations.dart';

import '../../../../infra/infra.dart';
import '../../../../presentation/presenters.dart';
import '../../../../utils/tables/headers/header_ars_in_progress.dart';
import '../../../../widgets/widget.dart';
import '../ui/atoms/atoms_row/atom_icon_romaneio.dart';

class CreateRows extends StatefulWidget {
  final WebSocketService webSocketService;
  final TabController tabController;
  const CreateRows(
      {super.key, required this.webSocketService, required this.tabController});

  @override
  State<CreateRows> createState() => _CreateRowsState();
}

class _CreateRowsState extends State<CreateRows> {
  List<Widget> arsInProgress(
      GetxArPresenter controller, WebSocketService webSocketService) {
    List<Widget> widgets = [];

    for (var index = 0; index < controller.source.length; index++) {
      var data = controller.source[index];
      widgets.add(
        Column(
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
                onLongPress: () => {
                  // controller.loadPdfs(data.ar),
                  // atomDialogRomaneio(context, controller),
                },
                onTap: () {
                  // webSocketService.selecionarLinha("selected_line", data.ar);
                  Get.toNamed('/tableItens',
                      arguments: [data.ar, data.docEntrance, data.client]);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (controller.showSelect)
                        Row(
                          children: [
                            CheckboxWidget(
                              value: controller.selecteds.contains(data),
                              onChanged: (value) =>
                                  controller.onSelect(value, data),
                            ),
                          ],
                        ),
                      ...headerArInProgress
                          .where((header) => header.show == true)
                          .map(
                            (header) => Expanded(
                              flex: header.flex,
                              child: header.sourceBuilder != null
                                  ? header.sourceBuilder!(
                                      data.getProperty(header.value), data)
                                  : header.comands
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (data.delivered != "0")
                                              AtomIconRomaneio(
                                                controller: controller,
                                                ar: data.ar,
                                              )
                                          ],
                                        )
                                      : Text(
                                          "${data.getProperty(header.value)}",
                                          textAlign: header.textAlign,
                                          style: controller.selecteds
                                                  .contains(data)
                                              ? TextDecoration.selectedTextStyle
                                              : TextDecoration.rowTextStyle(
                                                  header),
                                        ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxArPresenter>(context);

    return Column(
      children: [
        HeaderAr(header: headerArInProgress),
        Expanded(
          child: ListView(
            children: arsInProgress(controller, widget.webSocketService),
          ),
        ),
      ],
    );
  }
}
