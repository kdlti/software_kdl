import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_git_hub/ui/dashboard/dashboard.dart';
import 'package:teste_git_hub/ui/side_menu/pages/simcard.dart';

import '../../ui/side_menu/components/components.dart';
import '../../ui/ui_tables/export.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX Navigation',
      initialRoute: '/tableAr',
      getPages: [
        GetPage(
          transition: Transition.noTransition,
          name: '/tableAr',
          page: () => InitTableAr(
            controller: makeGetxCreateArPresenter(),
          ),
        ),
        GetPage(
          transition: Transition.noTransition,
          name: '/tableItens',
          page: () => InitTableItem(
            controller: makeGetxCreateSimucPresenter(),
          ),
        ),
        GetPage(
          transition: Transition.noTransition,
          name: '/dashboard',
          page: () => const DashboardView(),
        ),
        GetPage(
          transition: Transition.noTransition,
          name: '/simcard',
          page: () => const Simcard(),
        ),
      ],
      builder: (context, child) {
        return SideMenuIde(child: child);
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
