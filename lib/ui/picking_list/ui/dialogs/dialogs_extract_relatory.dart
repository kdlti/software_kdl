import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../atom/pdf_creator.dart/app.dart';
import '../page_presenter.dart';

class ExtractRelatory extends StatelessWidget {
  const ExtractRelatory({super.key});

  Future<void> showDialogRelatory(context, PagePresenter presenter) async {
    final scrollbarTheme = ScrollbarThemeData(
      thumbVisibility: WidgetStateProperty.all(true),
    );
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
                      MaterialApp(
                          debugShowCheckedModeBanner: false,
                          theme: ThemeData.light()
                              .copyWith(scrollbarTheme: scrollbarTheme),
                          darkTheme: ThemeData.dark()
                              .copyWith(scrollbarTheme: scrollbarTheme),
                          title: 'Flutter PDF Demo',
                          home: MyAppPdf(
                            presenter: presenter,
                          )),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PagePresenter>(context);

    return StreamBuilder<bool?>(
        stream: presenter.isFormValidStream,
        builder: (context, snapshot) {
          return InkWell(
            onTap: snapshot.data == true
                ? () async {
                    await showDialogRelatory(context, presenter);
                    await presenter.cleanList();
                  }
                : null,
            child: Tooltip(
              message: "Gerar Romaneio",
              child: Icon(
                Icons.picture_as_pdf,
                color: snapshot.data == true
                    ? Colors.red
                    : const Color.fromARGB(255, 165, 165, 165),
                size: 40,
              ),
            ),
          );
        });
  }
}
