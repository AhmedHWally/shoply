import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:shoply/core/widgets/custom_text.dart';

import '../../../../../constans.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({super.key, required this.index, required this.id});
  final int index;
  final String id;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: kSecondaryColor),
      height: height * 0.2,
      child: Row(children: [
        CachedNetworkImage(
          imageUrl: BlocProvider.of<CartCubit>(context)
              .cartItems
              .values
              .elementAt(index)
              .imageUrl!,
          imageBuilder: (context, imageProvider) => Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            width: width * 0.275,
          ),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextBuilder(
                      title: BlocProvider.of<CartCubit>(context)
                          .cartItems
                          .values
                          .elementAt(index)
                          .title,
                      fontSize: 20,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextBuilder(
                      title:
                          '\$${BlocProvider.of<CartCubit>(context).cartItems.values.elementAt(index).price}',
                      fontSize: 16,
                      shadowColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<CartCubit>(context).confirmRemove(id);
                  },
                  icon: const Icon(
                    Icons.delete_sharp,
                    color: kPrimaryColor,
                    size: 28,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 0.5)
                    ],
                  )),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: Colors.white)),
                height: height * 0.15,
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<CartCubit>(context)
                                .increaseQuantityAndPrice(id);
                          },
                          icon: const Icon(Icons.add)),
                      Text(
                        ' ${BlocProvider.of<CartCubit>(context).cartItems.values.elementAt(index).quantity} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<CartCubit>(context)
                                .decreaseQuantityAndPrice(id);
                          },
                          icon: const Icon(Icons.remove))
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ]),
    );
  }
}
