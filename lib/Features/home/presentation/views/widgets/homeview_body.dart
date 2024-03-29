import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/home/presentation/manager/products_cubit/products_cubit.dart';
import 'package:shoply/constans.dart';

import '../../../../favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import '../../../data/models/products_model.dart';

import 'categories_listview.dart';
import 'custom_searchbutton.dart';
import 'offers_carouselslider.dart';
import 'custom_grid_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Product> products =
        BlocProvider.of<ProductsCubit>(context).filterdProducts;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
              child: Column(children: [
            const SizedBox(
              height: 16,
            ),
            CustomAppBar(height: height),
            const SizedBox(
              height: 16,
            ),
            const OffersSlider(),
            const SizedBox(
              height: 16,
            ),
            CategoriesListView(height: height, width: width),
            const SizedBox(
              height: 12,
            ),
          ])),
          BlocConsumer<ProductsCubit, ProductsState>(
              listener: (context, state) {
            if (state is ProductsSuccess) {
              products =
                  BlocProvider.of<ProductsCubit>(context).filterdProducts;
              BlocProvider.of<FavoriteCubit>(context).favoriteItems =
                  BlocProvider.of<ProductsCubit>(context).favoritesList;
            } else if (state is FilterProducts) {
              products =
                  BlocProvider.of<ProductsCubit>(context).filterdProducts;
            }
          }, builder: (context, state) {
            if (state is ProductsSuccess || state is FilterProducts) {
              return SliverPadding(
                padding:
                    EdgeInsets.symmetric(horizontal: width * 0.04, vertical: 8),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                      mainAxisExtent: height * 0.25,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => CustomGridItem(
                    item: products[index],
                    index: index,
                  ),
                  itemCount: products.length,
                ),
              );
            } else if (state is ProductsFailure) {
              return SliverToBoxAdapter(
                  child: Center(
                      child: Text(
                'Some thing went wrong! ${state.errMessage}',
              )));
            } else {
              return const SliverToBoxAdapter(
                  child: Center(
                      child: CircularProgressIndicator(
                color: kPrimaryColor,
              )));
            }
          }),
        ],
      ),
    );
  }
}
