import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';

import '../../../../../../domain/entities/entities.dart';
import '../../../../../../presentation/presenters.dart';

class MenuRomaneio extends StatelessWidget {
  final GetxArPresenter controller;
  final String ar;

  const MenuRomaneio({super.key, required this.controller, required this.ar});

  @override
  Widget build(BuildContext context) {
    controller.loadPdfs(ar);
    return StreamBuilder<List<PdfEntity>>(
      stream: controller.listPdf,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Romaneios ainda não gerados'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return PopupMenuButton<PdfEntity>(
            tooltip: "Romaneios",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: const Color.fromARGB(255, 255, 255, 255),
            elevation: 4,
            offset: const Offset(0, 20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Icon(Icons.picture_as_pdf, size: 20),
            itemBuilder: (context) {
              return snapshot.data!.map((PdfEntity pdfEntity) {
                return PopupMenuItem<PdfEntity>(
                  value: pdfEntity,
                  child: ListTile(
                    title: Text(pdfEntity.fileName),
                    leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                    onTap: () async {
                      final bytes = base64Decode(pdfEntity.content);
                      final blob = html.Blob([bytes], 'application/pdf');
                      final url = html.Url.createObjectUrlFromBlob(blob);
                      final anchor = html.AnchorElement(href: url)
                        ..setAttribute('download', pdfEntity.fileName)
                        ..click();
                      html.Url.revokeObjectUrl(url);
                    },
                  ),
                );
              }).toList();
            },
          );
        } else {
          return const Center(child: Text("Vazio"));
        }
      },
    );
  }
}
