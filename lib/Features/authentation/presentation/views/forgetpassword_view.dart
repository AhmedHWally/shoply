import 'package:flutter/material.dart';
import 'package:shoply/Features/authentation/presentation/views/widgets/forgetpassword_viewbody.dart';

import '../../../../constans.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

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
        child: const Scaffold(
            backgroundColor: Colors.transparent,
            body: ForgetPasswordViewBody()));
  }
}
