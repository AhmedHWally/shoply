import 'package:flutter/material.dart';
import 'package:shoply/Features/user/presentation/widgets/user_orders_viewbody.dart';

import '../../../constans.dart';

class UserOrdersView extends StatelessWidget {
  const UserOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(kBackGroundImage), fit: BoxFit.fill)),
        child: Scaffold(
            backgroundColor: Colors.transparent, body: UserOrdersViewBody()));
  }
}
