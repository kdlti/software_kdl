import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_git_hub/domain/entities/entities.dart';
import 'package:teste_git_hub/domain/usecases/usecases.dart';
import '../../../domain/usecases/costumer/load_costumers.dart';
import '../../../infra/infra.dart';
import '../../../utils/validation/presentation/protocols/protocols.dart';
import '../../../utils/errors/errors.dart';
import '../../../ui/ui_menus/ui_menu_ar/forms/create/create.dart';
import '../../../utils/validation/validation.dart';
import '../../mixins/mixins.dart';

class GetxCreatePresenter extends GetxController
    with LoadingManager, LoadingManagerMessage
    implements CreateArPresenter {
  final LoadCostumers loadCostumers;
  final LoadArMenu loadAr;
  final RecordAr recordAr;
  final Validation validation;
  final WebSocketService websocket = WebSocketService();

  String? _costumer = 'Erro';
  String? _docEntrance;
  String? _docType;
  String? _position;
  String? _quantityItens;
  String? _user;
  bool _isInList = false;
  List<ArEntityMenus> _listOfArValidation = [];
  @override
  List<CostumersEntity> listOfCostumers = [];
  bool? active;

  final _costumerError = Rx<UIError?>(null);
  final _docEntranceError = Rx<UIError?>(null);
  final _docTypeError = Rx<UIError?>(null);
  final _positionError = Rx<UIError?>(null);
  final _quantityItensError = Rx<UIError?>(null);
  final _userError = Rx<UIError?>(null);
  final _isFormValid = false.obs;

  @override
  Stream<UIError?>? get costumerErrorStream => _costumerError.stream;

  @override
  Stream<UIError?>? get docEntranceErrorStream => _docEntranceError.stream;

  @override
  Stream<UIError?>? get docTypeErrorStream => _docTypeError.stream;

  @override
  Stream<UIError?>? get positionErrorStream => _positionError.stream;

  @override
  Stream<UIError?>? get quantityItensErrorStream => _quantityItensError.stream;

  @override
  Stream<UIError?>? get userErrorStream => _userError.stream;

  @override
  Stream<bool?>? get isFormValidStream => _isFormValid.stream;

  GetxCreatePresenter({
    required this.loadAr,
    required this.recordAr,
    required this.loadCostumers,
    required this.validation,
  });

  @override
  Future<List<String>> loadListCostumers() async {
    listOfCostumers = await loadCostumers.loadCostumers();
    List<String> costumers = [];
    for (var costumer in listOfCostumers) {
      costumers.add(costumer.costumer);
    }
    return costumers;
  }

  @override
  Future<bool> loadListArValidation(context) async {
    _listOfArValidation = await loadAr.loadAr().timeout(
      const Duration(seconds: 2),
      onTimeout: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content:
                Text("Erro: Tempo de resposta da API excedido! Contatar TI."),
            duration: Duration(seconds: 10),
          ),
        );
        throw TimeoutException("Tempo de resposta excedido");
      },
    );
    final teste = _listOfArValidation.isNotEmpty;
    if (teste == true) {
      return teste;
    } else {
      print("Erro de API");
      return false;
    }
  }

  @override
  void validateCostumer(String costumer) {
    _costumer = costumer;
    _costumerError.value = _validateField("Cliente");
    if (_costumer != 'Selecione um Cliente') {
      _validateForm();
    } else {
      _costumer = 'Erro';
      _validateForm();
    }
  }

  @override
  void validateDocType(String docType) {
    _docType = docType;
    _docTypeError.value = _validateField("Tipo de Documento");
    if (_docType != 'Tipo de Documento') {
      _validateForm();
    } else {
      _docType = 'Erro';
      _validateForm();
    }
  }

  @override
  void validateDocEntrance(String doc) async {
    _docEntrance = doc;
    if (_docEntrance != "S/D") {
      _isInList =
          _listOfArValidation.any((value) => value.docEntrace == _docEntrance);
    }
    _docEntranceError.value = _validateField("Doc. Entrada");
    _validateForm();
  }

  @override
  void validatePosition(String position) async {
    _position = position.toUpperCase();
    _isInList = _listOfArValidation.any((value) => value.position == _position);
    _positionError.value = _validateField("Posicao");
    _validateForm();
  }

  @override
  void validateQuantityitens(String itens) {
    _quantityItens = itens;
    _quantityItensError.value = _validateField('Qtd. Total Itens');
    _validateForm();
  }

  @override
  void validateUser(String user) {
    _user = user;
    _userError.value = _validateField('Usuário');
    _validateForm();
  }

  UIError? _validateField(String field) {
    final formData = {
      'Cliente': _costumer,
      'Tipo de Documento': _docType,
      'Doc. Entrada': _docEntrance,
      'Posicao': _position,
      'Qtd. Total Itens': _quantityItens,
      'Usuário': _user
    };
    final error =
        validation.validate(field: field, input: formData, isInList: _isInList);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      case ValidationError.positionInUse:
        return UIError.positionInUse;
      case ValidationError.docInUse:
        return UIError.docInUse;
      case ValidationError.noDoc:
        return UIError.noDoc;
      default:
        return null;
    }
  }

  void _validateForm() {
    _isFormValid.value = _costumerError.value == null &&
        _costumer != 'Erro' &&
        _docTypeError.value == null &&
        _docType != null &&
        _docEntranceError.value == null &&
        _docEntrance != null &&
        _positionError.value == null &&
        _position != null &&
        _quantityItensError.value == null &&
        _quantityItens != null &&
        _userError.value == null &&
        _user != null &&
        _listOfArValidation.isNotEmpty;
  }

  @override
  Future<void> record() async {
    isLoading = true;
    var packageData = AddArParams(
      client: _costumer!,
      docType: _docType!,
      docEntrance: _docEntrance!,
      position: _position!.toUpperCase(),
      quantityItens: _quantityItens!.toString(),
      dateOpen: DateTime.now().toString(),
      user: _user!,
    );
    // print(packageData);
    final returnRecord = await recordAr.recordAr(packageData);
    Future.delayed(const Duration(seconds: 1), () async {
      isLoading = false;
    });

    if (returnRecord == true) {
      Future.delayed(const Duration(seconds: 2), () async {
        _listOfArValidation = await loadAr.loadAr();
        validateDocEntrance("");
        validatePosition("");
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
