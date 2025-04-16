import 'package:equatable/equatable.dart';

class PdfEntity extends Equatable {
  final String fileName;
  final String content;

  @override
  List get props => [content, fileName];

  const PdfEntity({
    required this.content,
    required this.fileName,
  });
}
