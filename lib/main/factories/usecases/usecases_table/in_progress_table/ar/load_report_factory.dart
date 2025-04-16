import '../../../../../../data/usecases/report/remote_load_report.dart';
import '../../../../../../data/usecases/usecases.dart';
import '../../../../../../domain/usecases/usecases.dart';
import '../../../../../../infra/infra.dart';
import '../../../../http/http.dart';

ReportUsecase makeRemoteLoadReport() => RemoteLoadReport(
      url: RouteManager().makeApiUrl("reports"),
      httpClient: makeHttpAdapter(),
    );
