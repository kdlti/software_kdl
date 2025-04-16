import 'package:flutter/material.dart';
import 'package:responsive_table/export.dart';

List<DatatableHeader> headersComponente = [
  DatatableHeader(
    text: "Code",
    value: "code",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "Description",
    value: "description",
    show: true,
    flex: 2,
    sortable: true,
    comands: false,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "Value",
    value: "value",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
];