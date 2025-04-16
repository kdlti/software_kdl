import '../../entities/entities.dart';

abstract class LoadCostumers {
  Future<List<CostumersEntity>> loadCostumers();
}
