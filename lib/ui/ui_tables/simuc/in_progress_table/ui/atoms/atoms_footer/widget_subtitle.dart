import 'package:flutter/material.dart';
import 'package:menu_modular/export.dart';

import '../../../../../../../utils/tables/tables.dart';

class WidgetSubtitle extends StatelessWidget {
  final Color color;
  final Color boxShadowColor;
  final String labelQuantity;
  final String label;
  const WidgetSubtitle({
    super.key,
    required this.boxShadowColor,
    required this.color,
    required this.labelQuantity,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 3,
                color: boxShadowColor,
              )
            ],
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                labelQuantity,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Spacing.horizontalSpaceV,
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
