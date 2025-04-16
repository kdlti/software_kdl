import 'package:equatable/equatable.dart';

class ComponentsEntityInclude extends Equatable {
  final String id;
  final String code;
  final String description;
  final String value;
  final String nivel;

  @override
  List get props => [id, code, description, value];

  const ComponentsEntityInclude({
    required this.id,
    required this.code,
    required this.description,
    required this.value,
    required this.nivel,
  });
}
