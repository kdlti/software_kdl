import 'package:flutter/material.dart';
import '../../../../foundations/foundations.dart';
import '../../../../utils/enums/enums.dart';
import '../../../../utils/menus/utils.dart';
import '../../../../main/factories/form/menu_item/form.dart';
import 'forms/create/create.dart';
import 'forms/edit/edit.dart';
import 'menu_buttons.dart';

class MenuManagerItem extends StatefulWidget {
  final String? id;
  const MenuManagerItem({super.key, this.id});

  @override
  State<MenuManagerItem> createState() => _MenuManagerItemState();
}

class _MenuManagerItemState extends State<MenuManagerItem> {
  EnumMenuItem activeView = EnumMenuItem.menuSimuc;

  @override
  Widget build(BuildContext context) {
    return _switchViews();
  }

  Widget _switchViews() {
    switch (activeView) {
      case EnumMenuItem.menuSimuc:
        return MenuButtons(
          onPressed: (value) {
            setState(() {
              activeView = value;
            });
          },
        );

      case EnumMenuItem.createSimuc:
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeForm.getTheme(context),
          home: Scaffold(
              body: CreateItemForm(
            presenter: makeGetxCreateSimucPresenter(widget.id),
            onBack: () {
              setState(() {
                activeView = EnumMenuItem.menuSimuc;
              });
            },
          )),
        );

      case EnumMenuItem.createRelatory:
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeForm.getTheme(context),
          home: Scaffold(
            body: EditItemForm(
              presenter: makeGetxEditSimucPresenter(widget.id),
              onBack: () {
                setState(() {
                  activeView = EnumMenuItem.menuSimuc;
                });
              },
            ),
          ),
        );

      case EnumMenuItem.createSimucNotRecovery:
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeForm.getTheme(context),
          home: Scaffold(
              body: EditItemForm(
            presenter: makeGetxEditSimucPresenter(widget.id),
            onBack: () {
              setState(() {
                activeView = EnumMenuItem.menuSimuc;
              });
            },
          )),
        );
    }
  }
}

// GerarAR(
//               onBack: () {
//                 setState(() {
//                   activeView = EnumMenuFunction.simucMenu;
//                 });
//               },
//             ),

