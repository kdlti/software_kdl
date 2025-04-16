import 'package:flutter/material.dart';

class WidgetsTableComponent extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  const WidgetsTableComponent(
      {super.key, required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.3),
        color: const Color.fromARGB(255, 204, 204, 204),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: DataTable(
              dividerThickness: 5,
              headingTextStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              headingRowHeight: 30,
              dataTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              columns: columns,
              rows: rows),
        ),
      ),
    );
  }
}
