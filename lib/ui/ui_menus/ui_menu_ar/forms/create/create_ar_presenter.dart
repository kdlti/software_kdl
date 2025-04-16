import 'package:flutter/material.dart';

import '../../../../../domain/entities/entities.dart';
import '../../../../../utils/errors/errors.dart';

abstract class CreateArPresenter implements Listenable {
  Stream<UIError?>? get costumerErrorStream;
  Stream<UIError?>? get docEntranceErrorStream;
  Stream<UIError?>? get docTypeErrorStream;
  Stream<UIError?>? get positionErrorStream;
  Stream<UIError?>? get quantityItensErrorStream;
  Stream<UIError?>? get userErrorStream;
  Stream<bool?>? get isFormValidStream;
  Stream<bool> get isLoadingStream;
  Stream<bool> get isLoadingMessageStream;

  List<CostumersEntity> listOfCostumers = [];
  Future<List<String>> loadListCostumers();
  Future<bool> loadListArValidation(BuildContext context);
  void validateQuantityitens(String itens);
  void validatePosition(String position);
  void validateDocEntrance(String doc);
  void validateDocType(String docType);
  void validateUser(String user);
  void validateCostumer(String costumer);
  Future<void> record();
  void dispose();
}
