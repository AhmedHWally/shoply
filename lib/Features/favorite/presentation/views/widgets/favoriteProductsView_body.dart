import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/favorite/presentation/views/widgets/favorite_products_item.dart';

import '../../../../../constans.dart';
import '../../manager/favorite_cubit/favorite_cubit.dart';

class FavoriteProductsBody extends StatelessWidget {
  const FavoriteProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) =>
            BlocProvider.of<FavoriteCubit>(context).favoriteItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: const DecorationImage(
                                  image: AssetImage(kAddToFavoriteImage))),
                        ),
                        const Text(
                          'Add your favorite items now!',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: BlocProvider.of<FavoriteCubit>(context)
                            .favoriteItems
                            .length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 12,
                          crossAxisCount: 1,
                          mainAxisExtent: height * 0.25,
                        ),
                        itemBuilder: (context, index) => FavoriteProductsItem(
                              index: index,
                              product: BlocProvider.of<FavoriteCubit>(context)
                                  .favoriteItems[index],
                            )),
                  ));
  }
}
