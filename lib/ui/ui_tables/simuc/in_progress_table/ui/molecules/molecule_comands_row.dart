import 'package:flutter/material.dart';
import 'package:menu_modular/export.dart';
import 'package:provider/provider.dart';
import '../../../../../../presentation/presenters.dart';
import '../../../../../../widgets/widget.dart';
import '../atoms/atoms.dart';
import '../atoms/atoms_comands_row/delete_item.dart';
import '../atoms/atoms_comands_row/nf_atom.dart';
import '../dialogs/dialogs.dart';

class RowAction extends StatelessWidget {
  final String id;
  final String doc;
  final String client;
  const RowAction({
    super.key,
    required this.id,
    required this.doc,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxTableSimucPresenter>(context);
    
    // Calculate the number of selectable items (excluding status "4")
    final selectableItemsCount = controller.source.where((element) => element.status != "4").length;
    
    // Check if all selectable items are selected
    final allSelectableItemsSelected = controller.selecteds.length == selectableItemsCount && 
                                      selectableItemsCount > 0;
    
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Color(0xffd9d9d9),
      ),
      child: DefaultTabController(
        length: 4,
        child: Row(
          children: [
            // if (controller.source.any((element) => element.status == "4"))
            CheckboxWidget(
              value: allSelectableItemsSelected,
              onChanged: (value) => controller.onSelectAll(value, excludeStatus4: true),
            ),
            Spacing.horizontalSpaceV,
            SearchBarItemAtom(id: id),
            // const SizedBox(
            //   width: 700,
            //   height: 40,
            //   child: TabBar(
            //     indicatorColor: Color.fromARGB(255, 255, 132, 50),
            //     indicatorWeight: 4,
            //     dividerHeight: 0,
            //     labelColor: Colors.black,
            //     unselectedLabelColor: Color.fromARGB(255, 133, 133, 133),
            //     labelStyle: TextStyle(
            //       fontFamily: 'Roboto',
            //       fontSize: 14,
            //       fontWeight: FontWeight.w600,
            //     ),
            //     tabs: [
            //       Tab(text: 'Em Manutenção'),
            //       Tab(text: 'Aguard. Diagnóstico'),
            //       Tab(text: 'Concluídas'),
            //       Tab(text: 'Rom. Gerado/Enviado'),
            //     ],
            //   ),
            // ),
            const Spacer(),
            NfAtom(id: id, doc: doc),
            const SizedBox(width: 30),
            DeleteItem(
              simuc: controller.selecteds.map((e) => e.numberSerie).toList(),
              onPressed: () => controller.deleteSimucFunction(),
            ),
            RefreshButton(arId: id),
            const ExportSheet(),
            const SizedBox(width: 10),
            ExtractRelatory(id: id, doc: doc, client: client),
          ],
        ),
      ),
    );
  }
}
