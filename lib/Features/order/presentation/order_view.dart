import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/cart/data/models/cart_model.dart';
import 'package:shoply/Features/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:shoply/Features/order/presentation/widgets/orderview_body.dart';

import '../../../constans.dart';

class OrderView extends StatelessWidget {
  OrderView({super.key, required this.cartItems});
  List<CartItem> cartItems;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => OrderCubit(),
      child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(kBackGroundImage), fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: OrderViewBody(orderList: cartItems),
          )),
    );
  }
}
