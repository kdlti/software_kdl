import 'package:intl/intl.dart';

import '../../../domain/entities/entities.dart';

class RemoteArModel {
  final String ar;
  final String client;
  final String docType;
  final String docEntrance;
  final String position;
  final String quantityItens;
  final String dateOpen;
  final String lastUpdate;
  final String user;
  final String actualItens;
  final String delivered;
  final String delayDate;

  const RemoteArModel({
    required this.ar,
    required this.client,
    required this.docType,
    required this.docEntrance,
    required this.position,
    required this.quantityItens,
    required this.dateOpen,
    required this.lastUpdate,
    required this.user,
    required this.actualItens,
    required this.delivered,
    required this.delayDate,
  });

  factory RemoteArModel.fromDomain(ArEntityTable params) => RemoteArModel(
        ar: params.ar,
        client: params.client,
        docType: params.docType,
        docEntrance: params.docEntrance,
        position: params.position,
        quantityItens: params.quantityItens,
        dateOpen: params.dateOpen,
        lastUpdate: params.lastUpdate,
        user: params.user,
        actualItens: params.actualItens,
        delivered: params.delivered,
        delayDate: params.delayDate,
      );

  factory RemoteArModel.fromJson(Map? json) {
    return RemoteArModel(
      ar: json?['ar'] ?? '',
      client: json?['client'] ?? '',
      docType: json?['doc_type'] ?? '',
      docEntrance: json?['doc_entrance'] ?? '',
      position: json?['position'] ?? '',
      quantityItens: json?['quantity_itens'] ?? '',
      dateOpen: json?['date_open'] ?? '',
      lastUpdate: json?['last_update'] ?? '',
      user: json?['user'] ?? '',
      actualItens: json?['actual_quantity'] ?? '',
      delivered: json?['delivered'] ?? '',
      delayDate: json?['delay_date'] ?? '',
    );
  }

  ArEntityTable toEntity() => ArEntityTable(
        ar: ar,
        client: client,
        docType: docType,
        docEntrance: docEntrance,
        position: position,
        quantityItens: quantityItens,
        dateOpen: formatDate(dateOpen),
        lastUpdate: formatDate(lastUpdate),
        user: user,
        actualItens: actualItens,
        delivered: delivered,
        delayDate: delayDate,
      );

  Map toJson() => {
        'ar': ar,
        'client': client,
        'doc_type': docType,
        'doc_entrance': docEntrance,
        'position': position,
        'quantity_itens': quantityItens,
        'date_open': dateOpen,
        'last_update': lastUpdate,
        'user': user,
        'actual_quantity': actualItens,
        'delivered': delivered,
        'delay_date': delayDate,
      };

  String formatDate(String? inputDate) {
    if (inputDate == null || inputDate.isEmpty) {
      return '';
    }

    try {
      final inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      final outputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
      final date = inputFormat.parse(inputDate);
      return outputFormat.format(date);
    } catch (e) {
      print('Erro ao formatar a data: $e');
      return '';
    }
  }
}
