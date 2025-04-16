import '../../entities/include_components/components_record.dart';

abstract class ComponentsRecord {
  Future<bool> recordComponents(ComponentsRecordEntity params);
}