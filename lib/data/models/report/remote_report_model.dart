import 'package:intl/intl.dart';

import '../../../domain/entities/report/entity_report.dart';


class RemoteReportModel {
  final String numberSerie;
  final String item;
  final String dateRegister;
  final String lastUpdate;
  final String defectRelated;
  final String inspEntrance;
  final String defectFound;
  final String status;
  final String user;
  final String arId;

  const RemoteReportModel({
    required this.numberSerie,
    required this.item,
    required this.dateRegister,
    required this.lastUpdate,
    required this.defectRelated,
    required this.inspEntrance,
    required this.defectFound,
    required this.status,
    required this.user,
    required this.arId,
  });

  factory RemoteReportModel.fromDomain(ReportEntity params) =>
      RemoteReportModel(
        numberSerie: params.numberSerie,
        item: params.item,
        dateRegister: params.dateRegister,
        lastUpdate: params.lastUpdate,
        defectRelated: params.defectRelated,
        inspEntrance: params.inspEntrance,
        defectFound: params.defectFound,
        status: params.status,
        user: params.user,
        arId: params.arId,
      );

  factory RemoteReportModel.fromJson(Map? json) {
    return RemoteReportModel(
      numberSerie: json?['number_serie'] ?? '',
      item: json?['item'] ?? '',
      dateRegister: json?['date_register'] ?? '',
      lastUpdate: json?['last_update'] ?? '',
      defectRelated: json?['defect_related'] ?? '',
      inspEntrance: json?['insp_entrance'] ?? '',
      defectFound: json?['defect_found'] ?? '',
      status: json?['status'] ?? '',
      user: json?['user'] ?? '',
      arId: json?['ar_id'] ?? '',
    );
  }

  ReportEntity toEntity() => ReportEntity(
        numberSerie: numberSerie,
        item: item,
        dateRegister: formatDate(dateRegister),
        lastUpdate: formatDate(lastUpdate),
        defectRelated: defectRelated,
        inspEntrance: inspEntrance,
        defectFound: defectFound,
        status: status,
        user: user,
        arId: arId,
      );

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

  Map toJson() => {
        'number_serie': numberSerie,
        'item': item,
        'date_register': dateRegister,
        'last_update': lastUpdate,
        'defect_related': defectRelated,
        'insp_entrance': inspEntrance,
        'defect_found': defectFound,
        'status': status,
        'user': user,
        'ar_id': arId,
      };
}
