import 'package:flutter/material.dart';
import 'package:shoply/constans.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.isSecure = false,
      this.iconShape,
      this.textInputAction,
      this.textInputType,
      this.onSaved,
      this.controller});

  final String hintText;
  final bool? isSecure;
  final IconData? iconShape;
  final TextEditingController? controller;

  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      height: height * 0.075,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: kSecondaryColor,
      ),
      child: TextFormField(
        cursorColor: kPrimaryColor,
        controller: controller,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        onSaved: onSaved,
        validator: (value) {
          switch (hintText) {
            case 'email':
              if (value!.isEmpty || !value.contains('@')) {
                return 'please enter a valid email';
              } else {
                return null;
              }
            case 'password':
              if (value!.isEmpty) {
                return 'please enter a valid password';
              } else if (value.length < 6) {
                return 'password must be more than 6';
              } else {
                return null;
              }
            case 'user name':
              if (value!.isEmpty) {
                return 'please enter a user name';
              } else {
                return null;
              }
            case 'phone number':
              if (value!.isEmpty ||
                  !value.startsWith('010') &&
                      !value.startsWith('011') &&
                      !value.startsWith('012') &&
                      !value.startsWith('015')) {
                return 'please enter a valid phone number';
              } else if (value.length < 11) {
                return 'the phone number must contain 11 number';
              } else {
                return null;
              }

            default:
              if (value!.isEmpty) {
                return 'this field can\'t be empty';
              }
          }
          return null;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            icon: Icon(
              iconShape,
              color: Colors.black87,
            )),
        obscureText: isSecure!,
      ),
    );
  }
}
