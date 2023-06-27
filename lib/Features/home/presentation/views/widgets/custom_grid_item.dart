import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:shoply/constans.dart';

import '../../../../../core/widgets/custom_text.dart';
import '../../../data/models/products_model.dart';
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
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetails(
                            product: item,
                          )));
                },
                child: Column(children: [
                  SizedBox(
                    width: constrains.maxWidth,
                    height: constrains.maxHeight * 0.7,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: item.imageUrl[0],
                        placeholder: (context, url) => const Center(
                          child:
                              CircularProgressIndicator(color: kPrimaryColor),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constrains.maxHeight * 0.3,
                    width: constrains.maxWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Column(
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
                                    color: Colors.pink,
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
                                            color: Colors.black,
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
                                    color: Colors.pink,
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
                                            color: Colors.black,
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
