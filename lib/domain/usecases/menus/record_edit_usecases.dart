import '../../../../../../domain/entities/entities.dart';

abstract class RecordEditItem {
  Future<bool> recordEditItem(EditSimucEntity params);
}