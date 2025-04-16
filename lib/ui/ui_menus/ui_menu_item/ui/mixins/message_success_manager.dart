
import 'package:flutter/material.dart';

import '../../../../../utils/utils.dart';

mixin LoadingManagerMessage {
  void handleLoadingMessage(BuildContext context, Stream<bool> stream) {
    stream.listen((isLoading) async {
      if (isLoading == true) {
        await showLoadingVerified(context);
      } else {
        hideLoadingError(context);
      }
    });
  }
}