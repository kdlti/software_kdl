// import 'package:flutter/material.dart';
// import 'package:graphic/graphic.dart';

// const basicData = [
//   {'genre': 'Sports', 'sold': 275},
//   {'genre': 'Strategy', 'sold': 115},
//   {'genre': 'Action', 'sold': 120},
//   {'genre': 'Shooter', 'sold': 350},
//   {'genre': 'Other', 'sold': 150},
// ];

// class InteractiveBarChart extends StatelessWidget {
//   const InteractiveBarChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           boxShadow: [
//             BoxShadow(
//               offset: Offset(1, 1),
//               spreadRadius: 0.1,
//               blurRadius: 4,
//               color: Colors.black,
//             )
//           ]),
//       width: 500,
//       height: 300,
//       child: Chart(
//         data: basicData,
//         variables: {
//           'genre': Variable(
//             accessor: (Map map) => map['genre'] as String,
//           ),
//           'sold': Variable(
//             accessor: (Map map) => map['sold'] as num,
//           ),
//         },
//         marks: [
//           IntervalMark(
//             label: LabelEncode(
//                 encoder: (tuple) => Label(tuple['sold'].toString())),
//             elevation: ElevationEncode(value: 0, updaters: {
//               'tap': {true: (_) => 5}
//             }),
//             color: ColorEncode(value: Defaults.primaryColor, updaters: {
//               'tap': {false: (color) => color.withAlpha(100)}
//             }),
//           )
//         ],
//         axes: [
//           Defaults.horizontalAxis,
//           Defaults.verticalAxis,
//         ],
//         selections: {'tap': PointSelection(dim: Dim.x)},
//         tooltip: TooltipGuide(),
//         crosshair: CrosshairGuide(),
//       ),
//     );
//   }
// }
