import 'package:flutter/material.dart';
import 'package:shoply/Features/favorite/presentation/views/widgets/favoriteProductsView_body.dart';

class FavoriteProductsView extends StatelessWidget {
  const FavoriteProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: FavoriteProductsBody(),
    );
  }
}
