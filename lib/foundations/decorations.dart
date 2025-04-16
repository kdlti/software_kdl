import 'package:flutter/material.dart';
import 'package:responsive_table/export.dart';

import 'colors.dart';

class Decorations {
  static const headerDecoration = BoxDecoration(
    color: Colors.transparent,
    border: Border(
      bottom: BorderSide(color: ColorFoundations.greylight, width: 1),
    ),
  );

  static const selectedDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    color: Colors.grey,
  );

  static const searchBarDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static final rowDecoration = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    color: const Color(0xffD9D9D9).withOpacity(0.4),
  );

  static final rowDecorationLate = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    color: const Color.fromARGB(255, 255, 186, 186).withOpacity(0.4),
  );

  static final checkBoxDecoration = CheckboxStyle(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    checkColor: Colors.white,
    activeColor: Colors.grey,
    side: const BorderSide(
      color: Color.fromARGB(255, 126, 126, 126),
      width: 2,
    ),
  );
}
