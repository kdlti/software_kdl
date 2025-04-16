import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_git_hub/ui/picking_list/ui/page_presenter.dart';
import 'atom/atom.dart';
import 'atom/relatorio/dropdown_romaneio.dart';

class CreatePage extends StatefulWidget {
  final PagePresenter presenter;
  const CreatePage({super.key, required this.presenter});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  void initState() {
    widget.presenter.initializeData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListenableProvider(
        create: (_) => widget.presenter,
        child: Form(
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 245, 245, 245),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: width < 1000
                        ? const EdgeInsets.all(10.0)
                        : const EdgeInsets.all(20.0),
                    child: const Column(
                      children: [
                        DropdownRomaneio(),
                        SizedBox(height: 20),
                        InputBox(),
                        SizedBox(height: 20),
                        InputSimuc(),
                        SizedBox(height: 20),
                        Quantity(),
                        SizedBox(height: 20),
                        ExportCsv(),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  flex: 5,
                  child: TableWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
