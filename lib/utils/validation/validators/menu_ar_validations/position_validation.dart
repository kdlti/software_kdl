import 'package:equatable/equatable.dart';


import '../../validation.dart';
import '../../protocols/protocols.dart';

class PositionValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const PositionValidation(this.field);

  @override
  ValidationError? validate(Map input, bool? isInList) {
    final isValid = input["Posicao"]?.isNotEmpty && isInList != true;
    return isValid ? null : ValidationError.positionInUse;
  }
}
