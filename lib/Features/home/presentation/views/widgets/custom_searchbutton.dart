import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/home/presentation/manager/products_cubit/products_cubit.dart';
import 'package:shoply/Features/home/presentation/manager/search_cubit/search_cubit.dart';

import '../../../../../constans.dart';
import '../search_view.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<SearchCubit>(context).productsList =
            BlocProvider.of<ProductsCubit>(context).productsList;
        BlocProvider.of<SearchCubit>(context).clearSearch();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const SearchView()));
      },
      child: Container(
        height: height * 0.075,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
            color: kSecondaryColor, borderRadius: BorderRadius.circular(32)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search',
              style: TextStyle(color: Colors.white, fontSize: 16, shadows: [
                Shadow(
                    color: kPrimaryColor, blurRadius: 1, offset: Offset(1, 1))
              ]),
            ),
            Icon(
              Icons.search,
              color: Colors.white,
              shadows: [
                Shadow(
                    color: kPrimaryColor, blurRadius: 1, offset: Offset(1, 1))
              ],
            )
          ],
        ),
      ),
    );
  }
}
