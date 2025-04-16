import '../../../domain/entities/entities.dart';

class RemoteComponentsModelInclude {
  final String id;
  final String code;
  final String description;
  final String value;
  final String nivel;

  const RemoteComponentsModelInclude({
    required this.id,
    required this.code,
    required this.description,
    required this.value,
    required this.nivel,
  });

  factory RemoteComponentsModelInclude.fromDomain(ComponentsEntityInclude params) =>
      RemoteComponentsModelInclude(
        id: params.id,
        code: params.code,
        description: params.description,
        value: params.value,
        nivel: params.nivel
      );

  factory RemoteComponentsModelInclude.fromJson(Map? json) {
    return RemoteComponentsModelInclude(
      id: json?['id'] ?? '',
      code: json?['code'] ?? '',
      description: json?['description'] ?? '',
      value: json?['value'] ?? '',
      nivel: json?['nivel'] ?? '',
    );
  }

  ComponentsEntityInclude toEntity() => ComponentsEntityInclude(
        id: id,
        code: code,
        description: description,
        value: value,
        nivel: nivel
      );

  Map toJson() => {
        'id': id,
        'code': code,
        'description': description,
        'value': value,
        'nivel': nivel,
      };
}
