import 'package:flutter/material.dart';
import 'package:shoply/Features/authentation/presentation/views/widgets/login_view_body.dart';

import '../../../../constans.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(kBackGroundImage), fit: BoxFit.fill),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent, body: LoginViewBody()));
  }
}
