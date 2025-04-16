import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:ide_modular/export.dart';
import 'package:intl/intl.dart';
import 'package:menu_modular/export.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/entities/report/entity_send_report.dart';
import '../../../../../../presentation/presenters.dart';

class FilterData extends StatefulWidget {
  const FilterData({super.key});

  @override
  State<FilterData> createState() => _FilterDataState();
}

class _FilterDataState extends State<FilterData> {
  DateTime? selectedInitialDate;
  DateTime? selectedFinalDate;
  String? selectedReportType;

  final List<String> reportTypes = [
    // "Em Manutenção",
    "Aguardando Diagnóstico (status 3)",
    "Concluído (status 1)",
    "Em Romaneio / Enviado (status 4)"
  ];

  int getStatusCode(String selectedReportType) {
    switch (selectedReportType) {
      // case "Em Manutenção":
      //   return 0;
      case "Aguardando Diagnóstico (status 3)":
        return 3;
      case "Concluído (status 1)":
        return 1;
      case "Em Romaneio / Enviado (status 4)":
        return 4;
      default:
        return 0; // Para status desconhecidos
    }
  }

  Future<void> _selectDateTime(BuildContext context, bool isInitial,
      Function(DateTime) onDateSelected) async {
    DateTime now = DateTime.now();

    // Seleciona a data
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    // Seleciona a hora
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    // Combina data e hora
    DateTime finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
      59,
    );

    onDateSelected(finalDateTime);
  }

  bool isMenuVisible = false;

  void toggleMenu() {
    setState(() {
      isMenuVisible = !isMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxArPresenter>(context);
    return Column(
      children: [
        IconButton(
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return MenuContext(
                    width: 800,
                    height: 500,
                    func: () => toggleMenu(),
                    label: 'Carregando versão...',
                    labelSize: 15,
                    customChildren: Scaffold(),
                  );
            },
          ),
          icon: const Icon(Icons.download),
        ),
      ],
    );
  }
}
  // bool isMenuVisible = false;

  // void toggleMenu() {
  //   setState(() {
  //     isMenuVisible = !isMenuVisible;
  //   });
  // }
// MenuContext(
//                 width: 800,
//                 height: 500,
//                 func: () => toggleMenu(),
//                 label: _appVersion ?? 'Carregando versão...',
//                 labelSize: 15,
//                 customChildren: const Text("Text"),
//               )


// showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return StatefulBuilder(
//               builder: (context, setStateDialog) {
//                 return AlertDialog(
//                   title: const Text('Baixar Relatório'),
//                   content: SizedBox(
//                     height: 300, // Ajustei a altura para comportar o dropdown
//                     child: Column(
//                       children: [
//                         const Text("Selecione a data inicial",
//                             style: TextStyle(fontSize: 14)),
//                         ListTile(
//                           title: Text(
//                             style: const TextStyle(fontSize: 13),
//                             selectedInitialDate != null
//                                 ? DateFormat('yyyy-MM-dd HH:mm:ss')
//                                     .format(selectedInitialDate!)
//                                 : "Selecionar Data Inicial",
//                           ),
//                           trailing: const Icon(Icons.calendar_today),
//                           onTap: () {
//                             _selectDateTime(context, true, (date) {
//                               setStateDialog(() {
//                                 selectedInitialDate = date;
//                               });
//                             });
//                           },
//                         ),
//                         Spacing.verticalSpaceX,
//                         const Text("Selecione a data final",
//                             style: TextStyle(fontSize: 14)),
//                         ListTile(
//                           title: Text(
//                             style: const TextStyle(fontSize: 13),
//                             selectedFinalDate != null
//                                 ? DateFormat('yyyy-MM-dd HH:mm:ss')
//                                     .format(selectedFinalDate!)
//                                 : "Selecionar Data Final",
//                           ),
//                           trailing: const Icon(Icons.calendar_today),
//                           onTap: () {
//                             _selectDateTime(context, false, (date) {
//                               setStateDialog(() {
//                                 selectedFinalDate = date;
//                               });
//                             });
//                           },
//                         ),
//                         Spacing.verticalSpaceXX,
//                         const Text("Tipo de Relatório",
//                             style: TextStyle(fontSize: 14)),
//                         DropdownButton<String>(
//                           isExpanded: true,
//                           value: selectedReportType,
//                           hint: const Text("Selecione o tipo"),
//                           items: reportTypes.map((String type) {
//                             return DropdownMenuItem<String>(
//                               value: type,
//                               child: Text(type),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             setStateDialog(() {
//                               selectedReportType = newValue;
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   actions: <Widget>[
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Fechar o modal
//                       },
//                       child: const Text('Cancelar'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         if (selectedInitialDate != null &&
//                             selectedFinalDate != null &&
//                             selectedReportType != null) {
//                           // var sendReport = SendReportEntity(
//                           //   initialDate: selectedInitialDate.toString(),
//                           //   finalDate: selectedFinalDate.toString(),
//                           //   status: selectedReportType!,
//                           // );
//                           Map<String, dynamic> body = {
//                             "initial_date": selectedInitialDate.toString(),
//                             "final_date": selectedFinalDate.toString(),
//                             "status": getStatusCode(selectedReportType!)
//                           };
//                           // print(body);
//                           controller.generateAndDownloadExcel(body);
//                         }
//                       },
//                       child: const Text('Baixar'),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//         );
