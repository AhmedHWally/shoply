import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key, this.onPressed, required this.buttonTitle});
  final void Function()? onPressed;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          buttonTitle,
          style: const TextStyle(fontSize: 22, color: Colors.black),
        ));
  }
}
