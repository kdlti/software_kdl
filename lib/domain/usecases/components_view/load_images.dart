import '../../entities/entities.dart';

abstract class LoadImages {
  Future<List<ImagesEntity>> loadImages();
}
