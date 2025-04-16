import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../atoms/button.dart';
import '../atoms/search_bar.dart';
import '../atoms/select_arrows.dart';
import '../atoms/table_left.dart';
import '../atoms/table_right.dart';
import '../components_presenter.dart';

class Template extends StatefulWidget {
  final ComponentsPresenter presenter;
  const Template({super.key, required this.presenter});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListenableProvider(
          create: (_) => widget.presenter,
          child: Container(
            width: 1000,
            height: 540,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 223, 223),
                borderRadius: BorderRadius.circular(10),
              ),
            child: Container(
              margin: const EdgeInsets.only(top: 20, left:30, right: 30),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: SearchBarComponent(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TableLeft(presenter: widget.presenter),
                      const SelectArrows(),
                      const TableRight(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: ComponentButton(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
