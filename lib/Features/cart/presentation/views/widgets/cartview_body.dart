import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/order/presentation/order_view.dart';
import 'package:shoply/constans.dart';
import 'package:shoply/core/widgets/mainApp_elevated_button.dart';

import '../../manager/cart_cubit/cart_cubit.dart';
import 'cart_item.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is RemoveSpecificItemFromCart) {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    content: const Text(
                        'do you want to remove this item from the cart?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<CartCubit>(context)
                                .removeFromCart(state.productId);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('yes'))
                    ],
                  ));
        } else if (state is ConfirmRemove) {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    content: const Text(
                        'do you want to remove this item from the cart?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<CartCubit>(context)
                                .removeSpecificItem(state.productId);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('yes'))
                    ],
                  ));
        }
      },
      builder: (context, state) => BlocProvider.of<CartCubit>(context)
              .cartItems
              .isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                            image: AssetImage(kAddToCartImage))),
                  ),
                  const Text(
                    'add items to cart now!',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                ],
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomCartItem(
                          index: index,
                          id: BlocProvider.of<CartCubit>(context)
                              .cartItems
                              .keys
                              .elementAt(index),
                        );
                      },
                      itemCount:
                          BlocProvider.of<CartCubit>(context).cartItems.length,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: const Divider(
                      color: kPrimaryColor,
                      height: 2,
                      thickness: 1,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.all(8),
                      height: height * 0.1,
                      child: LayoutBuilder(
                        builder: (context, constrains) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'total price:',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  BlocProvider.of<CartCubit>(context)
                                      .total
                                      .toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                                width: constrains.maxWidth * 0.45,
                                height: constrains.maxHeight * 0.7,
                                child: MainAppElevatedButton(
                                  title: 'Check out',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => OrderView(
                                                cartItems:
                                                    BlocProvider.of<CartCubit>(
                                                            context)
                                                        .cartItems
                                                        .values
                                                        .toList())));
                                  },
                                ))
                          ],
                        ),
                      ))
                ],
              ),
            ),
    );
  }
}
