import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/home/presentation/manager/search_cubit/search_cubit.dart';

import '../../../../../constans.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import '../product_details_view.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Column(children: [
      const SizedBox(
        height: 16,
      ),
      Row(
        children: [
          IconButton(
            padding: const EdgeInsets.only(left: 6),
            constraints: const BoxConstraints(),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 26,
            ),
          ),
          Expanded(
            child: Container(
              height: height * 0.075,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(32)),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    autofocus: true,
                    cursorColor: kPrimaryColor,
                    onChanged: (value) {
                      BlocProvider.of<SearchCubit>(context)
                          .searchProducts(value);
                    },
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.white)),
                  )),
                  const Icon(
                    Icons.search,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      BlocBuilder<SearchCubit, SearchCubitState>(builder: (context, state) {
        if (state is SearchList) {
          return Expanded(
              child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Container(
                  height: height * 0.25,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: kSecondaryColor),
                  child: LayoutBuilder(
                    builder: (context, constrains) => Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Future.delayed(
                              const Duration(milliseconds: 150),
                              () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                          product: state.searchedList[index],
                                        )));
                              },
                            );
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
                                  imageUrl:
                                      state.searchedList[index].imageUrl[0],
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                        color: kPrimaryColor),
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
                                        title: state.searchedList[index].title,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomTextBuilder(
                                        title:
                                            '\$ ${state.searchedList[index].price}',
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
                            child: BlocBuilder<FavoriteCubit, FavoriteState>(
                              builder: (context, state) => CircleAvatar(
                                backgroundColor: Colors.black12,
                                child: IconButton(
                                  icon: Icon(Icons.favorite,
                                      color:
                                          BlocProvider.of<SearchCubit>(context)
                                                      .searchedList[index]
                                                      .isFavorite ==
                                                  true
                                              ? Colors.pink
                                              : Colors.white,
                                      shadows: const [
                                        Shadow(
                                            color: Colors.black,
                                            offset: Offset(1, 1),
                                            blurRadius: 1)
                                      ]),
                                  onPressed: () {
                                    BlocProvider.of<FavoriteCubit>(context)
                                        .toggleFavorites(
                                            BlocProvider.of<SearchCubit>(
                                                    context)
                                                .searchedList[index]
                                                .id,
                                            BlocProvider.of<SearchCubit>(
                                                    context)
                                                .searchedList[index]);
                                  },
                                ),
                              ),
                            ))
                      ],
                    ),
                  )),
            ),
            itemCount: state.searchedList.length,
          ));
        } else {
          return const Center(
            child: Text(
              'Search now !',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }
      })
    ]));
  }
}
