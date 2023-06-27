import 'package:flutter/material.dart';

import '../../constans.dart';

class MainAppElevatedButton extends StatelessWidget {
  MainAppElevatedButton({super.key, this.onPressed, required this.title});

  void Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: kButtonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, shadows: [
          Shadow(blurRadius: 1, color: Colors.black, offset: Offset(1, 1))
        ]),
      ),
    );
  }
}
