import '../../../entities/entities.dart';

abstract class DeleteSimuc {
  Future<bool> deleteSimuc(List<EntityId> params);
}
