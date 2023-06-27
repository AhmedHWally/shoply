import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomTextBuilder extends StatelessWidget {
  const CustomTextBuilder({
    super.key,
    required this.title,
    this.shadowColor = Colors.black87,
    this.fontSize = 18,
  });

  final String title;
  final Color shadowColor;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      style: TextStyle(color: Colors.white, fontSize: fontSize, shadows: [
        Shadow(color: shadowColor, offset: const Offset(1, 1), blurRadius: 1)
      ]),
    );
  }
}
