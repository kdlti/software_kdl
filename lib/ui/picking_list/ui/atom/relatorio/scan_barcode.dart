import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';

import '../../page_presenter.dart';

class ScanBarcode extends StatefulWidget {
  const ScanBarcode({super.key});

  @override
  ScanBarcodeState createState() => ScanBarcodeState();
}

class ScanBarcodeState extends State<ScanBarcode> {
  String? _barcode;
  late bool visible;

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PagePresenter>(context);
    return  VisibilityDetector(
        onVisibilityChanged: (VisibilityInfo info) {
          visible = info.visibleFraction > 0;
        },
        key: const Key('visible-detector-key'),
        child: BarcodeKeyboardListener(
          bufferDuration: const Duration(milliseconds: 200),
          onBarcodeScanned: (barcode) {
            if (!visible) return;
            setState(() {
              presenter.getNserlum(barcode, context);
              _barcode = barcode;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                _barcode == null ? 'Escaneie o Código' : 'CÓDIGO: $_barcode',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              // TextFormField(
              //   onChanged: (value){
              //     if(value.length == 10){
              //       presenter.getNserlum(value, context);
              //     }
                  
              //   }
              // )
            ],
          ),
        ),
      );
  }
}
