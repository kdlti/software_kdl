enum UIError {
  numberSerieInUse,
  requiredField,
  invalidField,
  unexpected,
  positionInUse,
  smallerThan,
  noDoc,
  docInUse
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.requiredField:
        return "Campo Obrigatório";
      case UIError.invalidField:
        return 'Campo inválido';
      case UIError.docInUse:
        return 'Documento em Uso';
      case UIError.positionInUse:
        return 'Posição em Uso';
      case UIError.noDoc:
        return 'SEM DOCUMENTO';
      case UIError.numberSerieInUse:
        return 'Simuc Já foi cadastrado!';
      case UIError.smallerThan:
        return 'Número menor do que o esperado!';
      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
