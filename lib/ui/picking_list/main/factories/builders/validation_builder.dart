import '../../../validation/protocols/protocols.dart';
import '../../../validation/validators/menu_relatorio_validations/required_field_validation.dart';
import '../../../validation/validators/menu_relatorio_validations/validations.dart';

class ValidationBuilder {
  static ValidationBuilder? _instance;
  String? fieldName;
  bool? loadFieldResult;
  List<FieldValidation> validations = [];

  ValidationBuilder._();

   static ValidationBuilder? field(String fieldName) {
    _instance = ValidationBuilder._();
    _instance?.fieldName = fieldName;
    return _instance;
  }

  ValidationBuilder required() {
    validations.add(RequiredFieldValidationItem(fieldName!));
    return this;
  }

  //  ValidationBuilder position() {
  //   validations.add(PositionValidation(fieldName!));
  //   return this;
  // }



  List<FieldValidation> build() => validations;
}
