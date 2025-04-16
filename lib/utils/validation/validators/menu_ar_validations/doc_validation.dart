import 'package:equatable/equatable.dart';

import '../../validation.dart';
import '../../protocols/protocols.dart';

class DocValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const DocValidation(this.field);

  @override
  ValidationError? validate(Map input, bool? isInList) {
    final isValid =
        input["Doc. de Entrada"]?.isNotEmpty != true && isInList != true;
    return isValid ? null : ValidationError.docInUse;
  }
}
