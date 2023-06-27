import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:shoply/Features/home/presentation/views/widgets/product_details_item.dart';
import 'package:shoply/Features/home/presentation/views/widgets/product_images_pageview.dart';
import 'package:shoply/core/utils/function/custom_snackbar.dart';
import '../../../data/models/products_model.dart';
import 'addToCart_button.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is AddToCart) {
            customSnackBar(context, 'Item added to the cart', () {
              BlocProvider.of<CartCubit>(context)
                  .removeSpecificItem(product.id);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }, 'undo', duration: const Duration(seconds: 1));
          } else if (state is ItemInCart) {
            customSnackBar(context, 'Item already in the cart', () {
              BlocProvider.of<CartCubit>(context)
                  .removeSpecificItem(product.id);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }, 'remove', duration: const Duration(seconds: 1));
          } else if (state is RemoveFromCart) {
            customSnackBar(
                context, 'Item removed from the cart', () => null, '',
                duration: const Duration(seconds: 1));
          }
        },
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    width: width,
                    height: height * 0.375,
                    child: ProductImages(
                      product: product,
                    )),
                Positioned(
                    left: 12,
                    top: 12,
                    child: CircleAvatar(
                      radius: width < 650 ? width / 16 : width / 24,
                      backgroundColor: Colors.white54,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ))
              ],
            ),
            const Divider(),
            Expanded(
                child: ProductDetailsItem(
              product: product,
              width: width,
              height: height,
            )),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: height * 0.1,
              width: width,
              child: addToCartButton(
                product: product,
              ),
            )
          ],
        ),
      ),
    );
  }
}
