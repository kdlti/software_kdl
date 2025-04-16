import 'package:flutter/material.dart';

class DashboardAtom extends StatelessWidget {
  final String label;
  const DashboardAtom({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 3),
              spreadRadius: 1,
              blurStyle: BlurStyle.normal,
              color: Color.fromARGB(255, 170, 170, 170),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFD9D9D9)),
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 40,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
