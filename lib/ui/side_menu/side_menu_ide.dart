import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ide_modular/export.dart';
import 'package:teste_git_hub/ui/side_menu/atoms/Atoms_header.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:package_info_plus/package_info_plus.dart';

class SideMenuIde extends StatefulWidget {
  final Widget? customChild;
  final Widget? child;
  const SideMenuIde({
    super.key,
    this.child,
    this.customChild,
  });

  @override
  State<SideMenuIde> createState() => _SideMenuIdeState();
}

class _SideMenuIdeState extends State<SideMenuIde> {
  late SideMenuController controller;
  double selectedIndex = 1;
  String? _appVersion;

  @override
  void initState() {
    getAppVersion().then((version) {
      setState(() {
        _appVersion = version;
      });
    });
    controller = SideMenuController();
    super.initState();
    selectedIndex = 1;
    // selectedIndex = calculateSelectedIndex();
  }

  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return 'Versão: ${packageInfo.version}+${packageInfo.buildNumber}';
  }

  int calculateSelectedIndex() {
    final String location = Get.previousRoute;
    if (location.startsWith('/dashboard')) {
      return 0;
    }
    if (location.startsWith('/tableAr')) {
      return 1;
    }
    if (location.startsWith('/tableArLate')) {
      return 2;
    }
    if (location.startsWith('/simcard')) {
      return 3;
    }
    return 0;
  }

  void onItemTapped(double index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        Get.toNamed('/dashboard');
        break;
      case 1:
        Get.toNamed('/tableAr');
        break;
      case 2:
        Get.toNamed('/tableArLate');
        break;
      case 3:
        Get.toNamed('/simcard');
        break;
    }
  }

  bool isMenuVisible = false;

  void toggleMenu() {
    setState(() {
      isMenuVisible = !isMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                SideMenu(
                  maxWidth: 150,
                  hasResizer: false,
                  mode: SideMenuMode.open,
                  hasResizerToggle: false,
                  controller: controller,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  builder: (data) {
                    return SideMenuData(
                      header: const AtomsHeader(),
                      items: [
                        const SideMenuItemDataDivider(
                          divider: Divider(
                            indent: 10,
                            endIndent: 10,
                            height: 5,
                            // thickness: 10,
                            color: Color.fromARGB(255, 197, 197, 197),
                          ),
                        ),
                        FluentTreeViewItemData(
                          [
                            fluent.TreeViewItem(
                              backgroundColor: WidgetStateProperty.all(
                                  const Color.fromARGB(255, 216, 216, 216)),
                              expanded: true,
                              content: const Text(
                                "Manutenção",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              ),
                              children: [
                                // fluent.TreeViewItem(
                                //     content: const Text(
                                //       "Dashboard",
                                //       overflow: TextOverflow.ellipsis,
                                //     ),
                                //     children: [
                                //       fluent.TreeViewItem(
                                //         onInvoked: (item, reason) async {
                                //           onItemTapped(0);
                                //         },
                                //         content: const Text(
                                //           "Relatórios",
                                //           overflow: TextOverflow.ellipsis,
                                //         ),
                                //       ),
                                //     ]),
                                // fluent.TreeViewItem(
                                //   content: const Text("Cadastro",
                                //       overflow: TextOverflow.ellipsis),
                                //   children: [
                                //     fluent.TreeViewItem(
                                //       onInvoked: (item, reason) async {
                                //         onItemTapped(1);
                                //       },
                                //       content: const Text(
                                //         "AR",
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     ),
                                //     fluent.TreeViewItem(
                                //       content: const Text(
                                //         "SIMUC",
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     ),
                                //     fluent.TreeViewItem(
                                //       content: const Text(
                                //         "SIMCON",
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     ),
                                //     fluent.TreeViewItem(
                                //       content: const Text(
                                //         "Luminária",
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     )
                                //   ],
                                // ),
                                fluent.TreeViewItem(
                                  content: const Text(
                                    "Em Andamento",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // fluent.TreeViewItem(
                                //     content: const Text("Manutenção",
                                //         overflow: TextOverflow.ellipsis),
                                //     onInvoked: (item, reason) async {},
                                //     children: [
                                //       fluent.TreeViewItem(
                                //         onInvoked: (item, reason) async {
                                //           onItemTapped(1);
                                //         },
                                //         content: const Text(
                                //           "Criar",
                                //           overflow: TextOverflow.ellipsis,
                                //         ),
                                //       ),
                                //       fluent.TreeViewItem(
                                //         content: const Text(
                                //           "Editar",
                                //           overflow: TextOverflow.ellipsis,
                                //         ),
                                //       ),
                                //       fluent.TreeViewItem(
                                //         content: const Text(
                                //           "Excluir",
                                //           overflow: TextOverflow.ellipsis,
                                //         ),
                                //       )
                                //     ]),
                                // fluent.TreeViewItem(
                                //   content: const Text("Romaneios",
                                //       overflow: TextOverflow.ellipsis),
                                //   children: [
                                //     fluent.TreeViewItem(
                                //       content: const Text("Criar",
                                //           overflow: TextOverflow.ellipsis),
                                //     ),
                                //     fluent.TreeViewItem(
                                //       content: const Text("Relatórios",
                                //           overflow: TextOverflow.ellipsis),
                                //     ),
                                //   ],
                                // ),
                                // fluent.TreeViewItem(
                                //   content: const Text("Entregas",
                                //       overflow: TextOverflow.ellipsis),
                                //   children: [
                                //     fluent.TreeViewItem(
                                //       content: const Text("Gerenciamento",
                                //           overflow: TextOverflow.ellipsis),
                                //     ),
                                //     fluent.TreeViewItem(
                                //       content: const Text("Relatórios",
                                //           overflow: TextOverflow.ellipsis),
                                //     ),
                                //   ],
                                // ),
                                // fluent.TreeViewItem(
                                //   content: const Text("Estoque",
                                //       overflow: TextOverflow.ellipsis),
                                //   children: [
                                //     fluent.TreeViewItem(
                                //       content: const Text("Gerenciamento",
                                //           overflow: TextOverflow.ellipsis),
                                //     ),
                                //     fluent.TreeViewItem(
                                //       content: const Text("Relatórios",
                                //           overflow: TextOverflow.ellipsis),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            fluent.TreeViewItem(
                              backgroundColor: WidgetStateProperty.all(
                                  const Color.fromARGB(255, 216, 216, 216)),
                              expanded: false,
                              content: const Text(
                                "Produção",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              ),
                              children: [
                                // fluent.TreeViewItem(
                                //   content: const Text("Em Andamento",
                                //       overflow: TextOverflow.ellipsis),
                                // ),
                                // fluent.TreeViewItem(
                                //   content: const Text("Atrasados",
                                //       overflow: TextOverflow.ellipsis),
                                // ),
                                // fluent.TreeViewItem(
                                //   content: const Text("Finalizados",
                                //       overflow: TextOverflow.ellipsis),
                                // ),
                              ],
                            ),
                            fluent.TreeViewItem(
                              backgroundColor: WidgetStateProperty.all(
                                  const Color.fromARGB(255, 216, 216, 216)),
                              expanded: false,
                              content: const Text(
                                "Simcards",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              ),
                              children: [
                                // fluent.TreeViewItem(
                                //   onInvoked: (item, reason) async {
                                //     // print("$item, $reason");
                                //     // onItemTapped(2);
                                //   },
                                //   content: const Text("Em Andamento",
                                //       overflow: TextOverflow.ellipsis),
                                // ),
                                // fluent.TreeViewItem(
                                //   content: const Text("Atrasados",
                                //       overflow: TextOverflow.ellipsis),
                                // ),
                                // fluent.TreeViewItem(
                                //   content: const Text("Finalizados",
                                //       overflow: TextOverflow.ellipsis),
                                // ),
                              ],
                            ),
                          ],
                        )
                      ],
                      footer: UserMenu(
                        data: [
                          MenuUserData(
                            icon: Icons.info,
                            title: "Sobre",
                            onTap: () => toggleMenu(),
                          ),
                          MenuUserData(
                            icon: Icons.info,
                            title: "Extrair Relatório",
                            onTap: () => toggleMenu(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Expanded(
                  child: widget.child ?? Container(),
                ),
              ],
            ),
            if (isMenuVisible)
              MenuContext(
                width: 800,
                height: 500,
                func: () => toggleMenu(),
                label: _appVersion ?? 'Carregando versão...',
                labelSize: 15,
                customChildren: const Text("Text"),
              )
          ],
        ),
      ),
    );
  }
}

// class MenuContext extends StatelessWidget {
//   final VoidCallback func;
//   const MenuContext({super.key, required this.func});

//   @override
//   Widget build(BuildContext context) {
//     return Positioned.fill(
//       child: Container(
//         color: Colors.black.withOpacity(0.5),
//         child: Center(
//           child: Container(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(5)),
//               color: Colors.white,
//             ),
//             width: 500,
//             height: 300,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                       focusColor: Colors.transparent,
//                       hoverColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       disabledColor: Colors.transparent,
//                       onPressed: func,
//                       icon: const Icon(
//                         Icons.close,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 50),
//                 const Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.info, size: 60),
//                     SizedBox(height: 30),
//                     Text('Versão: 1.2.1+1'),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
