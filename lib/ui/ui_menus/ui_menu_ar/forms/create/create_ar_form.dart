import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_modular/export.dart';
import 'package:provider/provider.dart';
import 'package:teste_git_hub/utils/errors/errors.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/factory/button_factory.dart';
import '../../../../../widgets/menus/widget_common_input.dart';
import '../../atoms/atoms.dart';
import '../../mixins/mixins.dart';
import 'create_ar_presenter.dart';

class CreateArForm extends StatefulWidget
    with LoadingManagerAr, LoadingManagerMessage {
  final CreateArPresenter presenter;
  final VoidCallback onBack;
  const CreateArForm({
    super.key,
    required this.onBack,
    required this.presenter,
  });

  @override
  State<CreateArForm> createState() => _CreateArFormState();
}

class _CreateArFormState extends State<CreateArForm> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Builder(builder: (context) {
        widget.handleLoadingAr(context, widget.presenter.isLoadingStream);
        widget.handleLoadingMessage(
            context, widget.presenter.isLoadingMessageStream);

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              TabBarBackAtomMenu(title: "AR / Criar", onBack: widget.onBack),
              Positioned(
                top: 45,
                bottom: 0,
                left: 0,
                right: 0,
                child: FutureBuilder(
                  future: widget.presenter.loadListArValidation(context),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListenableProvider(
                            create: (_) => widget.presenter,
                            child: Form(
                              // key: ManagerKey.formKey,
                              child: Column(
                                children: [
                                  const CreateArCostumer(),
                                  Spacing.verticalSpaceX,
                                  const CreateArDocType(),
                                  Spacing.verticalSpaceX,
                                  WidgetCommonInput<UIError>(
                                    labelText: "Doc. de Entrada",
                                    stream:
                                        widget.presenter.docEntranceErrorStream,
                                    errorTextBuilder: (error) =>
                                        error?.description,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    onChanged:
                                        widget.presenter.validateDocEntrance,
                                  ),
                                  Spacing.verticalSpaceX,
                                  WidgetCommonInput<UIError>(
                                    labelText: 'Posição',
                                    stream:
                                        widget.presenter.positionErrorStream,
                                    errorTextBuilder: (error) =>
                                        error?.description,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    onChanged:
                                        widget.presenter.validatePosition,
                                  ),
                                  Spacing.verticalSpaceX,
                                  WidgetCommonInput<UIError>(
                                    labelText: 'Qtd. Recebida',
                                    stream: widget
                                        .presenter.quantityItensErrorStream,
                                    errorTextBuilder: (error) =>
                                        error?.description,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    onChanged:
                                        widget.presenter.validateQuantityitens,
                                  ),
                                  Spacing.verticalSpaceX,
                                  WidgetCommonInput<UIError>(
                                    labelText: 'Usuário',
                                    stream: widget.presenter.userErrorStream,
                                    errorTextBuilder: (error) =>
                                        error?.description,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(20),
                                    ],
                                    onChanged: widget.presenter.validateUser,
                                  ),
                                  Spacing.verticalSpaceX,
                                  ButtonFactory.createButton(
                                    ButtonType.primary,
                                    "Criar",
                                    widget.presenter.isFormValidStream,
                                    () => widget.presenter.record(),
                                    context
                                  )
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
    });
  }
}
