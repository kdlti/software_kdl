import 'package:flutter/material.dart';

abstract class ErrorNotifier {
  void showErrorMessage(BuildContext context, String errorMessage);
  void showConfirmationMessage(BuildContext context);
  Future<void> showLoading(BuildContext context);
  void hideLoading(BuildContext context);
}
