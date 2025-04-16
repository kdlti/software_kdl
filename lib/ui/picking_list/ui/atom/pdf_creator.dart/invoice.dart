import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mt;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../../domain/entities/entities.dart';
import 'custom_data.dart';

Future<Uint8List> generateInvoice(
  PdfPageFormat pageFormat,
  CustomData data,
  List<EntitySimucsPiclingList> simucs,
  ClientAddressEntity client,
  String box,
  String arId,
  String doc,
  String quantity,
  {String tipoRomaneio = 'normal'}
) async {
  final products = simucs;

  final invoice = Invoice(
    doc: doc,
    box: box,
    arId: arId,
    products: products,
    customerName: client.client!,
    // customerAddress: client.email!,
    tax: .15,
    baseColor: tipoRomaneio == 'sem_recuperacao' ? PdfColors.red : PdfColors.orange300,
    accentColor: PdfColors.grey300,
    phone: client.contato!,
    quantity: quantity,
    tipoRomaneio: tipoRomaneio,
  );

  return await invoice.buildPdf(pageFormat);
}

class Invoice {
  Invoice({
    required this.phone,
    required this.products,
    required this.box,
    required this.customerName,
    required this.arId,
    required this.doc,
    required this.tax,
    required this.baseColor,
    required this.accentColor,
    required this.quantity,
    this.tipoRomaneio = 'normal',
  });

  final List<EntitySimucsPiclingList> products;
  final String box;
  final String customerName;
  final String quantity;
  final String arId;
  final String doc;
  final String phone;
  final double tax;
  final PdfColor baseColor;
  final PdfColor accentColor;
  final String tipoRomaneio;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => _lightColor;

  PdfColor get _accentTextColor => _darkColor;

  ByteData? _logo;
  Uint8List? bytes;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    final doc = pw.Document();
    _logo = await rootBundle.load('assets/images/logo_kdl.jpg');
    bytes = _logo!.buffer.asUint8List();

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        maxPages: 1000,
        pageTheme: _buildTheme(
          pageFormat.portrait,
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        header: (context) =>
            context.pageNumber > 1 ? pw.Container() : _buildHeader(context),
        footer: _buildFooter,
        build: (context) => [
          _contentTable(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(
        children: [
          if (tipoRomaneio == 'sem_recuperacao')
            pw.Container(
              alignment: pw.Alignment.center,
              margin: const pw.EdgeInsets.only(bottom: 10),
              padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: pw.BoxDecoration(
                color: PdfColors.red,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Text(
                'SEM RECUPERAÇÃO',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
            ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Expanded(
                child: pw.Column(
                  children: [
                    pw.Container(
                      height: 100,
                      child: _logo != null
                          ? pw.Image(
                              pw.MemoryImage(bytes!),
                            )
                          : pw.PdfLogo(),
                    ),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  children: [
                    pw.Text("MANUTENÇÃO",
                        style: const pw.TextStyle(fontSize: 12)),
                    pw.SizedBox(height: 10),
                    pw.Container(
                        width: 70,
                        height: 70,
                        decoration: pw.BoxDecoration(
                            color: tipoRomaneio == 'sem_recuperacao' ? PdfColors.red : PdfColors.orange300,
                            borderRadius: pw.BorderRadius.circular(35)),
                        alignment: pw.Alignment.center,
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text("Caixa",
                                  style: const pw.TextStyle(
                                      fontSize: 10, color: PdfColors.white)),
                              pw.Text(box,
                                  style: const pw.TextStyle(
                                      fontSize: 30, color: PdfColors.white))
                            ])),
                  ],
                ),
              ),
              pw.Expanded(
                flex: 1,
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Container(
                      height: 80,
                      decoration: pw.BoxDecoration(
                        borderRadius:
                            const pw.BorderRadius.all(pw.Radius.circular(2)),
                        color: accentColor,
                      ),
                      padding: const pw.EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 10,
                        right: 10,
                      ),
                      alignment: pw.Alignment.centerLeft,
                      child: pw.DefaultTextStyle(
                        style: pw.TextStyle(
                          color: _accentTextColor,
                          fontSize: 10,
                        ),
                        child: pw.GridView(
                          crossAxisCount: 2,
                          children: [
                            pw.Text('Cliente:'),
                            pw.Text(customerName.toUpperCase()),
                            pw.Text('Data:'),
                            pw.Text(_formatDate(DateTime.now())),
                            pw.Text('AR:'),
                            pw.Text(arId),
                            pw.Text('NF Entrada:'),
                            pw.Text(doc),
                            pw.Text('Quantidade:'),
                            pw.Text(quantity),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        // pw.Container(
        //   height: 20,
        //   width: 100,
        //   child: pw.BarcodeWidget(
        //     barcode: pw.Barcode.pdf417(),
        //     data: 'Invoice# $invoiceNumber',
        //     drawText: false,
        //   ),
        // ),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.white,
          ),
        ),
      ],
    );
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      margin: const pw.EdgeInsets.all(15),
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'Simuc',
      'Defeito Relatado',
      'Insp. Entrada',
      'Defeito Constatado',
      'Materiais',
      'Nível',
      'Obs',
    ];

    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(
        color: PdfColors.black,
        width: 0.5,
      ),
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 10,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
        5: pw.Alignment.center,
        6: pw.Alignment.center,
      },
      columnWidths: {
        0: const pw.FixedColumnWidth(30),
        1: const pw.FixedColumnWidth(50),
        2: const pw.FixedColumnWidth(50),
        3: const pw.FixedColumnWidth(60),
        4: const pw.FixedColumnWidth(60),
        5: const pw.FixedColumnWidth(20),
        6: const pw.FixedColumnWidth(60),
      },
      cellPadding: const pw.EdgeInsets.only(top: 3, bottom: 3),
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 7,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 5,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getValueByIndex(col),
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final format = DateFormat('dd/MM/yyyy', 'pt_BR');
  return format.format(date);
}
