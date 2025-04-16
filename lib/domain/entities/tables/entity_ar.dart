import 'package:equatable/equatable.dart';

class ArEntityTable extends Equatable {
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

  @override
  List get props => [
        ar,
        client,
        docType,
        docEntrance,
        position,
        quantityItens,
        dateOpen,
        lastUpdate,
        user,
        actualItens,
        delivered,
        delayDate
      ];

  const ArEntityTable({
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

  factory ArEntityTable.fromJson(Map? json) {
    return ArEntityTable(
      ar: json?['ar'] ?? '',
      client: json?['client'] ?? '',
      docType: json?['doc_type'] ?? '',
      docEntrance: json?['doc_entrance'] ?? '',
      position: json?['position'] ?? '',
      quantityItens: json?['quantity_itens'] ?? '',
      dateOpen: json?['date_open'] ?? '',
      lastUpdate: json?['last_update'] ?? '',
      user: json?['user'] ?? '',
      actualItens: json?['actual_itens'] ?? '',
      delivered: json?['delivered'] ?? '',
      delayDate: json?['delay_date'] ?? '',
    );
  }

  dynamic getProperty(String key) {
    switch (key) {
      case 'ar':
        return ar;
      case 'client':
        return client;
      case 'doc_type':
        return docType;
      case 'doc_entrance':
        return docEntrance;
      case 'position':
        return position;
      case 'quantity_itens':
        return quantityItens;
      case 'date_open':
        return dateOpen;
      case 'last_update':
        return lastUpdate;
      case 'user':
        return user;
      case 'delivered':
        return delivered;
      case 'delay_date':
        return delayDate;
      default:
        throw ArgumentError('Invalid property key');
    }
  }
}
