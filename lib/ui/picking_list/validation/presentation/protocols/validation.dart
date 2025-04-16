abstract class Validation {
  ValidationError? validate({
    required String field,
    required Map input,
    bool? isInList
  });
}

enum ValidationError {
  requiredField,
  invalidField,
  positionInUse,
  noDoc,
  docInUse,
  numberSerieInUse,
  smallerThan
}