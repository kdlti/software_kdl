import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ide_modular/export.dart';
import 'package:menu_modular/export.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/export.dart';
import '../../../../../../foundations/foundations.dart';
import '../../../../../../infra/infra.dart';
import '../../../../../../main/factories/form/menu_item/form_factory.dart';
import '../../../../../../presentation/presenters.dart';
import '../../../../../../utils/enums/enums.dart';
import '../../../../../../widgets/tables/widegt_progress_indicator.dart';
import '../../../../../ui_menus/ui_menu_item/ui/forms/create/create.dart';

import '../../../../../ui_menus/ui_menu_item/ui/menu_manager_item.dart';
import '../../core/core.dart';
import '../molecules/molecules.dart';
import '../../../../../../widgets/tables/widget_back.dart';

class InitTableItem extends StatefulWidget {
  final GetxTableSimucPresenter controller;
  const InitTableItem({super.key, required this.controller});
  @override
  InitTableItemState createState() => InitTableItemState();
}

class InitTableItemState extends State<InitTableItem> {
  late String id;
  late String doc;
  late String client;
  late WebSocketService _webSocketService;
  // late ScrollController _scrollController;
  late SideMenuController sideMenuController;
  Widget selectedWidget = Container();

  String? renderer;

  @override
  void initState() {
    super.initState();
    sideMenuController = SideMenuController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = Get.arguments as List;
    // _scrollController = ScrollController();
    id = arguments[0] as String;
    doc = arguments[1] as String;
    client = arguments[2] as String;
    widget.controller.stockId = id;
    _webSocketService = WebSocketService();
    _webSocketService.connect('ws');
    _webSocketService.getChannelStream("updateTableItem").listen((event) {
      setState(() {
        widget.controller.initializeData(id);
      });
    });
    Future.microtask(startChecking);
  }

  void startChecking() async {
    while (widget.controller.source.isEmpty) {
      await widget.controller.initializeData(id);
      await Future.delayed(const Duration(milliseconds: 100));
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TabBarBackAtom(
                  path: "/tableAr",
                  title: "VOLTAR / TABELA DE SIMUCS",
                  webSocketService: _webSocketService,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.sizeOf(context).height * 0.92,
                  ),
                  child: ListenableProvider(
                    create: (_) => widget.controller,
                    child: SizedBox(
                      // width: 1450,
                      child: ResponsiveDatatable(
                        headers: const HeaderItem(),
                        rowAction: RowAction(id: id, doc: doc, client: client),
                        widgetLoad: const CustomLinearProgressIndicator(),
                        rows: CreateRows(
                          id: id,
                          webSocketService: _webSocketService,
                          controller: sideMenuController,
                        ),
                        footers: const FooterMolecule(),
                        reponseScreenSizes: const [ScreenSize.xs],
                        autoHeight: false,
                        isLoading: widget.controller.isLoading,
                        heightActionHeader: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SideMenu(
            maxWidth: 250,
            hasResizer: false,
            controller: sideMenuController,
            hasResizerToggle: false,
            // resizerToggleData: ResizerToggleData(
            //   controller: () => _switchViews(EnumMenuHeader.none),
            //   topPosition: 30,
            // ),
            position: SideMenuPosition.right,
            mode: screen < 1200 ? SideMenuMode.compact : SideMenuMode.open,
            builder: (data) => SideMenuData(
              customChild:  MenuManagerItem(id: id)
            ),
          ),
        ],
      ),
    );
  }

  // void _switchViews(EnumMenuHeader activeView) {
  //   setState(() {
  //     switch (activeView) {
  //       case EnumMenuHeader.none:
  //         selectedWidget = Container();
  //         break;
  //       case EnumMenuHeader.add:
  //         selectedWidget = MaterialApp(
  //           debugShowCheckedModeBanner: false,
  //           theme: ThemeForm.getTheme(context),
  //           home: Scaffold(
  //               body: CreateItemForm(
  //             presenter: makeGetxCreateSimucPresenter(id),
  //             onBack: () {
  //               // setState(() {
  //               //   activeView = EnumMenuItem.menuSimuc;
  //               // });
  //             },
  //           )),
  //         );
  //         break;
  //       case EnumMenuHeader.refresh:
  //         selectedWidget = Container(
  //           width: 100,
  //           height: 100,
  //           color: Colors.blue,
  //         );
  //         break;
  //       case EnumMenuHeader.edit:
  //         selectedWidget = Column(
  //           children: [
  //             // CreateSimucNumberSerie(),
  //           ],
  //         );
  //         break;
  //       case EnumMenuHeader.delete:
  //         selectedWidget = Container(
  //           width: 100,
  //           height: 100,
  //           color: Colors.black,
  //         );
  //         break;
  //     }
  //   });
  // }

  @override
  void dispose() {
    _webSocketService.disconnect();
    super.dispose();
  }
}
