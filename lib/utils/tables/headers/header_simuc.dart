import 'package:flutter/material.dart';
import 'package:responsive_table/export.dart';

List<DatatableHeader> headerItem = [
  DatatableHeader(
    text: "NUMERO DE SERIE",
    value: "number_serie",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "ITEM",
    value: "item",
    show: true,
    sortable: true,   
    comands: false,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "DATA CADASTRO",
    value: "date_register",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "ÚLTIMA ATUALIZAÇÃO",
    value: "last_update",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "DEFEITO RELATADO",
    value: "defect_related",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
    fontSize: 10,
  ),
  DatatableHeader(
    text: "INSP. ENTRADA",
    value: "insp_entrance",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
    fontSize: 10,
  ),
  // DatatableHeader(
  //   text: "ATRASO",
  //   value: "delay_date",
  //   show: true,
  //   sortable: true,
  //   textAlign: TextAlign.center,
  //   fontSize: 10,
  // ),
  DatatableHeader(
      text: "STATUS",
      value: "status",
      show: true,
      sortable: true,
      textAlign: TextAlign.center,
      sourceBuilder: (value, row) {
        switch (value) {
           case "4":
            return Tooltip(
              message: "Rom. Gerado/Enviado",
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 3,
                      color: Color.fromARGB(255, 133, 175, 231),
                    )
                  ],
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 59, 193, 255),
                ),
              ),
            );
          case "1":
            return Tooltip(
              message: "Concluída",
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 3,
                      color: Color.fromARGB(255, 59, 255, 66),
                    )
                  ],
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 59, 255, 66),
                ),
              ),
            );
          case "2":
            return Tooltip(
              message: "Aguardando Diagnóstico",
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 3,
                      color: Colors.purple,
                    )
                  ],
                  shape: BoxShape.circle,
                  color: Colors.purple,
                ),
              ),
            );
          case "0":
            return Tooltip(
              message: "Em Manutenção",
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 3,
                      color: Colors.red,
                    )
                  ],
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            );
          default:
            return Container();
        }
      }),
  DatatableHeader(
    text: "USUÁRIO",
    value: "user",
    show: true,
    sortable: false,
    textAlign: TextAlign.center,
  ),
  // DatatableHeader(
  //   text: "AR",
  //   value: "ar_id",
  //   show: true,
  //   sortable: false,
  //   textAlign: TextAlign.center,
  // ),
  DatatableHeader(
    text: "COMANDOS",
    value: "comand",
    show: true,
    sortable: false,
    comands: true,
    textAlign: TextAlign.center,
  ),
];
