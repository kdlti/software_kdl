import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../ui/ui_view_components/components_presenter.dart';
import '../../mixins/mixins.dart';

class GetxComponentesPresenterComponentsView extends GetxController
    with LoadingManager
    implements ComponentsPresenter {
  final LoadDefectsView loadDefects;
  final LoadImages loadImages;
  final LoadComponentsComponentsView loadComponents;

  GetxComponentesPresenterComponentsView({
    required this.loadDefects,
    required this.loadImages,
    required this.loadComponents,
  });

  final RxList<ImagesEntity> _sourceImages = <ImagesEntity>[].obs;

  final _imageA = Rx<Uint8List?>(null);
  final _imageB = Rx<Uint8List?>(null);

  final RxList<ComponentsEntity> _listComponents = <ComponentsEntity>[].obs;
  final RxList<ComponentsEntity> _source = <ComponentsEntity>[].obs;

  final RxDouble _total = RxDouble(0);
  final RxInt _highestNivel = RxInt(0);

  @override
  List<ComponentsEntity> get source => _source;

  @override
  List<ImagesEntity> get sourceImages => _sourceImages;

  @override
  List<ComponentsEntity> get listComponents => _listComponents;

  @override
  double get total => _total.value;
  @override
  int get highestNivel => _highestNivel.value;

  @override
  Stream<Uint8List?>? get imageA => _imageA.stream;

  @override
  Stream<Uint8List?>? get imageB => _imageB.stream;

  @override
  initializeData() async {
    isLoading = true;
    Future.delayed(const Duration(seconds: 0)).then((value) async {
      await fetchImages();
      isLoading = false;
    });
  }

  @override
  Future<List<ComponentsEntity>> fetchData() async {
    try {
      _source.value = await loadComponents.loadComponents();
      _listComponents.value = _source;
      if (_listComponents.isEmpty) {
        isLoading = false;
      }
      sum();
      highestNivelVerify();
      return _source;
    } catch (e) {
      print("Erro ao carregar componentes: $e");
      return [];
    }
  }

  @override
  Future<List<DefectsEntity>> fetchDefects() async {
    try {
      var teste = await loadDefects.loadDefects();
      return teste;
    } catch (e) {
      print("Erro ao carregar componentes: $e");
      return [];
    }
  }

  @override
  Future<List<ImagesEntity>> fetchImages() async {
    try {
      _sourceImages.value = await loadImages.loadImages();
      for (var teste in _sourceImages) {
        _imageA.value = base64Decode(teste.imageA);
        _imageB.value = base64Decode(teste.imageB);
      }
      return _sourceImages;
    } catch (e) {
      print("Erro ao carregar Imagens: $e");
      return [];
    }
  }

  @override
  sum() {
    try {
      var validComponents = _listComponents.where((e) {
        try {
          double.parse(e.value);
          return true;
        } catch (_) {
          return false;
        }
      }).toList();

      if (validComponents.isEmpty) {
        _total.value = 0.0;
      } else {
        _total.value = validComponents
            .map((e) => double.parse(e.value))
            .reduce((a, b) => a + b);
      }
    } catch (e) {
      print("Erro ao calcular a soma: $e");
      _total.value = 0.0;
    }
  }

  int highestNivelVerify() {
    _highestNivel.value = 0;

    for (var teste in _listComponents) {
      if (int.parse(teste.nivel) > _highestNivel.value) {
        _highestNivel.value = int.parse(teste.nivel);
      }
    }

    return _highestNivel.value;
  }
}
