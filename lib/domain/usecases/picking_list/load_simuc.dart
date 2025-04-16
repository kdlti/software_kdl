import 'package:flutter/material.dart';

import '../../entities/entities.dart';

abstract class LoadSimucs {
  Future<List<EntitySimucsPiclingList>> loadSimucs(String doc, BuildContext context);
}
