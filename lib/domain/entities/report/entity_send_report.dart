import 'package:equatable/equatable.dart';

class SendReportEntity extends Equatable {
  final String initialDate;
  final String finalDate;
  final String status;

  @override
  List get props => [
        initialDate,
        finalDate,
        status,
      ];

  const SendReportEntity({
    required this.initialDate,
    required this.finalDate,
    required this.status,
  });
}
