import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'main/pages/pages.dart';
import 'ui/create_page.dart';

// void main() async {
//   await dotenv.load(fileName: "assets/api.env");
//   await initializeDateFormatting('pt_BR', null);
//   runApp(const MyAppRelatorio(arId: "12", doc: "456", client: "SANTO ANDRÉ"));
// }

// class MyAppRelatorio extends StatelessWidget {
//   final String arId;
//   final String doc;
//   final String client;
//   const MyAppRelatorio({
//     super.key,
//     required this.arId,
//     required this.doc,
//     required this.client,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Tabela GetX',
//       home: Scaffold(
//         body: CreatePage(presenter: makeGetxPagePresenter(arId, doc, client)),
//       ),
//     );
//   }
// }

class MyAppRelatorio extends StatelessWidget {
  final String arId;
  final String doc;
  final String client;
  const MyAppRelatorio({
    super.key,
    required this.arId,
    required this.doc,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return CreatePage(
      presenter: makeGetxPagePresenter(arId, doc, client),
    );
  }
}
