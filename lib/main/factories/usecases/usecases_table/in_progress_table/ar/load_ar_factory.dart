import '../../../../../../data/usecases/usecases.dart';
import '../../../../../../domain/usecases/usecases.dart';
import '../../../../../../infra/infra.dart';
import '../../../../http/http.dart';

LoadAr makeRemoteLoadAr() => RemoteLoadAr(
      url: RouteManager().makeApiUrl("ars"),
      httpClient: makeHttpAdapter(),
    );
