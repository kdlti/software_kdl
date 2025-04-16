import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../../../presentation/presenters.dart';
import '../../../../../picking_list/export.dart';
import '../../../../../picking_list/ui/input_controllers.dart';

class ExtractRelatory extends StatelessWidget {
  final String id;
  final String doc;
  final String client;
  const ExtractRelatory({
    super.key,
    required this.id,
    required this.doc,
    required this.client,
  });

  Future<void> showDialogRelatory(
      context, GetxTableSimucPresenter controller) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: AlertDialog(
                insetPadding: const EdgeInsets.all(20),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      // ExportSheet(),
                      MyAppRelatorio(arId: id, doc: doc, client: client),
                      Positioned(
                        top: 2,
                        right: 5,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          color: Colors.red,
                          onPressed: () {
                            inputBoxText.clear();
                            inputNserlum.clear();
                            Navigator.of(context).pop();
                             
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxTableSimucPresenter>(context);
    return InkWell(
      child: const Tooltip(
        message: "Gerar Romaneio",
        child: Icon(
          Icons.assignment,
          size: 25,
        ),
      ),
      onTap: () async {
        await showDialogRelatory(context, controller);
      },
    );
  }
}
