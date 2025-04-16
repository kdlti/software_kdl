import '../../../entities/entities.dart';

abstract class LoadAr {
  Future<List<ArEntityTable>> loadAr();
}
