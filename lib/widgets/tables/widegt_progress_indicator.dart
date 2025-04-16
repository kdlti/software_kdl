import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/presenters.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<GetxTableSimucPresenter>(context);
    return presenter.isLoading != false
        ? LinearProgressIndicator(
            backgroundColor: Colors.grey.shade200,
            color: Colors.orange,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            minHeight: 2.0,
          )
        : Container();
  }
}
