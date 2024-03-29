import 'package:flutter/material.dart';
import 'package:shoply/Features/authentation/presentation/views/widgets/signup_view_body.dart';

import '../../../../constans.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(kBackGroundImage), fit: BoxFit.fill),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent, body: SignUpViewBody()));
  }
}
