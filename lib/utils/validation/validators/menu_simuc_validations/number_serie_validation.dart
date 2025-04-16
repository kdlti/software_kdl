import 'package:equatable/equatable.dart';

import '../../validation.dart';
import '../../protocols/protocols.dart';

class NumberSerieValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const NumberSerieValidation(this.field);

  @override
  ValidationError? validate(Map input, bool? isInList) {
    int value = int.parse(input["Numero de Serie"]);
    if (value.toString().length < 10) {
      return ValidationError.smallerThan;
    }

    final isValid = isInList != true;
    return isValid ? null : ValidationError.numberSerieInUse;
  }
}
