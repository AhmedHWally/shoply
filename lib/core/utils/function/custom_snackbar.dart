import 'package:flutter/material.dart';

void customSnackBar(context, String text, Function() onPressed, String label,
    {Duration duration = const Duration(seconds: 2)}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: duration,
    action: SnackBarAction(
        label: label, textColor: Colors.red, onPressed: onPressed),
  ));
}
