import '../../../../../../domain/entities/entities.dart';

abstract class LoadArMenu {
  Future<List<ArEntityMenus>> loadAr();
}
