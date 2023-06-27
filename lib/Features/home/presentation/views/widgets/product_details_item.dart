import 'package:flutter/material.dart';

import '../../../data/models/products_model.dart';

class ProductDetailsItem extends StatelessWidget {
  const ProductDetailsItem({
    super.key,
    required this.width,
    required this.height,
    required this.product,
  });

  final Product product;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            product.title,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SizedBox(
              width: width,
              child: Text(
                product.description,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SizedBox(
              width: width,
              child: Text(
                'price: \$${product.price.toStringAsFixed(2)}',
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
