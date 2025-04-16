import '../../entities/entities.dart';

abstract class LoadDefectsView {
  Future<List<DefectsEntity>> loadDefects();
}
