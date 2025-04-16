import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'atoms/atoms.dart';
import '../../main/factories/form/form_include_components/form_include_components.dart';

void main() async {
  const envFile = String.fromEnvironment('ENV_FILE', defaultValue: 'local.env');
  await dotenv.load(fileName: "assets/$envFile");
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ComponenteInclude(id: "1", arId: "282"),
  ));
}

class ComponenteInclude extends StatelessWidget {
  final String id;
  final String arId;
  const ComponenteInclude({super.key, required this.id, required this.arId});

  @override
  Widget build(BuildContext context) {
    return Template(presenter: makeGetxComponentsPresenter(id, arId));
  }
}
