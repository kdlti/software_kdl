import '../../../entities/entities.dart';

abstract class LoadDefects {
  Future<List<EntityDefects>> loadDefects();
  Future<bool> recordDefects(DefectsRecordEntity params);
}
