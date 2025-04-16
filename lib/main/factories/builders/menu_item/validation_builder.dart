import '../../../../utils/validation/protocols/protocols.dart';
import '../../../../utils/validation/validators/menu_simuc_validations/required_field_validation.dart';
import '../../../../utils/validation/validators/menu_simuc_validations/validations.dart';

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

   ValidationBuilder numberSerie() {
    validations.add(NumberSerieValidation(fieldName!));
    return this;
  }

  //  ValidationBuilder position() {
  //   validations.add(PositionValidation(fieldName!));
  //   return this;
  // }



  List<FieldValidation> build() => validations;
}
