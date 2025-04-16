import 'package:flutter/material.dart';

class TabBarBackAtomMenu extends StatelessWidget {
  final VoidCallback onBack;
  final String title;

  const TabBarBackAtomMenu(
      {super.key, required this.onBack, required this.title});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.02),
        border: const Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: onBack,
            child: SizedBox(
              height: 45,
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_outlined),
                  const SizedBox(width: 10),
                  Text(title, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 45,
            height: 45,
            child: width < 1500 ? Container() : Image.asset("assets/images/logo.jpg"),
          ),
        ],
      ),
    );
  }
}
