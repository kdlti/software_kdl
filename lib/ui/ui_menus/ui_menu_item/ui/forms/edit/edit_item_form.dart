import 'package:flutter/material.dart';
import 'package:menu_modular/export.dart';
import 'package:provider/provider.dart';
// import 'package:websocket_service_package/export.dart';
import '../../../../../../domain/entities/entities.dart';
import '../../../../../../infra/infra.dart';
import '../../../../../../main/factories/http/http.dart';
import '../../../../../../utils/menus/utils.dart';
import '../../../../../../widgets/widget.dart';
import '../../atoms/edit/edit.dart';
import '../../mixins/mixins.dart';
import 'presenters/create_edit_presenter.dart';

class EditItemForm extends StatefulWidget with LoadingManagerMessage {
  final CreateEditPresenter presenter;
  final VoidCallback onBack;
  const EditItemForm({
    super.key,
    required this.onBack,
    required this.presenter,
  });

  @override
  State<EditItemForm> createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _webSocketService = WebSocketService();
  late SimucEditReceivedEntity data;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          TabBarBackAtomMenu(
              title: "Gerar Romaneio / Criar", onBack: widget.onBack),
          Positioned(
              top: 45,
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Caixa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Número da Peça',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        0, // This should be replaced with the actual count of pieces
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            'Peça $index'), // Replace with actual piece data
                      );
                    },
                  ),
                ),
              ]))
        ]),
      );
    });
  }
}
