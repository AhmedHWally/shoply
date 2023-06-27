import 'package:flutter/material.dart';
import 'package:shoply/Features/home/presentation/views/widgets/product_details_view_body.dart';

import '../../../../constans.dart';
import '../../data/models/products_model.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.product,
  });
  final Product product;
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
          backgroundColor: Colors.transparent,
          body: ProductDetailsBody(product: product),
        ));
  }
}
