import 'package:equatable/equatable.dart';

abstract class RecordAr {
  Future<bool> recordAr(AddArParams params);
}

class AddArParams extends Equatable {
  final String client;
  final String docType;
  final String docEntrance;
  final String position;
  final String quantityItens;
  final String dateOpen;
  final String user;

  @override
  List get props => [client, docType, docEntrance, position, quantityItens, dateOpen, user];

  const AddArParams({
    required this.client,
    required this.docType,
    required this.docEntrance,
    required this.position,
    required this.quantityItens,
    required this.dateOpen,
    required this.user,
  });
}
