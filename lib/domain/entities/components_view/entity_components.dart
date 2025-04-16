import 'package:equatable/equatable.dart';

class ComponentsEntity extends Equatable {
  final String code;
  final String description;
  final String value;
  final String nivel;

  @override
  List get props => [code, description, value, nivel];

  const ComponentsEntity({
    required this.code,
    required this.description,
    required this.value,
    required this.nivel,
  });
}
