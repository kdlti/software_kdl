import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart' as ex;
import 'dart:html' as html;
// import 'package:websocket_service_package/export.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../infra/infra.dart';
import '../../../utils/style_excel.dart';

class GetxArPresenter extends GetxController {
  final EditAr editAr;
  final LoadAr load;
  final LoadPdf loadPdf;
  final LoadSimuc loadSimuc;
  final WebSocketService websocket = WebSocketService();
  final ReportUsecase loadReport;

  GetxArPresenter({
    required this.loadPdf,
    required this.load,
    required this.loadSimuc,
    required this.editAr,
    required this.loadReport,
  });

  int total = 100;
  String? sortColumn;
  int currentPage = 1;
  List<bool>? expanded;
  bool isLoading = true;
  bool showSelect = true;
  String? searchKey = "ar";
  int? currentPerPage = 100;
  bool sortAscending = true;
  bool isExpandRows = true;
  String selectableKey = "id";
  List<int> perPages = [100, 200, 500, 1000];
  List<ArEntityTable> source = [];
  List<ArEntityTable> sourcelate = [];
  List<ArEntityTable> selecteds = [];
  List<ArEntityTable> sourceOriginal = [];
  List<ArEntityTable> sourceFiltered = [];
  bool isSearch = false;
  Map<String, int> arSimucCount = {};
  int countTotal = 0;
  String docEntrance = "";

  final RxList<PdfEntity> _sourcePdfs = <PdfEntity>[].obs;
  List<PdfEntity> get sourcePdfs => _sourcePdfs;

  final RxList<PdfEntity> _listPdf = <PdfEntity>[].obs;
  Stream<List<PdfEntity>> get listPdf => _listPdf.stream;

  bool isMenuVisible = false;

  List<List<dynamic>> createHeader2() {
    return [
      [
        'NÚMERO DE SÉRIE',
        'ITEM',
        'DATA CADASTRO',
        'ÚLTIMA ATUALIZAÇÃO',
        'DEFEITO RELATADO',
        'INSPEÇÃO DE ENTRADA',
        'STATUS',
        'USUÁRIO',
        'AR',
      ]
    ];
  }

  initializeData() async {
    mockPullData();
    update();
  }

  // void fetchLoadReport(Map<String, dynamic> body) async {
  //   List<ReportEntity> teste = await loadReport.loadData(body);
  //   print(teste);
  // }

  generateAndDownloadExcel(Map<String, dynamic> body) async {
    List<ReportEntity> teste = await loadReport.loadData(body);
    final date = DateTime.now();

    List<List<dynamic>> extractData(List entity, List<int> indices) {
      return entity.map((map) {
        return indices.map((index) => map.props[index]).toList();
      }).toList();
    }

    List<List<dynamic>> header2 = createHeader2();
    List<List<dynamic>> data = extractData(teste, [0, 1, 2, 3, 4, 5, 7, 8, 9]);

    List<List<dynamic>> rows = [...header2, ...data];

    void generateExcel(List<List<dynamic>> dataRows, DateTime date) {
      var excel = ex.Excel.createExcel();
      ex.Sheet sheetObject = excel['Sheet1'];

      void appendRows(List<List<dynamic>> rows) {
        for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) {
          var row = rows[rowIndex]
              .map((value) => ex.TextCellValue(value.toString()))
              .toList();
          sheetObject.appendRow(row);
          for (var colIndex = 0; colIndex < row.length; colIndex++) {
            var cell = sheetObject.cell(ex.CellIndex.indexByColumnRow(
                columnIndex: colIndex, rowIndex: rowIndex));
            cell.cellStyle = headerStyle;
          }
        }
      }

      sheetObject.appendRow([]);
      appendRows(dataRows);

      var fileBytes = excel.encode();
      final blob = html.Blob([fileBytes],
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'Simuc_$date.xlsx')
        ..click();

      html.Url.revokeObjectUrl(url);
    }

    generateExcel(rows, date);
  }

  Future<List<ArEntityTable>> fetch() async {
    final source = await load.loadAr();
    return source;
  }

  DateTime _parseDate(String dateStr) {
    final format = DateFormat('dd-MM-yyyy HH:mm:ss');
    return format.parse(dateStr);
  }

  mockPullData() async {
    expanded = List.generate(currentPerPage!, (index) => false);
    isLoading = true;
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      sourceOriginal.clear();
      sourceOriginal.addAll(await fetch());
      sourceOriginal.sort(
        (a, b) => _parseDate(b.dateOpen).compareTo(
          _parseDate(a.dateOpen),
        ),
      );
      sourceFiltered = sourceOriginal;
      sourcelate = sourceFiltered
          .where((element) => element.delayDate.isNotEmpty)
          .toList();
      total = sourceFiltered.length;
      int endRange = total < currentPerPage! ? total : currentPerPage!;
      source = sourceFiltered.getRange(0, endRange).toList();
      isLoading = false;
      update();
    });

    // update();
  }

  resetData({start = 0}) {
    isLoading = true;
    var expandedLen =
        total - start < currentPerPage! ? total - start : currentPerPage;
    Future.delayed(const Duration(seconds: 0)).then((value) {
      expanded = List.generate(expandedLen as int, (index) => false);
      source.clear();
      source = sourceFiltered.getRange(start, start + expandedLen).toList();
      isLoading = false;
      update();
    });
    update();
  }

  filterData(value) async {
    isLoading = true;
    sourceOriginal = await load.loadAr();
    try {
      if (value == "" || value == null) {
        sourceFiltered = sourceOriginal;
      } else {
        sourceFiltered = sourceOriginal
            .where((data) => data
                .getProperty(searchKey!)
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
            .toList();
      }

      total = sourceFiltered.length;
      var rangeTop = total < currentPerPage! ? total : currentPerPage!;
      expanded = List.generate(rangeTop, (index) => false);
      source = sourceFiltered.getRange(0, rangeTop).toList();
      update();
    } catch (e) {
      print(e);
    }
    isLoading = false;
    update();
  }

  onSort(value) {
    isLoading = true;

    sortColumn = value;
    sortAscending = !sortAscending;
    if (sortAscending) {
      sourceFiltered.sort((a, b) {
        return a.getProperty(sortColumn!).compareTo(b.getProperty(sortColumn!));
      });
    } else {
      sourceFiltered.sort((a, b) =>
          b.getProperty(sortColumn!).compareTo(a.getProperty(sortColumn!)));
    }

    var rangeTop = currentPerPage! < sourceFiltered.length
        ? currentPerPage!
        : sourceFiltered.length;
    source = sourceFiltered.getRange(0, rangeTop).toList();

    searchKey = value;

    isLoading = false;
    update();
  }

  onSelect(value, item) {
    if (value!) {
      selecteds.add(item);
    } else {
      selecteds.removeAt(selecteds.indexOf(item));
    }
    update();
  }

  printPosition() {
    for (var teste1 in selecteds) {
      editAr.editAr(teste1);
    }
    selecteds.clear();
  }

  onSelectAll(value) {
    if (value!) {
      selecteds = source.map((entry) => entry).toList().cast();
    } else {
      selecteds.clear();
    }
    update();
  }

  void backPage(presenter) {
    var _nextSet = currentPage - currentPerPage!;
    currentPage = _nextSet > 1 ? _nextSet : 1;
    resetData(start: currentPage - 1);
    update();
  }

  void nextPage(presenter) {
    if (currentPage + currentPerPage! - 1 <= total) {
      var _nextSet = currentPage + currentPerPage!;
      currentPage = _nextSet < total ? _nextSet : total - currentPerPage!;
      resetData(start: _nextSet - 1);
      update();
    } else {
      return;
    }
    update();
  }

  Future<void> loadPdfs(String ar) async {
    final completer = Completer<void>();

    try {
      final loadedPdfs = await loadPdf.loadPdf(ar);
      _sourcePdfs.assignAll(loadedPdfs);
      _listPdf.assignAll(_sourcePdfs);
      completer.complete();
    } catch (e) {
      completer.completeError(e);
      print("Erro ao carregar PDFs: $e");
    }

    return completer.future;
  }

  void clearPdfs() {
    _listPdf.clear();
  }

  String verifyNameOfSearchBar(String value) {
    switch (value) {
      case 'ar':
        return 'AR';
      case 'client':
        return 'Cliente';
      case 'doc type':
        return 'Tipo de Documento';
      case 'doc entrance':
        return 'Documento de Entrada';
      case 'position':
        return 'Posição';
      case 'quantity itens':
        return 'Quantidade de Itens';
      case 'date open':
        return 'Date de Abertura';
      case 'last update':
        return 'Última Atualização';
      case 'user':
        return 'Usuário';
    }
    return value;
  }
}
