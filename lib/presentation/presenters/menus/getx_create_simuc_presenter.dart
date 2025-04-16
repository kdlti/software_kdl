import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../data/models/models.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../domain/entities/entities.dart';
import '../../../ui/ui_menus/ui_menu_item/ui/forms/create/create.dart';
import '../../../utils/validation/presentation/protocols/protocols.dart';
import '../../../utils/errors/errors.dart';
import '../../../utils/validation/validation.dart';
import '../../mixins/mixins.dart';

class GetxCreateSimucPresenter extends GetxController
    with LoadingManager, LoadingManagerMessage
    implements CreateSimucPresenter {
  final String? id;
  final LoadSimucMenu loadSimuc;
  final Validation validation;
  final RecordItem recordItem;

  String? _item = 'SIMUC';
  String? _numberSerie;
  String? _inspEntrance;
  String? _relatedDefect;
  String? _user;
  List<SimucEntityMenus> _listOfSimucValidation = [];
  @override
  XFile? image;
  @override
  CameraController? controller;
  bool _isInList = false;

  final _itemError = Rx<String?>(null);
  final _numberSerieError = Rx<UIError?>(null);
  final _inspEntranceError = Rx<UIError?>(null);
  final _relatedDefectError = Rx<UIError?>(null);
  final _userError = Rx<UIError?>(null);
  final _firstImageError = Rx<Uint8List?>(null);
  final _secondImageError = Rx<Uint8List?>(null);
  final _isCameraInitializedError = Rx<bool?>(null);
  final _isFormValid = false.obs;

  @override
  Stream<String?>? get itemErrorStream => _itemError.stream;
  @override
  Stream<bool?>? get isCameraInitializedStream =>
      _isCameraInitializedError.stream;
  @override
  Stream<UIError?>? get inspEntranceErrorStream => _inspEntranceError.stream;
  @override
  Stream<UIError?>? get numberSerieErrorStream => _numberSerieError.stream;
  @override
  Stream<UIError?>? get relatedDefectErrorStream => _relatedDefectError.stream;
  @override
  Stream<UIError?>? get userErrorStream => _userError.stream;
  @override
  Stream<Uint8List?>? get firstImageErrorStream => _firstImageError.stream;
  @override
  Stream<Uint8List?>? get secondImageErrorStream => _secondImageError.stream;
  @override
  Stream<bool?>? get isFormValidStream => _isFormValid.stream;

  GetxCreateSimucPresenter({
    required this.id,
    required this.validation,
    required this.loadSimuc,
    required this.recordItem,
  });

  @override
  Future<bool> loadListSimucValidation(context) async {
    _listOfSimucValidation = await loadSimuc.loadSimuc().timeout(
      const Duration(seconds: 10),
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

    final teste = _listOfSimucValidation.isNotEmpty;
    if (teste == true) {
      return teste;
    } else {
      return false;
    }
  }

  @override
  void validateItem(String item) {
    _item = item;
  }

  @override
  void validateNumberSerie(String numberSerie) async {
    _numberSerie = numberSerie;
    print("validateNumberSerie numberSerie => $numberSerie");
    _isInList = _listOfSimucValidation
        .any((value) => value.numberSerie == _numberSerie);
    // print("Are in the list => $_isInList");
    _numberSerieError.value = _validateField("Numero de Serie");
    _validateForm();
  }

  @override
  void validateRelatedDefect(String relatedDefect) {
    _relatedDefect = relatedDefect;
    _relatedDefectError.value = _validateField("Defeito Relatado");
    _validateForm();
  }

  @override
  void validateInspEntrance(String inspEntrance) {
    _inspEntrance = inspEntrance;
    _inspEntranceError.value = _validateField("Insp Entrada");
    _validateForm();
  }

  @override
  void validateUser(String user) {
    _user = user;
    _userError.value = _validateField("Usuário");
    _validateForm();
  }

  UIError? _validateField(String field) {
    final formData = {
      'Numero de Serie': _numberSerie,
      'Defeito Relatado': _relatedDefect,
      'Insp Entrada': _inspEntrance,
      'Usuário': _user
    };
    final error =
        validation.validate(field: field, input: formData, isInList: _isInList);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      case ValidationError.numberSerieInUse:
        return UIError.numberSerieInUse;
      case ValidationError.smallerThan:
        return UIError.smallerThan;
      default:
        return null;
    }
  }

  @override
  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(
      cameras[0],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    await controller?.initialize();
    _isCameraInitializedError.value = true;
  }

  @override
  Future<void> captureImage(cam) async {
    try {
      image = await controller?.takePicture();

      if (image != null && cam == "1") {
        final convertImageBytes = await image!.readAsBytes();
        _firstImageError.value = convertImageBytes;
      }

      if (image != null && cam == "2") {
        final convertImageBytes = await image!.readAsBytes();
        _secondImageError.value = convertImageBytes;
      }

      _validateForm();
    } catch (e) {
      // ignore: avoid_print
      print('Error capturing image: $e');
    }
    _validateForm();
  }

  @override
  void deleteImage(numberImage) {
    if (numberImage == "1") {
      _firstImageError.value = null;
    } else {
      _secondImageError.value = null;
    }
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _numberSerieError.value == null &&
        _numberSerie != null &&
        _relatedDefectError.value == null &&
        _relatedDefect != null &&
        _inspEntranceError.value == null &&
        _inspEntrance != null &&
        _userError.value == null &&
        _user != null && 
        _firstImageError.value != null;
  }

  @override
  Future<void> record() async {
    String? imageB = _secondImageError.value != null
        ? base64Encode(_secondImageError.value!)
        : "";
    isLoading = true;
    var packageData = RemoteSimucModelMenu(
      numberSerie: _numberSerie!,
      item: _item!,
      dateRegister: DateTime.now().toString(),
      defectRelated: _relatedDefect!,
      inspEntrance: _inspEntrance!,
      defectFound: "",
      status: "0",
      user: _user!,
      arId: id!,
      imageA: base64Encode(_firstImageError.value!),
      imageB: imageB,
    ).toEntity();
    await recordItem.recordItem(packageData);
    Future.delayed(const Duration(seconds: 2), () {
      isLoading = false;
    });
   
    update();
  }

  @override
  void receiveDataFromTable() {
    // ignore: avoid_print
    print("Dados Recebidos");
  }
  

}
