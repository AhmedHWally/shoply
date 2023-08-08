import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../home/data/models/products_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  List<Product> _favoriteItems = [];
  set favoriteItems(List<Product> items) {
    _favoriteItems = items;
  }

  List<Product> get favoriteItems => [..._favoriteItems].reversed.toList();

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

    if (_favoriteItems.contains(product)) {
      _favoriteItems.removeWhere((element) => element.id == product.id);
    } else {
      _favoriteItems.add(product);
    }
    print(_favoriteItems);
    print(product.title);
    emit(FavoriteSuccess());
  }
}
