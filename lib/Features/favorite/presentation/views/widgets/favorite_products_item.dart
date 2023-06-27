import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:shoply/core/widgets/custom_text.dart';

import '../../../../../constans.dart';
import '../../../../home/data/models/products_model.dart';
import '../../../../home/presentation/views/product_details_view.dart';

class FavoriteProductsItem extends StatelessWidget {
  const FavoriteProductsItem({
    super.key,
    required this.index,
    required this.product,
  });
  final int index;
  final Product product;

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
                            product: product,
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
                        imageUrl: product.imageUrl[0],
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
                              title: product.title,
                            ),
                          ),
                          Expanded(
                            child: CustomTextBuilder(
                              title: '\$ ${product.price}',
                              shadowColor: Colors.black26,
                              fontSize: 14,
                            ),
                          ),
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
                    child: IconButton(
                      icon: const Icon(Icons.favorite,
                          color: Colors.pink,
                          shadows: [
                            Shadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 1)
                          ]),
                      onPressed: () {
                        BlocProvider.of<FavoriteCubit>(context)
                            .toggleFavorites(product.id, product);
                      },
                    ),
                  ))
            ],
          )),
    );
  }
}
