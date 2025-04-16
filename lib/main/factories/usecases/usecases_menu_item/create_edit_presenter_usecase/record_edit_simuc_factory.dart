import '../../../../../data/usecases/usecases.dart';
import '../../../../../domain/usecases/usecases.dart';
import '../../../../../infra/infra.dart';
import '../../../http/http.dart';

RecordEditItem makeRemoteEditSimuc() => RemoteRecordEditSimuc(
      url: RouteManager().makeApiUrl(""),
      httpClient: makeHttpAdapter(),
);
