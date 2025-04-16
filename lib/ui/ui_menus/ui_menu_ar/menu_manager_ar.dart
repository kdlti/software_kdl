import 'package:flutter/material.dart';
import 'package:menu_modular/export.dart';

import '../../../foundations/foundations.dart';
import '../../../main/factories/form/menu_ar/form.dart';
import '../../../utils/utils.dart';
import 'forms/create/create.dart';
import 'forms/edit/edit_ar.dart';
import 'menu_buttons.dart';
import 'mixins/mixins.dart';

class MenuManagerAr extends StatefulWidget with LoadingManagerAr {
  const MenuManagerAr({
    super.key,
  });

  @override
  State<MenuManagerAr> createState() => _MenuManagerArState();
}

class _MenuManagerArState extends State<MenuManagerAr> {
  EnumMenuAr activeView = EnumMenuAr.menuAR;

  @override
  Widget build(BuildContext context) {
    return _switchViews();
  }

  Widget _switchViews() {
    switch (activeView) {
      case EnumMenuAr.menuAR:
        return MenuButtons(
          onPressed: (value) {
            setState(() {
              activeView = value;
            });
          },
        );

      case EnumMenuAr.createAr:
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeForm.getTheme(context),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return CreateArForm(
                  presenter: makeGetxCreatePresenter(),
                  onBack: () {
                    setState(() {
                      activeView = EnumMenuAr.menuAR;
                    });
                  },
                );
              },
            ),
          ),
        );

      case EnumMenuAr.editAr:
        return SimucEdit(
          onBack: () {
            setState(() {
              activeView = EnumMenuAr.menuAR;
            });
          },
        );
    }
  }
}
