import '../../../domain/entities/entities.dart';

class RemoteDefectModel {
  final String id;
  final String code;
  final String description;

  const RemoteDefectModel({
    required this.id,
    required this.code,
    required this.description,
  });

  factory RemoteDefectModel.fromDomain(EntityDefects params) =>
      RemoteDefectModel(
        id: params.id,
        code: params.code,
        description: params.description,
      );

  factory RemoteDefectModel.fromJson(Map? json) {
    return RemoteDefectModel(
      id: json?['id'] ?? '',
      code: json?['code'] ?? '',
      description: json?['description'] ?? '',
    );
  }

  EntityDefects toEntity() => EntityDefects(
        id: id,
        code: code,
        description: description,
      );

  Map toJson() => {
        'id': id,
        'code': code,
        'description': description,
      };
}
