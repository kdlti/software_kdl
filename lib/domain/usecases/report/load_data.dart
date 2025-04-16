import '../../entities/report/entity_report.dart';
import '../../entities/report/entity_send_report.dart';

abstract class ReportUsecase {
  Future<List<ReportEntity>> loadData(Map<String, dynamic> body);
}

// abstract class ReportUsecase {
//   Future<List<ReportEntity>> loadData();
// }
