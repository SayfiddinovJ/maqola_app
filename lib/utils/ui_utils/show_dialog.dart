import 'package:columnist/utils/app_colors.dart';
import 'package:flutter/material.dart';

void showErrorMessage(
    {required String message, required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: AppColors.FF171717,
      title: const Text(
        'Error',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      ),
      content: Text(
        message,
        style:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"))
      ],
    ),
  );
}

void showConfirmMessage(
    {required String title,
    required String message,
    required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: AppColors.FF171717,
      title: Text(
        title,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      content: Text(
        message,
        style:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"))
      ],
    ),
  );
}
