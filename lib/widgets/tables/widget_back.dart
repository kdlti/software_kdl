import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../infra/infra.dart';

class TabBarBackAtom extends StatelessWidget {
  final WebSocketService webSocketService;
  final String title;
  final String path;
  
  const TabBarBackAtom({
    super.key,
    required this.title,
    required this.webSocketService,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              // webSocketService.selecionarLinha("selected_line", "0");
              Get.toNamed(path);
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_outlined),
                  const SizedBox(width: 10),
                  Text(title, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
