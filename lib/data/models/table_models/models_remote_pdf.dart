import '../../../domain/entities/tables/entity_pdfs.dart';

class RemotePdfsModel {
  final String fileName;
  final String content;

  const RemotePdfsModel({
    required this.fileName,
    required this.content,
  });

  factory RemotePdfsModel.fromDomain(PdfEntity params) => RemotePdfsModel(
        fileName: params.fileName,
        content: params.content,
      );

  factory RemotePdfsModel.fromJson(Map? json) {
    return RemotePdfsModel(
      fileName: json?['file_name'] ?? '',
      content: json?['content'] ?? '',
    );
  }

  PdfEntity toEntity() => PdfEntity(
        fileName: fileName,
        content: content,
      );

  Map toJson() => {
        'file_name': fileName,
        'content': content,
      };
}
