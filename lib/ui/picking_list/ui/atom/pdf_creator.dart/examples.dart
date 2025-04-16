import 'dart:async';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:teste_git_hub/ui/picking_list/ui/atom/pdf_creator.dart/invoice.dart';

import '../../../../../domain/entities/entities.dart';
import 'custom_data.dart';

const examples = <Example>[
  Example(
    'ROMANEIO',
    'romaneio.dart',
    generateInvoice,
  ),
];

/// Cria um alias para a função que gera um PDF a partir de um [PdfPageFormat] e [CustomData].
///
/// Essa função deve retornar um [Future] que contém uma [Uint8List], que é a representação
/// em bytes do PDF gerado.
///
/// Parâmetros:
///   - pageFormat: O formato da página do PDF a ser gerado.
///   - data: Os dados personalizados necessários para gerar o PDF.
///
/// Retorno:
///   Um [Future] que contém uma [Uint8List] representando o PDF gerado.
typedef LayoutCallbackWithData = Future<Uint8List> Function(
  PdfPageFormat pageFormat,
  CustomData data,
  List<EntitySimucsPiclingList> simucs,
  ClientAddressEntity client,
  String box,
  String arId,
  String doc,
  String quantity,
  {String tipoRomaneio}
);

/// Esta classe constrói o preview de impressão, que espera receber seguintes parâmetros:
/// Parâmetros:
///   - name: Nome que vai na aba que fica no canto superior a esquerda.
///   - file: Recebe o nome do arquivo a ser renderizado.
///   - buider: Recebe a função contrutora do arquivo
///   - needsData: ainda não sei
class Example {
  const Example(this.name, this.file, this.builder, [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;

  final bool needsData;
}
