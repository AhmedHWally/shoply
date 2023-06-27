import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/home/presentation/manager/products_cubit/products_cubit.dart';

import '../../../../../constans.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final List names = [
      'all',
      'watches',
      'jackets',
      'jeans',
      'glasses',
      'shirts'
    ];
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
                icon: const Icon(Icons.shopify_sharp),
                label: FittedBox(child: Text(names[index])),
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
          itemCount: 6,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
