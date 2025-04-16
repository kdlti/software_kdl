import '../../../../../../domain/entities/entities.dart';

abstract class RecordItem {
  Future<bool> recordItem(SimucEntityMenus params);
}
