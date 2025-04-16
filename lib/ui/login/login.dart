// import 'package:flutter/material.dart';
// import 'package:login_package/export.dart';

// class LoginTeste extends StatelessWidget {
//   const LoginTeste({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LoginScreen(
//       passwordController: TextEditingController(),
//       textController: TextEditingController(),
//       loginConfig: LoginConfig(
//         textFiledConfig:
//             UserTextFieldConfig(onChanged: (value) => print(value)),
//         passwordConfig: PasswordConfig(onChanged: (value) => print(value)),
//         // logo: Image.asset("logo_kdl.jpg"),
//         logo: const FlutterLogo(size: 100),
//         title: 'ERP Manutenção',
//         subtitle: 'Efetuar Login',
//       ),
//       pageConfig: const PageConfig(
//         colors: [
//           Color.fromARGB(255, 0, 0, 0),
//           Color.fromARGB(255, 224, 224, 224),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(
//     const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginTeste(),
//     ),
//   );
// }
