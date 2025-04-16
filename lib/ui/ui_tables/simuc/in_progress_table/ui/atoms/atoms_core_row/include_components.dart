import 'package:flutter/material.dart';

import '../../../../../../ui_include_components/include_components.dart';

class IncludeComponents extends StatelessWidget {
  final String id;
  final String arId;
  const IncludeComponents({super.key, required this.id, required this.arId});

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
                    width: 1000,
                    height: 540,
                    child: Stack(
                      children: [
                        ComponenteInclude(id: id, arId: arId),
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
        message: "Incluir COMPONENTE",
        child: Icon(
          Icons.add,
          size: 20,
        ),
      ),
      onTap: () async {
        await showDialogCompo(context);
      },
    );
  }
}
