import 'package:flutter/material.dart';
import 'package:shoply/constans.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      this.onPressed});

  final double width;
  final double height;
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width * 0.8,
        height: height * 0.065,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              backgroundColor: kPrimaryColor),
          child: Text(text),
        ));
  }
}
