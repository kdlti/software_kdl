import '../../../../data/usecases/usecases.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../../infra/infra.dart';
import '../../http/http.dart';

RecordAr makeRemoteRecordAr() => RemoteRecordAr(
      url: RouteManager().makeApiUrl("createAr"),
      httpClient: makeHttpAdapter(),
    );
