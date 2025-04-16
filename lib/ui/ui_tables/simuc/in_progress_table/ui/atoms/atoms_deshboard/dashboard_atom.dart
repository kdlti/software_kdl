import 'package:flutter/material.dart';

class DashboardAtom extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? colorInternal;
  final double? fontSize;
  final double? widthIternal;
  final double? widthExternal;
  const DashboardAtom({
    super.key,
    required this.label,
    this.color,
    this.fontSize,
    this.colorInternal,
    required this.widthIternal,
    required this.widthExternal,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = MediaQuery.of(context).size.width;

      bool isLargeScreen = width > 1361;

      double sizeFont = isLargeScreen ? 13 : 10;

      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: color,
        ),
        width: widthExternal,
        height: 30,
        child: Container(
          alignment: Alignment.center,
          width: widthIternal,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: colorInternal,
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: sizeFont, fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }
}
