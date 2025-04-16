import 'package:flutter/material.dart';
import 'package:ide_modular/export.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/export.dart';
import 'package:teste_git_hub/ui/ui_tables/ar/ui/atoms/atoms.dart';
import '../../../../../infra/infra.dart';
import '../../../../../presentation/presenters.dart';
import '../../../../ui_menus/export.dart';
import '../../core/core.dart';
import '../../../../../widgets/tables/widget_progress_indicator.dart';
import '../molecules/molecules.dart';

class InitTableAr extends StatefulWidget {
  final GetxArPresenter controller;
  const InitTableAr({super.key, required this.controller});
  @override
  InitTableArState createState() => InitTableArState();
}

class InitTableArState extends State<InitTableAr>
    with SingleTickerProviderStateMixin {
  late WebSocketService _webSocketService;
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    _webSocketService = WebSocketService();
    _webSocketService.connect('ws');
    _webSocketService.getChannelStream("updateTableAr").listen((event) {
      setState(() {
        widget.controller.initializeData();
      });
    });
    
    Future.microtask(startChecking);
  }


  void startChecking() async {
    while (widget.controller.source.isEmpty) {
      await widget.controller.initializeData();
      await Future.delayed(const Duration(milliseconds: 100));
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: ListenableProvider(
                    create: (_) => widget.controller,
                    child: Consumer<GetxArPresenter>(
                      builder: (context, controller, child) {
                        return Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: SizedBox(
                              width: 1450,
                              child: ResponsiveDatatable(
                                heightActionHeader: 10,
                                title: const TitleAtoms(
                                    label:
                                        "Aviso de Recebimento de Consertos - Em Andamento"),
                                rowAction: const RowAction(),
                                widgetLoad:
                                    const CustomLinearProgressIndicator(),
                                rows: CreateRows(
                                  webSocketService: _webSocketService,
                                  tabController: _tabController,
                                ),
                                footers: const FooterMolecule(),
                                reponseScreenSizes: const [ScreenSize.xs],
                                autoHeight: false,
                                isLoading: controller.isLoading,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SideMenu(
            maxWidth: 250,
            hasResizer: false,
            hasResizerToggle: true,
            position: SideMenuPosition.right,
            mode: SideMenuMode.open,
            builder: (data) => const SideMenuData(
              customChild: MenuManagerAr(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _webSocketService.disconnect();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
