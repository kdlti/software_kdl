import 'package:equatable/equatable.dart';

class ArEntityMenus extends Equatable {
  final String client;
  final String docEntrace;
  final String docType;
  final String position;
  final String quantityItens;
  final String dateOpen;
  final String user;

  @override
  List get props => [client, docEntrace, docType, position, quantityItens, dateOpen, user];

  const ArEntityMenus({
    required this.client,
    required this.docEntrace,
    required this.docType,
    required this.position,
    required this.quantityItens,
    required this.dateOpen,
    required this.user,
  });
}
