import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_git_hub/domain/entities/entities.dart';

import '../../../../../../../presentation/presenters.dart';

class IncludeDefects extends StatelessWidget {
  final String id;
  final String arId;
  final GetxTableSimucPresenter controller;
  const IncludeDefects({
    super.key,
    required this.id,
    required this.arId,
    required this.controller,
  });

  Future<void> showDialogCompo(context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: const Color.fromARGB(0, 231, 231, 231),
            body: Center(
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                contentPadding: const EdgeInsets.all(0),
                content: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: SizedBox(
                    width: 400,
                    height: 440,
                    child: Stack(
                      children: [
                        DefectSelector(
                          id: id,
                          controller: controller,
                          arId: arId,
                        ),
                        Positioned(
                          top: 2,
                          right: 5,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.red,
                            onPressed: () {
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Tooltip(
        message: "Incluir DEFEITOS",
        child: Icon(
          Icons.add_to_photos_sharp,
          size: 20,
        ),
      ),
      onTap: () async {
        await showDialogCompo(context);
      },
    );
  }
}

class DefectSelector extends StatefulWidget {
  final String arId;
  final String id;
  final GetxTableSimucPresenter controller;
  const DefectSelector(
      {super.key,
      required this.controller,
      required this.id,
      required this.arId});

  @override
  DefectSelectorState createState() => DefectSelectorState();
}

class DefectSelectorState extends State<DefectSelector> {
  @override
  void dispose() {
    widget.controller.selectedDefects.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Defeitos:'),
            Container(
              width: screenWidth,
              height: 150.0,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: widget.controller.selectedDefects.map((defect) {
                    return Chip(
                      labelPadding: const EdgeInsets.all(0),
                      label: Text(
                        defect.description,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                      onDeleted: () {
                        setState(() {
                          widget.controller.selectedDefects.remove(defect);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<EntityDefects>(
                        hint: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('ADICIONAR DEFEITO'),
                        ),
                        isExpanded: true,
                        items: widget.controller.allDefects.map((defect) {
                          return DropdownMenuItem<EntityDefects>(
                            value: defect,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(defect.description),
                            ),
                          );
                        }).toList(),
                        onChanged: (defect) {
                          setState(() {
                            if (defect != null &&
                                !widget.controller.selectedDefects
                                    .contains(defect)) {
                              widget.controller.selectedDefects.add(defect);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Observações',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      widget.controller.observation = value;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                style: widget.controller.selectedDefects.isEmpty
                    ? ButtonStyle(
                        elevation: WidgetStateProperty.all(0),
                        foregroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 121, 121, 121)),
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 163, 163, 163)),
                      )
                    : ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 0, 0, 0)),
                        backgroundColor: WidgetStateProperty.all(Colors.orange),
                      ),
                onPressed: () => widget.controller.selectedDefects.isEmpty
                    ? null
                    : widget.controller
                        .saveDefects(widget.arId, widget.id, context),
                child: Obx(
                  () => widget.controller.isLoadingButton.value
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text("Salvar"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
