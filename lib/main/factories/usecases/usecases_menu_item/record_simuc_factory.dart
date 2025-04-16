import '../../../../data/usecases/usecases.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../../infra/infra.dart';
import '../../http/http.dart';

RecordItem makeRemoteRecordSimuc() => RemoteRecordSimuc(
      url: RouteManager().makeApiUrl("createSimuc"),
      httpClient: makeHttpAdapter(),
    );
