import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

mixin LoadingManager {
   handleLoading(BuildContext context, Stream<bool> stream) {
    stream.listen((isLoading) async {
      if (isLoading == true) {
        await DialogsNotifier().showLoading(context);
      } else {
        DialogsNotifier().hideLoading(context);
      }
    });
  }
}
