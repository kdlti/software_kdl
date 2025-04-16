import 'package:equatable/equatable.dart';

class EntityDefects extends Equatable {
  final String id;
  final String code;
  final String description;

  @override
  List get props => [
        id,
        code,
        description,
      ];

  const EntityDefects({
    required this.id,
    required this.code,
    required this.description,
  });
}