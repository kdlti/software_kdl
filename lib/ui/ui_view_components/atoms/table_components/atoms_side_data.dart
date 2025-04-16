import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../widgets/widget.dart';
import '../../components_presenter.dart';

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

  Color colorNivel(int number) {
    if (number == 0) {
      return const Color.fromARGB(255, 111, 255, 135);
    } else if (number == 1) {
      return const Color.fromARGB(255, 255, 111, 231);
    } else if (number == 2) {
      return const Color.fromARGB(255, 255, 253, 111);
    } else if (number == 3) {
      return const Color.fromARGB(255, 100, 162, 255);
    } else if (number == 4) {
      return const Color.fromARGB(255, 255, 111, 111);
    }

    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ComponentsPresenter>(context);
    return FutureBuilder<List<ComponentsEntity>>(
      future: Future.delayed(const Duration(seconds: 1))
          .then((_) => presenter.fetchData()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                child: Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                child: Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                child: Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar dados'));
        } else if (snapshot.data!.isNotEmpty) {
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.2),
                      color: colorNivel(presenter.highestNivel),
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
                          "Nível",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          presenter.highestNivel.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  if (isLoading) const AtomsLoadingSideData()
                ],
              ),
            ],
          );
        } else {
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "QTD.",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "S/ Dados",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  if (isLoading) const AtomsLoadingSideData()
                ],
              ),
              const SizedBox(height: 10),
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "R\$",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "S/ Dados",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  if (isLoading) const AtomsLoadingSideData()
                ],
              ),
              const SizedBox(height: 10),
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Nível",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "S/ Dados",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  if (isLoading) const AtomsLoadingSideData()
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
