import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/cart/presentation/manager/cart_cubit/cart_cubit.dart';

import '../../../../../core/widgets/mainApp_elevated_button.dart';
import '../../../data/models/products_model.dart';

class addToCartButton extends StatelessWidget {
  const addToCartButton({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: constrains.maxWidth * 0.1,
            vertical: constrains.maxHeight * 0.125),
        child: MainAppElevatedButton(
          title: 'Add to cart',
          onPressed: () {
            BlocProvider.of<CartCubit>(context).addToCart(
                product.id, product.title, product.price, product.imageUrl[0]);
          },
        ),
      ),
    );
  }
}
