import 'package:equatable/equatable.dart';

class ImagesEntity extends Equatable {
  final String imageA;
  final String imageB;

  @override
  List get props => [imageA, imageB];

  const ImagesEntity({
    required this.imageA,
    required this.imageB,
  });
}
