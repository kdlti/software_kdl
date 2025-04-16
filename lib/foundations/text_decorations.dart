import 'package:flutter/material.dart';
import 'package:responsive_table/export.dart';

class TextDecoration {
  static TextStyle rowTextStyle(DatatableHeader header) {
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: header.fontSize,
    );
  }

  static const selectedTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
}
