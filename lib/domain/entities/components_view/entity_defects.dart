import 'package:equatable/equatable.dart';

class DefectsEntity extends Equatable {
  final String code;
  final String description;
  final String nivel;

  @override
  List get props => [code, description, nivel];

  const DefectsEntity({
    required this.code,
    required this.description,
    required this.nivel
  });
}
