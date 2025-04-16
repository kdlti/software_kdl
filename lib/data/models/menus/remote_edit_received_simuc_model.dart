import '../../../../../../domain/entities/entities.dart';

class RemoteEditReceivedSimucModel {
  final String id;
  final String numberSerie;
  final String item;
  final String dateRegister;
  final String defectRelated;
  final String inspEntrance;
  final String defectFound;
  final String status;
  final String user;
  final String arId;

  const RemoteEditReceivedSimucModel({
    required this.id,
    required this.numberSerie,
    required this.item,
    required this.dateRegister,
    required this.defectRelated,
    required this.inspEntrance,
    required this.defectFound,
    required this.status,
    required this.user,
    required this.arId,
  });

  factory RemoteEditReceivedSimucModel.fromDomain(
          SimucEditReceivedEntity params) =>
      RemoteEditReceivedSimucModel(
        id: params.id,
        numberSerie: params.numberSerie,
        item: params.item,
        dateRegister: params.dateRegister,
        defectRelated: params.defectRelated,
        inspEntrance: params.inspEntrance,
        defectFound: params.defectFound,
        status: params.status,
        user: params.user,
        arId: params.arId,
      );

  factory RemoteEditReceivedSimucModel.fromJson(Map? json) {
    return RemoteEditReceivedSimucModel(
        id: json?['id'] ?? '',
        numberSerie: json?['number_serie'] ?? '',
        item: json?['item'] ?? '',
        dateRegister: json?['date_register'] ?? '',
        defectRelated: json?['defect_related'] ?? '',
        inspEntrance: json?['insp_entrance'] ?? '',
        defectFound: json?['defect_found'] ?? '',
        status: json?['status'] ?? '',
        user: json?['user'] ?? '',
        arId: json?['ar_id'] ?? '');
  }

  SimucEditReceivedEntity toEntity() => SimucEditReceivedEntity(
      id: id,
      numberSerie: numberSerie,
      item: item,
      dateRegister: dateRegister,
      defectRelated: defectRelated,
      inspEntrance: inspEntrance,
      defectFound: defectFound,
      status: status,
      user: user,
      arId: arId);

  Map toJson() => {
        'id': id,
        'number_serie': numberSerie,
        'item': item,
        'date_register': dateRegister,
        'defect_related': defectRelated,
        'insp_entrance': inspEntrance,
        'defect_found': defectFound,
        'status': status,
        'user': user,
        'ar_id': arId,
      };

  static Map<String, String> convertToMap(dynamic selected) {
    return {
      'id': selected?.id ?? '',
      'numberSerie': selected?.numberSerie ?? '',
      'item': selected?.item ?? '',
      'dateRegister': selected?.dateRegister ?? '',
      'defectRelated': selected?.defectRelated ?? '',
      'inspEntrance': selected?.inspEntrance ?? '',
      'defectFound': selected?.defectFound ?? '',
      'status': selected?.status ?? '',
      'user': selected?.user ?? '',
      'arId': selected?.arId ?? '',
    };
  }
}
