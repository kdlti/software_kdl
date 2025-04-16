import 'package:get/get.dart';

mixin LoadingManagerMessage on GetxController {
  final _isLoadingMessage = false.obs;
  Stream<bool> get isLoadingMessageStream => _isLoadingMessage.stream;
  set isLoadingMessage(bool value) => _isLoadingMessage.value = value;
}
