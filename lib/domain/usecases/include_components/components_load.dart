import '../../entities/entities.dart';

abstract class LoadComponentsInclude {
  Future<List<ComponentsEntityInclude>> loadComponents();
}
