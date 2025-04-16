import '../../http/http.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/components_view/load_images.dart';
import '../../models/components_view/models_remote_images.dart';

class RemoteLoadImages implements LoadImages {
  final String arid;
  final String simuc;
  final String url;
  final HttpClient httpClient;

  RemoteLoadImages({
    required this.arid, 
    required this.simuc, 
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<ImagesEntity>> loadImages() async {
    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: {"ar_id": arid, "number_serie": simuc});
             final images = httpResponse.map<ImagesEntity>((json) {
        final imagesEntity =
            RemoteImagesModel.fromJson(json).toEntity();
        return imagesEntity;
      }).toList();
      return images;
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}

