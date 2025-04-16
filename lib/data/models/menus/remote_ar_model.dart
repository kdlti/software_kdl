

import 'package:teste_git_hub/domain/entities/entities.dart';

class RemoteArModelMenu {
  final String client;
  final String docType;
  final String docEntrance;
  final String position;
  final String quantityItens;
  final String dateOpen;
  final String user;

  const RemoteArModelMenu({
    required this.client,
    required this.docType,
    required this.docEntrance,
    required this.position,
    required this.quantityItens,
    required this.dateOpen,
    required this.user,
  });

  factory RemoteArModelMenu.fromJson(Map? json) {
    return RemoteArModelMenu(
        client: json?['client'] ?? '',
        docType: json?['doc_type'] ?? '',
        docEntrance: json?['doc_entrance'] ?? '',
        position: json?['position'] ?? '',
        quantityItens: json?['quantity_itens'] ?? '',
        dateOpen: json?['date_open'] ?? '',
        user: json?['user'] ?? '');
  }

  ArEntityMenus toEntity() => ArEntityMenus(
        client: client,
        docType: docType,
        docEntrace: docEntrance,
        position: position,
        quantityItens: quantityItens,
        dateOpen: dateOpen,
        user: user,
      );
}
