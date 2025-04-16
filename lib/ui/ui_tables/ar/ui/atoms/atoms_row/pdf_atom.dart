import 'dart:html' as html;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../../../domain/entities/tables/entity_pdfs.dart';
import '../../../../../../presentation/presenters.dart';

class PdfAtom extends StatefulWidget {
  final GetxArPresenter controller;
  final String ar;
  const PdfAtom({super.key, required this.controller, required this.ar});

  @override
  State<PdfAtom> createState() => _PdfAtomState();
}

class _PdfAtomState extends State<PdfAtom> {
  bool _isLoading = true;
  // Set to store filenames of confirmed deliveries
  final Set<String> _confirmedDeliveries = {};

  @override
  void initState() {
    super.initState();
    widget.controller.loadPdfs(widget.ar);

    // Simulando 1 segundo de loading
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  // Método para confirmar entrega de um PDF
  void _confirmDelivery(PdfEntity pdf) {
    setState(() {
      // Toggle confirmation status
      if (_confirmedDeliveries.contains(pdf.fileName)) {
        _confirmedDeliveries.remove(pdf.fileName);
      } else {
        _confirmedDeliveries.add(pdf.fileName);
      }
    });

    // Aqui você deve implementar a lógica para registrar a confirmação
    // Por exemplo:
    // widget.controller.confirmDelivery(pdf.fileName, widget.ar);

    // Exibindo um snackbar para confirmar a ação
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_confirmedDeliveries.contains(pdf.fileName) 
            ? 'Romaneio ${pdf.fileName} confirmado com sucesso!' 
            : 'Confirmação de entrega cancelada para ${pdf.fileName}'),
        backgroundColor: _confirmedDeliveries.contains(pdf.fileName) ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PdfEntity>>(
      stream: widget.controller.listPdf,
      builder: (context, snapshot) {
        if (_isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Romaneios ainda não gerados'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final pdfEntity = snapshot.data![index];
              final bytes = base64Decode(pdfEntity.content);
              final fileName = pdfEntity.fileName;
              return ListTile(
                title: Text(fileName),
                leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.download),
                      tooltip: 'Download',
                      onPressed: () async {
                        final blob = html.Blob([bytes], 'application/pdf');
                        final url = html.Url.createObjectUrlFromBlob(blob);
                        final anchor = html.AnchorElement(href: url)
                          ..setAttribute('download', fileName)
                          ..click();
                        html.Url.revokeObjectUrl(url);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _confirmedDeliveries.contains(pdfEntity.fileName)
                            ? Icons.check_circle
                            : Icons.local_shipping,
                        color: _confirmedDeliveries.contains(pdfEntity.fileName)
                            ? Colors.green
                            : Colors.orange,
                      ),
                      tooltip: _confirmedDeliveries.contains(pdfEntity.fileName)
                          ? 'Entrega Confirmada'
                          : 'Confirmar Entrega',
                      onPressed: () {
                        // Mostrar diálogo de confirmação antes de confirmar
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(_confirmedDeliveries.contains(pdfEntity.fileName)
                                  ? 'Cancelar confirmação'
                                  : 'Confirmar entrega'),
                              content: Text(
                                  _confirmedDeliveries.contains(pdfEntity.fileName)
                                      ? 'Deseja cancelar a confirmação de entrega do romaneio "$fileName"?'
                                      : 'Confirmar a entrega do romaneio "$fileName"?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Voltar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _confirmDelivery(pdfEntity);
                                  },
                                  child: Text(
                                    _confirmedDeliveries.contains(pdfEntity.fileName)
                                        ? 'Cancelar'
                                        : 'Confirmar',
                                    style: TextStyle(
                                      color: _confirmedDeliveries.contains(pdfEntity.fileName)
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                // Removendo a funcionalidade de download do onTap
                onTap: null,
              );
            },
          );
        } else {
          return const Center(
            child: Text(
              "Vazio",
              style: TextStyle(fontSize: 20),
            ),
          );
        }
      },
    );
  }
}
