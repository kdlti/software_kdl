import '../presentation/protocols/protocols.dart';
import '../protocols/field_validation.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  ValidationError? validate({ required String field, required Map input, bool? isInList}) {
    ValidationError? error;
    for (final validation in validations.where((v) => v.field == field)) {  
      error = validation.validate(input, isInList);
      if (error != null) {
        return error;
      }
    }
    return error;
  }
}