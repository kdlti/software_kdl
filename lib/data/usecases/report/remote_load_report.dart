import 'package:http/http.dart';
import 'package:teste_git_hub/domain/entities/report/entity_report.dart';
import 'package:teste_git_hub/ui/picking_list/main/factories/http/api_url_factory.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../infra/infra.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadReport implements ReportUsecase {
  final String url;
  final HttpClient httpClient;

  RemoteLoadReport({required this.url, required this.httpClient});

  @override
  Future<List<ReportEntity>> loadData(body) async {
    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: "post",
        body: body,
      );
      return httpResponse.map<ReportEntity>((json) {
        final reportEntity = RemoteReportModel.fromJson(json).toEntity();
        return reportEntity;
      }).toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
