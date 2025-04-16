enum UIError{
  requiredField,
}

extension UIErrorExtension on UIError{
  String get description {
    switch(this){
      case UIError.requiredField: return "Campo Obrigatório";
      default: return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}