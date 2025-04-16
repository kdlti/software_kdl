import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../widgets/widget.dart';
import '../components_presenter.dart';

class AtomsSideData extends StatefulWidget {
  final ComponentsPresenter presenter;
  const AtomsSideData({super.key, required this.presenter});

  @override
  State<AtomsSideData> createState() => _AtomsSideDataState();
}

class _AtomsSideDataState extends State<AtomsSideData> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.presenter.isLoadingStream.listen((loading) {
      setState(() {
        isLoading = loading;
      });
    });

    widget.presenter.initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ComponentsPresenter>(context);
    return Obx(() {
      return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.2),
                        color: const Color.fromARGB(255, 173, 173, 173),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "QTD.",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            presenter.listComponents.length.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    if (isLoading) const AtomsLoadingSideData()
                  ],
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 173, 173, 173),
                        border: Border.all(color: Colors.black, width: 0.2),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "R\$",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            presenter.total.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    if (isLoading) const AtomsLoadingSideData()
                  ],
                ),
              ],
            );
    });
  }
}
