import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoply/constans.dart';

import '../../../../../core/widgets/custom_text.dart';
import '../../../data/models/products_model.dart';
import '../../manager/favorite_cubit/favorite_cubit.dart';
import '../product_details_view.dart';

class CustomGridItem extends StatelessWidget {
  const CustomGridItem({super.key, required this.item, required this.index});
  final Product item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: kSecondaryColor),
          child: Stack(
            children: [
              SizedBox(
                width: constrains.maxWidth,
                height: constrains.maxHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl[0],
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(color: kPrimaryColor),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetails(
                            product: item,
                          )));
                },
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    height: constrains.maxHeight * 0.3,
                    width: constrains.maxWidth,
                    decoration: const BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: MediaQuery.of(context).size.width > 650
                          ? Row(
                              children: [
                                Expanded(
                                  child: CustomTextBuilder(
                                    title: item.title,
                                  ),
                                ),
                                Expanded(
                                    child: CustomTextBuilder(
                                  title: '\$ ${item.price.toStringAsFixed(2)}',
                                  shadowColor: Colors.black26,
                                  fontSize: 14,
                                )),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextBuilder(
                                    title: item.title,
                                  ),
                                ),
                                Expanded(
                                    child: CustomTextBuilder(
                                  title: '\$ ${item.price.toStringAsFixed(2)}',
                                  shadowColor: Colors.black26,
                                  fontSize: 14,
                                )),
                              ],
                            ),
                    ),
                  )
                ]),
              ),
              Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    backgroundColor: Colors.black12,
                    child: BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, state) {
                        if (state is FavoriteSuccess) {
                          return IconButton(
                            onPressed: () async {
                              BlocProvider.of<FavoriteCubit>(context)
                                  .toggleFavorites(
                                item.id,
                                item,
                              );
                            },
                            icon: item.isFavorite!
                                ? const Icon(Icons.favorite,
                                    color: kIconCollor,
                                    shadows: [
                                        Shadow(
                                            color: Colors.black,
                                            offset: Offset(1, 1),
                                            blurRadius: 1)
                                      ])
                                : const Icon(Icons.favorite,
                                    color: Colors.white,
                                    shadows: [
                                        Shadow(
                                            color: kIconCollor,
                                            offset: Offset(1, 1),
                                            blurRadius: 1)
                                      ]),
                          );
                        } else {
                          return IconButton(
                            onPressed: () async {
                              BlocProvider.of<FavoriteCubit>(context)
                                  .toggleFavorites(
                                item.id,
                                item,
                              );
                            },
                            icon: item.isFavorite as bool
                                ? const Icon(Icons.favorite,
                                    color: kIconCollor,
                                    shadows: [
                                        Shadow(
                                            color: Colors.black,
                                            offset: Offset(1, 1),
                                            blurRadius: 1)
                                      ])
                                : const Icon(Icons.favorite,
                                    color: Colors.white,
                                    shadows: [
                                        Shadow(
                                            color: kIconCollor,
                                            offset: Offset(1, 1),
                                            blurRadius: 1)
                                      ]),
                          );
                        }
                      },
                    ),
                  ))
            ],
          )),
    );
  }
}
