import '../../../domain/entities/entities.dart';

class RemoteComponentsModel {
  final String code;
  final String description;
  final String value;
  final String nivel;

  const RemoteComponentsModel({
    required this.code,
    required this.description,
    required this.value,
    required this.nivel,
  });

  factory RemoteComponentsModel.fromDomain(ComponentsEntity params) =>
      RemoteComponentsModel(
        code: params.code,
        description: params.description,
        value: params.value,
        nivel: params.nivel
      );

  factory RemoteComponentsModel.fromJson(Map? json) {
    return RemoteComponentsModel(
      code: json?['code'] ?? '',
      description: json?['description'] ?? '',
      value: json?['value'] ?? '',
      nivel: json?['nivel'] ?? '',
    );
  }

  ComponentsEntity toEntity() => ComponentsEntity(
        code: code,
        description: description,
        value: value,
        nivel: nivel
      );

  Map toJson() => {
        'code': code,
        'description': description,
        'value': value,
        'nivel': nivel,
      };
}
