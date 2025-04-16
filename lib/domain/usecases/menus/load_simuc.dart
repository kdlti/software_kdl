import '../../../../../../domain/entities/entities.dart';

abstract class LoadSimucMenu {
  Future<List<SimucEntityMenus>> loadSimuc();
}
