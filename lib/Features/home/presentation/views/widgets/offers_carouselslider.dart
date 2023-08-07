import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constans.dart';
import '../../manager/offers_cubit/offers_cubit.dart';

class OffersSlider extends StatefulWidget {
  const OffersSlider({super.key});

  @override
  State<OffersSlider> createState() => _OffersSliderState();
}

class _OffersSliderState extends State<OffersSlider> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit, OffersState>(builder: (context, state) {
      if (state is OffersSuccess) {
        return CarouselSlider.builder(
            itemCount: state.imagesUrls.length,
            itemBuilder: (context, index, realIndex) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: state.imagesUrls[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: kPrimaryColor),
                          );
                        },
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
      } else if (state is OffersLoading) {
        return const Center(
          child: CircularProgressIndicator(color: kPrimaryColor),
        );
      } else if (state is OffersFaliure) {
        return const Center(
          child: Text('no offers avilable'),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(color: kPrimaryColor),
        );
      }
    });
  }
}
