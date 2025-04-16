import '../../../../utils/validation/protocols/protocols.dart';
import '../../../../utils/validation/validators/validators.dart';

class ValidationBuilder {
  static ValidationBuilder? _instance;
  String fieldName;
  List<FieldValidation> validations = [];

  ValidationBuilder._(this.fieldName);

  static ValidationBuilder field(String fieldName) {
    _instance = ValidationBuilder._(fieldName);
    return _instance!;
  }

  ValidationBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuilder doc() {
    validations.add(DocValidation(fieldName));
    return this;
  }


  ValidationBuilder position() {
    validations.add(PositionValidation(fieldName));
    return this;
  }

  List<FieldValidation> build() => validations;
}
