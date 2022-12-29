import 'package:flutter/material.dart';

void showSnackBar(
    {required String message, required BuildContext context, int? duration}) {
  SnackBar snack = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(20),
    duration: duration != null
        ? Duration(milliseconds: duration)
        : const Duration(milliseconds: 500),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Text(
      message,
      textScaleFactor: 1,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.black.withAlpha(200),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
