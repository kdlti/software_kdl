import 'package:teste_git_hub/data/usecases/usecases.dart';
import 'package:teste_git_hub/domain/usecases/usecases.dart';

import '../../../../infra/infra.dart';
import '../../http/http.dart';

LoadSimucMenu makeRemoteLoadSimuc(String? id) => RemoteLoadSimucMenu(
      id: id,
      url: RouteManager().makeApiUrl("simucs"),
      httpClient: makeHttpAdapter(),
    );
