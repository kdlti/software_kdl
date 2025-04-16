import '../../../entities/entities.dart';

abstract class LoadSimuc {
  Future<List<SimucEntityTables>> loadSimuc(String id);
}
