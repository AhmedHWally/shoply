import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../home/data/models/products_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  List<Product> favoriteItems = [];

  void toggleFavorites(
    String id,
    Product product,
  ) async {
    product.isFavorite = !product.isFavorite!;

    String user = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('favorites')
        .doc(user)
        .update({id: product.isFavorite});

    if (favoriteItems.contains(product)) {
      favoriteItems.removeWhere((element) => element.id == product.id);
    } else {
      favoriteItems.add(product);
    }
    emit(FavoriteSuccess());
  }
}
