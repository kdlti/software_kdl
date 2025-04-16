import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart' as ex;
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../data/models/picking_list/model_picking_list.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/costumer/load_costumers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../infra/infra.dart';
import '../../../main/factories/http/http.dart';
import '../../../ui/picking_list/ui/errors/errors.dart';
import '../../../ui/picking_list/ui/input_controllers.dart';
import '../../../ui/picking_list/ui/page_presenter.dart';
import 'dart:html' as html;

import '../../../utils/header_data.dart';
import '../../../utils/style_excel.dart';
import '../../../ui/picking_list/validation/presentation/protocols/protocols.dart';

class GetxPagePresenter extends GetxController implements PagePresenter {
  final String doc;
  final String arId;
  final String client;
  final LoadSimucs load;
  final LoadCostumers loadCostumers;
  final Validation validation;
  final WebSocketService webSocketService = WebSocketService();
  GetxPagePresenter({
    required this.loadCostumers,
    required this.doc,
    required this.load,
    required this.arId,
    required this.validation,
    required this.client,
  });

  final _selectClientError = Rx<UIError?>(null);

  final _bytesPackingList = Rx<Uint8List?>(null);
  @override
  final quantity = RxInt(0);
  @override
  final simucEntity = RxList<EntitySimucsPiclingList>([]);
  @override
  Stream<List<EntitySimucsPiclingList>> get simucEntityStream =>
      simucEntity.stream;
  @override
  Stream<int> get quantityStream => quantity.stream;
  List<EntitySimucsPiclingList?> listSimucs = [];
  List<CostumersEntity> listCostumers = [];
  final _isFormValid = false.obs;
  @override
  Stream<bool?>? get isFormValidStream => _isFormValid.stream;
  @override
  Stream<UIError?>? get selectClientErrorStream => _selectClientError.stream;
  @override
  String get receiveArId => arId;
  @override
  String get receiveArDoc => doc;
  @override
  String get receiveClient => client;
  @override
  String get quantityInvoice => _quantityInvoice;
  @override
  Stream<Uint8List?>? get bytesPackingList => _bytesPackingList.stream;
  @override
  String get tipoRomaneio => _tipoRomaneio;

  List<Map<dynamic, dynamic>> listRemoteSimucModel = [];
  @override
  final FocusNode focusNode = FocusNode();

  String? _selectedClient;
  String _box = "";
  String _quantityInvoice = "";
  String _tipoRomaneio = 'normal';

  @override
  String get box => _box;

  @override
  var costumer = const ClientAddressEntity();

  @override
  initializeData(context) async {
    listSimucs = await load.loadSimucs(arId, context);
    _selectedClient = receiveClient;
    _takeClient(_selectedClient);
  }

  _takeClient(String? selectedClient) async {
    listCostumers = await loadCostumers.loadCostumers();
    for (var costumers in listCostumers) {
      if (costumers.costumer == selectedClient) {
        costumer = ClientAddressEntity(
          client: costumers.costumer,
          address: costumers.address,
          email: costumers.email,
          contato: costumers.number,
        );
      }
    }
  }

  @override
  void setTipoRomaneio(String tipo) {
    _tipoRomaneio = tipo;
    print(_tipoRomaneio);
  }

  @override
  void inputBox(String index) {
    _box = index;

    _validateForm();
  }

  @override
  void getNserlum(value, context) async {
    listSimucs = await load.loadSimucs(arId, context);
    
    // Verifica se o romaneio é normal (com limite) ou sem_recuperação (sem limite)
    bool temLimite = _tipoRomaneio == 'normal';
    if (!temLimite || simucEntity.length <= 39) {
      var existOnList = listSimucs.any((simuc) => simuc!.numberSerie == value);
      if (simucEntity.any((element) => element.numberSerie == value)) {
        _showAlertDialog(context, "Erro", "O Simuc já existe na lista!");
        inputNserlum.text = "";
        focusNode.requestFocus();
      } else if (existOnList == false) {
        _showAlertDialog(context, "Erro",
            "Simuc não encontrado, pode ter sido enviado! Verifique o Status, ou se foi cadastrado!");
      } else if (existOnList) {
        var entity =
            listSimucs.firstWhere((element) => element!.numberSerie == value);
        simucEntity.add(entity!);
        quantity.value = simucEntity.length;
        _quantityInvoice = simucEntity.length.toString();
        inputNserlum.text = "";
        focusNode.requestFocus();
        _validateForm();
      }
    } else {
      _showAlertDialog(
          // ignore: use_build_context_synchronously
          context,
          "Erro",
          "A Quantidade limite por caixa foi atingida");
    }
  }

  @override
  void removerDado(int index) {
    simucEntity.removeAt(index);
    quantity.value = simucEntity.length;
    _validateForm();
  }

  @override
  void cleanList() {
    simucEntity.clear();
    quantity.value = simucEntity.length;
    inputBoxText.text = "";
    _validateForm();
  }

  @override
  savePackingList() async {
    try {
      var bytes = base64Encode(_bytesPackingList.value!);
      for (EntitySimucsPiclingList list in simucEntity) {
        listRemoteSimucModel.add(ModelPickingList(
          id: list.id!,
          arid: arId,
          box: box,
          numberSerie: list.numberSerie,
          defectRelated: list.defectRelated,
          inspEntrance: list.inspEntrance,
          defectConst: list.defectConst,
          componentsConst: list.componentsConst,
          nivel: list.nivel,
          obsConst: list.obsConst,
        ).toJson());
      }
      print(listRemoteSimucModel);
      
      // Desconectar qualquer conexão existente para começar do zero
      webSocketService.disconnect();
      
      // Tentativas de reconexão
      int maxAttempts = 3;
      
      // Usar um timeout geral para toda a operação
      return await Future.any([
        // Operação normal
        _executeSaveOperation(maxAttempts, bytes),
        
        // Timeout após 30 segundos
        Future.delayed(const Duration(seconds: 30)).then((_) {
          print('Timeout ao salvar romaneio após 30 segundos');
          throw Exception('Timeout ao salvar romaneio. A operação demorou muito tempo.');
        }),
      ]);
    } catch (e) {
      print('Erro ao salvar picking list: $e');
      // Aqui você pode implementar um tratamento de erro adequado
      rethrow; // Rethrow para que o erro seja capturado na UI
    }
  }
  
  // Método auxiliar para encapsular a operação de salvar
  Future<void> _executeSaveOperation(int maxAttempts, String bytes) async {
    bool connected = false;
      
    for (int attempt = 1; attempt <= maxAttempts && !connected; attempt++) {
      print('Tentativa de conexão $attempt de $maxAttempts para o romaneio');
      
      try {
        // Conectar ao WebSocket
        await webSocketService.connect("ws2");
        
        // Aguardar um período maior para garantir que a conexão seja estabelecida
        await Future.delayed(const Duration(seconds: 2));
        
        // Verificar se a conexão está ativa
        if (webSocketService.isConnected) {
          print('Conexão WebSocket estabelecida com sucesso');
          connected = true;
        } else {
          print('Falha na conexão. Aguardando para tentar novamente...');
          await Future.delayed(const Duration(seconds: 1));
        }
      } catch (e) {
        print('Erro ao tentar conectar: $e');
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    
    if (!connected) {
      print('Falha ao estabelecer conexão WebSocket após $maxAttempts tentativas');
      throw Exception('Não foi possível estabelecer conexão WebSocket');
    }
    
    // A conexão foi estabelecida com sucesso, agora vamos enviar a mensagem
    print('Enviando dados do romaneio...');
    webSocketService.sendMessagePickingList(
        "save_picking_list", listRemoteSimucModel, bytes);
        
    // Aguardar um momento para garantir que a mensagem foi enviada
    await Future.delayed(const Duration(seconds: 1));
    
    print('Romaneio enviado com sucesso');
    // Limpar a lista para evitar duplicação
    listRemoteSimucModel.clear();
  }

  void _validateForm() {
    _isFormValid.value = simucEntity.isNotEmpty &&
        _selectClientError.value == null &&
        _box.isNotEmpty;
  }

  @override
  void generateAndDownloadExcel() {
    final date = DateTime.now();

    List<List<dynamic>> extractData(List entity, List<int> indices) {
      return entity.map((map) {
        return indices.map((index) => map.props[index]).toList();
      }).toList();
    }

    List<List<dynamic>> header2 = createHeader2();
    List<List<dynamic>> data = extractData(simucEntity, [1, 4, 5, 6]);

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

  @override
  printBytes(bytes) {
    _bytesPackingList.value = bytes;
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
