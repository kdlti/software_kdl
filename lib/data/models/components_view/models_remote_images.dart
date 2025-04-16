import '../../../domain/entities/entities.dart';

class RemoteImagesModel {
  final String imageA;
  final String imageB;

  const RemoteImagesModel({
    required this.imageA,
    required this.imageB,
  });

  factory RemoteImagesModel.fromDomain(ImagesEntity params) =>
      RemoteImagesModel(imageA: params.imageA, imageB: params.imageB);

  factory RemoteImagesModel.fromJson(Map? json) {
    return RemoteImagesModel(
      imageA: json?['imageA'] ?? '',
      imageB: json?['imageB'] ?? '',
    );
  }

  ImagesEntity toEntity() => ImagesEntity(
        imageA: imageA,
        imageB: imageB,
      );

  Map toJson() => {
        'imageA': imageA,
        'imageB': imageB,
      };
}
