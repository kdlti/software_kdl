import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_git_hub/ui/picking_list/ui/page_presenter.dart';

import '../../dialogs/dialogs_extract_relatory.dart';

class ExportCsv extends StatelessWidget {
  const ExportCsv({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final presenter = Provider.of<PagePresenter>(context);
    return StreamBuilder<bool?>(
        stream: presenter.isFormValidStream,
        builder: (context, snapshot) {
          return width < 1000
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Tooltip(
                      message: "Limpar Lista",
                      verticalOffset: 40,
                      child: IconButton(
                        onPressed: snapshot.data == true
                            ? () => presenter.cleanList()
                            : null,
                        icon: Icon(
                          Icons.delete,
                          size: 40,
                          color: snapshot.data == true
                              ? Colors.red
                              : const Color.fromARGB(255, 165, 165, 165),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Tooltip(
                        message: "Baixar PDF",
                        verticalOffset: 40,
                        child: ExtractRelatory()),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Tooltip(
                      message: "Limpar Lista",
                      verticalOffset: 40,
                      child: IconButton(
                        onPressed: snapshot.data == true
                            ? () => presenter.cleanList()
                            : null,
                        icon: Icon(
                          Icons.delete,
                          size: 40,
                          color: snapshot.data == true
                              ? Colors.red
                              : const Color.fromARGB(255, 165, 165, 165),
                        ),
                      ),
                    ),
                    const Tooltip(
                        message: "Baixar PDF",
                        verticalOffset: 40,
                        child: ExtractRelatory()),
                  ],
                );
        });
  }
}
