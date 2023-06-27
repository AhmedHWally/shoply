import 'package:flutter/material.dart';
import 'package:shoply/Features/cart/presentation/views/widgets/cartview_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: CartViewBody(),
    );
  }
}
