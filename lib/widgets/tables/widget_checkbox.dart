import 'package:flutter/material.dart';

class CheckboxWidget extends StatelessWidget {
  final Function(bool?)? onChanged;
  final bool? value;
  const CheckboxWidget({Key? key, required this.onChanged, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      checkColor: Colors.white,
      activeColor: Colors.grey,
      side: const BorderSide(
        color: Color.fromARGB(255, 126, 126, 126),
        width: 2,
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
