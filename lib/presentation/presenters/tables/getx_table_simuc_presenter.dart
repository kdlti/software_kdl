import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart' as ex;
import 'dart:html' as html;
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../infra/infra.dart';
import '../../../main/factories/http/http.dart';
import '../../../utils/dialogs_message.dart';
import '../../../utils/style_excel.dart';

class GetxTableSimucPresenter extends GetxController {
  final LoadSimuc load;
  final SendSimuc send;
  final LoadDefects defects;
  final DeleteSimuc deleteSimuc;
  final WebSocketService webSocketService = WebSocketService();

  GetxTableSimucPresenter(this.load, this.send, this.defects, this.deleteSimuc);

  int total = 100;
  String? sortColumn;
  int currentPage = 1;
  List<bool>? expanded;
  bool isLoading = true;
  bool showSelect = true;
  String? searchKey = "number_serie";
  int? currentPerPage = 100;
  bool sortAscending = true;
  bool isExpandRows = true;
  String selectableKey = "id";
  List<int> perPages = [100, 300, 500, 1000];
  String takeDocEntrance = "";
  List<SimucEntityTables> source = [];
  List<SimucEntityTables> selecteds = [];
  List<SimucEntityTables> sourceOriginal = [];
  List<SimucEntityTables> sourceFiltered = [];
  bool isSearch = false;
  List<SimucEntityTables> status0 = [];
  List<SimucEntityTables> status2 = [];
  List<SimucEntityTables> status1 = [];
  List<SimucEntityTables> status4 = [];
  List<EntityDefects> allDefects = [];
  List<EntityDefects> selectedDefects = [];

  List<SimucEntityTables> filterpiece = [];
  String? previousSearchValue;

  String? observation = "";
  String stockId = "";
  final RxBool isLoadingButton = RxBool(false);

  Future<List<EntityDefects>> fetchDefects() async {
    allDefects = await defects.loadDefects();
    return allDefects;
  }

  List<List<dynamic>> createHeader2() {
    return [
      [
        'NÚMERO DE SERIE',
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

  generateAndDownloadExcel() {
    final date = DateTime.now();

    List<List<dynamic>> extractData(List entity, List<int> indices) {
      return entity.map((map) {
        return indices.map((index) => map.props[index]).toList();
      }).toList();
    }

    List<List<dynamic>> header2 = createHeader2();
    List<List<dynamic>> data = extractData(sourceOriginal, [1, 2, 3, 4, 5, 6, 8, 9, 10]);

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

  initializeData(String id, {String? button}) {
    fetchDefects();
    mockPullData(id, button: button);
    update();
  }

  void separetStatus(List<SimucEntityTables> source) {
    for (var rows in source) {
      if (rows.status == "0") {
        status0.add(rows);
      } else if (rows.status == "2") {
        status2.add(rows);
      } else if (rows.status == "1") {
        status1.add(rows);
      } else {
        status4.add(rows);
      }
    }
  }

  Future<List<SimucEntityTables>> fetch(String id) async {
    status0.clear();
    status2.clear();
    status1.clear();
    status4.clear();
    source.clear();
    source = await load.loadSimuc(id);
    separetStatus(source);
    return source;
  }

  DateTime _parseDate(String dateStr) {
    final format = DateFormat('dd-MM-yyyy HH:mm:ss');
    return format.parse(dateStr);
  }

  mockPullData(String id, {String? button}) async {
    expanded = List.generate(currentPerPage!, (index) => false);

    isLoading = true;
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      sourceOriginal.clear();
      sourceOriginal.addAll(await fetch(id));
      sourceOriginal.sort((a, b) =>
          _parseDate(b.dateRegister).compareTo(_parseDate(a.dateRegister)));
      sourceFiltered = List.from(sourceOriginal);

      if (previousSearchValue != null && button == null) {
        sourceFiltered = sourceFiltered
            .where((data) => data
                .getProperty(searchKey!)
                .toString()
                .toLowerCase()
                .contains(previousSearchValue!.toLowerCase()))
            .toList();
      }

      total = sourceFiltered.length;
      int endRange = total < currentPerPage! ? total : currentPerPage!;
      expanded = List.generate(endRange, (index) => false);

      if (sourceFiltered.isNotEmpty) {
        source = sourceFiltered.getRange(0, endRange).toList();
      } else {
        source = [];
      }

      isLoading = false;
      update();
    });
    update();
  }

  resetData({start = 0}) async {
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

  filterData(value) {
    isLoading = true;
    try {
      if (value == "" || value == null) {
        clearFilter();
      } else {
        previousSearchValue = value;
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

      if (sourceFiltered.isNotEmpty) {
        source = sourceFiltered.getRange(0, rangeTop).toList();
      } else {
        source = [];
      }

      filterpiece = source;
    } catch (e) {
      print(e);
    }
    isLoading = false;
    update();
  }

  void clearFilter() {
    isLoading = true;
    try {
      sourceFiltered = List.from(sourceOriginal);
      total = sourceFiltered.length;
      int endRange = total < currentPerPage! ? total : currentPerPage!;
      expanded = List.generate(endRange, (index) => false);

      if (sourceFiltered.isNotEmpty) {
        source = sourceFiltered.getRange(0, endRange).toList();
      } else {
        source = [];
      }

      filterpiece = source;
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
      sourceFiltered.sort((a, b) =>
          b.getProperty(sortColumn!).compareTo(a.getProperty(sortColumn!)));
    } else {
      sourceFiltered.sort((a, b) =>
          a.getProperty(sortColumn!).compareTo(b.getProperty(sortColumn!)));
    }
    var rangeTop = currentPerPage! < sourceFiltered.length
        ? currentPerPage!
        : sourceFiltered.length;
    source = sourceFiltered.getRange(0, rangeTop).toList();
    searchKey = value;

    isLoading = false;
    update();
  }

  onSelect(value, item) async {
    if (item.status == "4") return;
    
    if (value!) {
      selecteds.add(item);
      WebSocketService().sendItemToEdit(item);
    } else {
      selecteds.removeAt(selecteds.indexOf(item));
    }
    update();
  }

  onSelectAll(value, {bool excludeStatus4 = false}) {
    if (value!) {
      if (excludeStatus4) {
        selecteds = source.where((entry) => entry.status != "4").toList().cast();
      } else {
        selecteds = source.map((entry) => entry).toList().cast();
      }
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

  saveDefects(String arId, String id, BuildContext context) async {
    isLoadingButton.value = true;
    await Future.delayed(const Duration(seconds: 1));
    try {
      List<String?> ids = [];
      for (var takeIdsDefects in selectedDefects) {
        ids.add(takeIdsDefects.id);
      }
      var packageData = DefectsRecordEntity(
          arId: arId, itemId: id, defectsId: ids, obs: observation);
      isLoadingButton.value = false;
      // print(packageData);
      await defects.recordDefects(packageData);
      DialogsNotifier().showConfirmationMessage(context);
    } catch (e) {
      DialogsNotifier().showErrorMessage(context, e.toString());
    }
  }

  String verifyNameOfSearchBarSimuc(String value) {
    switch (value) {
      case 'number serie':
        return 'Numero de Serie';
      case 'item':
        return 'Item';
      case 'date register':
        return 'Data de Cadastro';
      case 'last update':
        return 'Última Atualização';
      case 'defect related':
        return 'Defeito Relatado';
      case 'insp entrance':
        return 'Inspeção de Entrada';
      case 'status':
        return 'status';
      case 'user':
        return 'Usuário';
    }
    return value;
  }

  Future<void> deleteSimucFunction() async {
    final ids = selecteds.map((e) => EntityId(id: e.id)).toList();
    await deleteSimuc.deleteSimuc(ids);
    selecteds.clear();
    update();
  }
}
