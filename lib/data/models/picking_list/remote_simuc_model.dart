import '../../../domain/entities/entities.dart';

class RemoteSimucModelPickingList {
  final String id;
  final String numberSerie;
  final String item;
  final String dateRegister;
  final String defectRelated;
  final String inspEntrance;
  final String defectFound;
  final String docExit;
  final String status;
  final String user;
  final String arId;
  final String imageA;
  final String imageB;
  final String box;

  const RemoteSimucModelPickingList({
    required this.id,
    required this.numberSerie,
    required this.item,
    required this.dateRegister,
    required this.defectRelated,
    required this.inspEntrance,
    required this.defectFound,
    required this.docExit,
    required this.status,
    required this.user,
    required this.arId,
    required this.imageA,
    required this.imageB,
    required this.box,
  });

  factory RemoteSimucModelPickingList.fromDomain(SimucEntity entity) {
    return RemoteSimucModelPickingList(
      id: entity.id.toString(),
      numberSerie: entity.numberSerie.toString(),
      item: entity.item ?? "",
      dateRegister: entity.dateRegister ?? "",
      defectRelated: entity.defectRelated,
      inspEntrance: entity.inspEntrance,
      defectFound: entity.defectFound,
      docExit: entity.docExit ?? "",
      status: entity.status.toString(),
      user: entity.user ?? "",
      arId: entity.arId.toString(),
      imageA: entity.imageA ?? "",
      imageB: entity.imageB ?? "",
      box: entity.box ?? "",
    );
  }

  factory RemoteSimucModelPickingList.fromJson(Map<String, dynamic>? json) {
    return RemoteSimucModelPickingList(
      id: json?['id'] ?? '',
      numberSerie: json?['number_serie'] ?? '',
      item: json?['item'] ?? '',
      dateRegister: json?['date_register'] ?? '',
      defectRelated: json?['defect_related'] ?? '',
      inspEntrance: json?['insp_entrance'] ?? '',
      defectFound: json?['defect_found'] ?? '',
      docExit: json?['doc_exit'] ?? '',
      status: json?['status'] ?? '',
      user: json?['user'] ?? '',
      arId: json?['ar_id'] ?? '',
      imageA: json?['imageA'] ?? '',
      imageB: json?['imageB'] ?? '',
      box: json?['box'] ?? '',
    );
  }

  SimucEntity toEntity() => SimucEntity(
        id: id,
        numberSerie: numberSerie,
        item: item,
        //  dateRegister: formatDate(dateRegister),
        defectRelated: defectRelated,
        inspEntrance: inspEntrance,
        defectFound: defectFound,
        docExit: docExit,
        status: status,
        user: user,
        arId: arId,
        imageA: imageA,
        imageB: imageB,
        box: box,
      );

  // String formatDate(String inputDate) {
  //   try {
  //     final inputFormat = DateFormat('yyyy-MM-dd HH:mm');
  //     final outputFormat = DateFormat('dd-MM-yyyy HH:mm');
  //     final date = inputFormat.parse(inputDate);
  //     return outputFormat.format(date);
  //   } catch (e) {
  //     print('Erro ao formatar a data: $e');
  //     return '';
  //   }
  // }

  Map toJson() => {
        'id': id,
        'number_serie': numberSerie,
        'item': item,
        'date_register': dateRegister,
        'defect_related': defectRelated,
        'insp_entrance': inspEntrance,
        'defect_found': defectFound,
        'doc_exit': docExit,
        'status': status,
        'user': user,
        'ar_id': arId,
        'imageA': imageA,
        'imageB': imageB,
        'box': box,
      };

  @override
  String toString() {
    return 'RemoteSimucModel{id: $id, numberSerie: $numberSerie, item: $item, dateRegister: $dateRegister, defectRelated: $defectRelated, inspEntrance: $inspEntrance, defectFound: $defectFound, docExit: $docExit, status: $status, user: $user, arId: $arId}';
  }
}
