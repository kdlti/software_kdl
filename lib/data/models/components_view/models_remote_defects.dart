import '../../../domain/entities/entities.dart';

class RemoteDefectsModel {
  final String code;
  final String description;
  final String value;

  const RemoteDefectsModel({
    required this.code,
    required this.description,
    required this.value,
  });

  factory RemoteDefectsModel.fromDomain(DefectsEntity params) =>
      RemoteDefectsModel(
        code: params.code,
        description: params.description,
        value: params.nivel,
      );

  factory RemoteDefectsModel.fromJson(Map? json) {
    return RemoteDefectsModel(
      code: json?['code'] ?? '',
      description: json?['description'] ?? '',
      value: json?['nivel'] ?? '',
    );
  }

  DefectsEntity toEntity() => DefectsEntity(
        code: code,
        description: description,
        nivel: value,
      );

  Map toJson() => {
        'code': code,
        'description': description,
        'nivel': value,
      };
}
