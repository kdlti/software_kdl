import 'package:flutter/material.dart';
import 'package:menu_modular/export.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/menus/utils.dart';
import '../../../../../../widgets/widget.dart';
import '../../atoms/create/create.dart';
import '../../mixins/mixins.dart';
import 'create.dart';

class CreateItemForm extends StatefulWidget
    with LoadingManagerSimuc, LoadingManagerMessage {
  final CreateSimucPresenter presenter;
  final VoidCallback onBack;
  const CreateItemForm({
    super.key,
    required this.onBack,
    required this.presenter,
  });

  @override
  State<CreateItemForm> createState() => _CreateItemFormState();
}

class _CreateItemFormState extends State<CreateItemForm> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      widget.handleLoadingSimuc(context, widget.presenter.isLoadingStream);
      widget.handleLoadingMessage(
          context, widget.presenter.isLoadingMessageStream);

      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            TabBarBackAtomMenu(title: "ITEM / Criar", onBack: widget.onBack),
            Positioned(
              top: 45,
              bottom: 0,
              left: 0,
              right: 0,
              child: FutureBuilder(
                future: widget.presenter.loadListSimucValidation(context),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListenableProvider(
                          create: (_) => widget.presenter,
                          child: const Form(
                            child: Column(
                              children: [
                                CreateItemType(),
                                Spacing.verticalSpaceX,
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.black12,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
