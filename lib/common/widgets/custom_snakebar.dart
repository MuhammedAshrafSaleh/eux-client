import 'package:eux_client/resources/app_color.dart';
import 'package:flutter/material.dart';

class CustomSnakebar {
  static void showSuccessMessage({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: AppColor.white)),
        backgroundColor: AppColor.primary,
      ),
    );
  }

  static void showErrorMessage({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: AppColor.white)),
        backgroundColor: AppColor.error,
      ),
    );
  }
}
