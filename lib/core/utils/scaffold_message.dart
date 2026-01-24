import 'package:flutter/material.dart';

SnackBar snackBar({
  required String message,
  required Color bgColor,
  int seconds = 2,
}) {
  return SnackBar(
    duration: Duration(seconds: seconds),
    content: Text(message),
    backgroundColor: bgColor,
  );
}
