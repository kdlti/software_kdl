import '../../../entities/tables/entity_pdfs.dart';

abstract class LoadPdf {
  Future<List<PdfEntity>> loadPdf(String ar);
}
