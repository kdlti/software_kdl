import 'package:flutter/material.dart';
import 'package:responsive_table/export.dart';

import '../../../ui/ui_tables/ar/ui/atoms/atoms.dart';

List<DatatableHeader> headerArInProgress = [
  DatatableHeader(
    text: "AR",
    value: "ar",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "CLIENTE",
    value: "client",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "TIPO DOCUMENTO",
    value: "doc_type",
    show: true,
    sortable: true,
    comands: false,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "DOC. ENTRADA",
    value: "doc_entrance",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "POSIÇÃO",
    value: "position",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "QTD. CADASTRADA/RECEBIDA",
    value: "quantity_itens",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
    sourceBuilder: (value, row) {
      return AtomLinearProgressActualItens(row: row, color: Colors.orange);
    },
  ),
  DatatableHeader(
    text: "QTD. EM ROMANEIO",
    value: "delivered",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
    sourceBuilder: (value, row) {
      return AtomLinearProgressDelivered(row: row, color: Colors.green, );
    },
  ),
  DatatableHeader(
    text: "QTD. ENTREGUE",
    value: "delivered",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
    sourceBuilder: (value, row) {
      return AtomLinearProgressDelivered(row: row, color: Colors.black, );
    },
  ),
  DatatableHeader(
    text: "DATA ABERTURA",
    value: "date_open",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
    // sourceBuilder: (value, row) => AlterDate(value: value),
  ),
  // DatatableHeader(
  //   text: "PRAZO DE ENTREGA",
  //   value: "date_open",
  //   show: true,
  //   sortable: true,
  //   textAlign: TextAlign.center,
  //   // sourceBuilder: (value, row) => AlterDate(value: value),
  // ),
  DatatableHeader(
    text: "ÚLTIMA ATUALIZAÇÃO",
    value: "last_update",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
    // sourceBuilder: (value, row) => AlterDate(value: value),
  ),
  DatatableHeader(
    text: "USUÁRIO",
    value: "user",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "ROMANEIOS",
    value: "comand",
    show: true,
    sortable: false,
    comands: true,
    textAlign: TextAlign.center,
  ),
];
