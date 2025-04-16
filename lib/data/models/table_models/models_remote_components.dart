import '../../../domain/entities/entities.dart';

class RemoteComponentsModelTable {
  final String code;
  final String description;
  final String value;

  const RemoteComponentsModelTable({
    required this.code,
    required this.description,
    required this.value,
  });

  factory RemoteComponentsModelTable.fromDomain(ComponentsEntityTable params) =>
      RemoteComponentsModelTable(
        code: params.code,
        description: params.description,
        value: params.value,
      );

  factory RemoteComponentsModelTable.fromJson(Map? json) {
    return RemoteComponentsModelTable(
      code: json?['code'] ?? '',
      description: json?['description'] ?? '',
      value: json?['value'] ?? '',
    );
  }

  ComponentsEntityTable toEntity() => ComponentsEntityTable(
        code: code,
        description: description,
        value: value,
      );

  Map toJson() => {
        'code': code,
        'description': description,
        'value': value,
      };
}
