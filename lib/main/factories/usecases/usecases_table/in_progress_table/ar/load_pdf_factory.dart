import '../../../../../../data/usecases/usecases.dart';
import '../../../../../../domain/usecases/usecases.dart';
import '../../../../../../infra/infra.dart';
import '../../../../http/http.dart';

LoadPdf makeRemoteLoadPdfs() => RemoteLoadPdf(
      url: RouteManager().makeApiUrl("getPdfs"),
      httpClient: makeHttpAdapter(),
    );
