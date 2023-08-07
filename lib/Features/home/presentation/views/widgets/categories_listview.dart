import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/home/presentation/manager/products_cubit/products_cubit.dart';

import '../../../../../constans.dart';

class CategoriesListView extends StatelessWidget {
  final double height;
  final double width;

  const CategoriesListView({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    List<String> names =
        BlocProvider.of<ProductsCubit>(context).categories.toList();
    return BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
      names = BlocProvider.of<ProductsCubit>(context).categories.toList();
    }, builder: (context, state) {
      if (state is ProductsSuccess || state is EmptyFavorites) {
        return SizedBox(
          height: height * 0.05,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: SizedBox(
                  width: width * 0.275,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      names[index] == 'favorites'
                          ? Icons.favorite
                          : Icons.shopify_sharp,
                      shadows: const [
                        Shadow(
                            color: kPrimaryColor,
                            blurRadius: 1,
                            offset: Offset(1, 1))
                      ],
                    ),
                    label: FittedBox(
                        child: Text(
                      names[index],
                      style: const TextStyle(shadows: [
                        Shadow(
                            color: kPrimaryColor,
                            blurRadius: 1,
                            offset: Offset(1, 1))
                      ]),
                    )),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: () {
                      BlocProvider.of<ProductsCubit>(context)
                          .filterProducts(names[index]);
                    },
                  ),
                ),
              ),
              itemCount: names.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      } else {
        return SizedBox(
          height: height * 0.1,
        );
      }
    });
  }
}
