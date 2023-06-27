import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../constans.dart';
import '../../../data/models/products_model.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({super.key, required this.product});
  final Product product;

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
              controller: pageController,
              children: widget.product.imageUrl
                  .map(
                    (image) => CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, data) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  )
                  .toList()),
        ),
        const SizedBox(
          height: 8,
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: widget.product.imageUrl.length,
          effect: const WormEffect(
            dotColor: Colors.black26,
            spacing: 12,
            activeDotColor: kButtonColor,
          ),
          onDotClicked: (index) => pageController.animateToPage(index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut),
        ),
      ],
    );
  }
}
