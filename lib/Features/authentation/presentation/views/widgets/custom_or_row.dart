import 'package:flutter/material.dart';
import 'package:shoply/constans.dart';

class CustomORRow extends StatelessWidget {
  const CustomORRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Expanded(
            child: Divider(
          height: 1,
          thickness: 1,
          color: kSecondaryColor,
        )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            'OR',
            style: TextStyle(color: kPrimaryColor, fontSize: 16),
          ),
        ),
        Expanded(
            child: Divider(
          height: 1,
          thickness: 1,
          color: kSecondaryColor,
        ))
      ],
    );
  }
}
