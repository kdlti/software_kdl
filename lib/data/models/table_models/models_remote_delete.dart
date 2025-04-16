import 'package:intl/intl.dart';

import '../../../domain/entities/entities.dart';

class RemoteDeleteSimucModel {
  final String id;

  RemoteDeleteSimucModel({
    required this.id,
  });

  factory RemoteDeleteSimucModel.fromDomain(List<EntityId> params) =>
      RemoteDeleteSimucModel(
        id: params.map((e) => e.id).toList().join(','),
      );

  factory RemoteDeleteSimucModel.fromJson(Map? json) {
    return RemoteDeleteSimucModel(
      id: json?['id'] ?? '',
    );
  }

  EntityId toEntity() => EntityId(
        id: id,
      );

  Map<String, dynamic> toJson() => {"id": id};
}
