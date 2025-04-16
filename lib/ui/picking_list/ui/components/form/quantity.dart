import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presenters/page_presenter.dart';

class Quantity extends StatelessWidget {
  const Quantity({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PagePresenter>(context);
    return Column(
      children: [
        const Text("Quantidade"),
        const SizedBox(height: 10),
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Color.fromARGB(255, 194, 216, 255),
          ),
          child: Center(
            child: StreamBuilder<int>(
                stream: presenter.quantityStream,
                initialData: 0,
                builder: (context, snapshot) {
                  return Text(
                    "${snapshot.data}",
                    style: const TextStyle(fontSize: 20),
                  );
                }),
          ),
        ),
      ],
    );
  }
} 