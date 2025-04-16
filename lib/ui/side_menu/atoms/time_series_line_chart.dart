// import 'package:flutter/material.dart';
// import 'package:graphic/graphic.dart';
// import 'package:intl/intl.dart';

// class TimeSeriesSales {
//   final DateTime time;
//   final int sales;

//   TimeSeriesSales(this.time, this.sales);
// }

// final timeSeriesSales = [
//   TimeSeriesSales(DateTime(2017, 9, 19), 5),
//   TimeSeriesSales(DateTime(2017, 9, 26), 25),
//   TimeSeriesSales(DateTime(2017, 10, 3), 100),
//   TimeSeriesSales(DateTime(2017, 10, 10), 75),
// ];

// final _monthDayFormat = DateFormat('MM-dd');

// class TimeSeriesLineChart extends StatelessWidget {
//   const TimeSeriesLineChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(1, 1),
//             spreadRadius: 0.1,
//             blurRadius: 4,
//             color: Colors.black,
//           )
//         ],
//       ),
//       width: 700,
//       height: 300,
//       child: Chart(
//         data: timeSeriesSales,
//         variables: {
//           'time': Variable(
//             accessor: (TimeSeriesSales datum) => datum.time,
//             scale: TimeScale(
//               formatter: (time) => _monthDayFormat.format(time),
//             ),
//           ),
//           'sales': Variable(
//             accessor: (TimeSeriesSales datum) => datum.sales,
//           ),
//         },
//         marks: [
//           LineMark(
//             shape: ShapeEncode(value: BasicLineShape(dash: [5, 2])),
//             selected: {
//               'touchMove': {1}
//             },
//           )
//         ],
//         coord: RectCoord(color: const Color(0xffdddddd)),
//         axes: [
//           Defaults.horizontalAxis,
//           Defaults.verticalAxis,
//         ],
//         selections: {
//           'touchMove': PointSelection(
//             on: {
//               GestureType.scaleUpdate,
//               GestureType.tapDown,
//               GestureType.longPressMoveUpdate
//             },
//             dim: Dim.x,
//           )
//         },
//         tooltip: TooltipGuide(
//           followPointer: [false, true],
//           align: Alignment.topLeft,
//           offset: const Offset(-20, -20),
//         ),
//         crosshair: CrosshairGuide(followPointer: [false, true]),
//       ),
//     );
//   }
// }
