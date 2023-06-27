import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../constans.dart';

class BestProductsSlider extends StatefulWidget {
  const BestProductsSlider({super.key});

  @override
  State<BestProductsSlider> createState() => _BestProductsSliderState();
}

class _BestProductsSliderState extends State<BestProductsSlider> {
  final imagesUrls = [
    'https://img.freepik.com/free-psd/summer-sale-70-discount_23-2148476960.jpg',
    'https://assetscdn1.paytm.com/images/catalog/view_item/787364/1617369686163.jpg?imwidth=480&impolicy=hq',
    'https://static.toiimg.com/thumb/resizemode-4,width-1200,height-900,msid-76477042/76477042.jpg',
    'https://www.shopickr.com/wp-content/uploads/2015/10/amazon-india-electronics-sale-2015-banner1.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: imagesUrls.length,
        itemBuilder: (context, index, realIndex) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: imagesUrls[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return const Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      );
                    },
                  )),
            ),
        options: CarouselOptions(
            viewportFraction: 0.8,
            height: MediaQuery.of(context).size.height * 0.2,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            pauseAutoPlayOnManualNavigate: true,
            pauseAutoPlayOnTouch: true,
            enlargeCenterPage: true));
  }
}
