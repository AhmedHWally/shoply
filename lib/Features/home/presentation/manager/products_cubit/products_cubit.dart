import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply/Features/home/data/models/products_model.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  final productsCollection = FirebaseFirestore.instance;
  List<Product> productsList = [];
  List<Product> filterdProducts = [];
  List<Product> favoritesList = [];

  void filterProducts(String category) {
    if (productsList
        .where((product) => product.category == category)
        .toList()
        .isNotEmpty) {
      filterdProducts = productsList
          .where((product) => product.category == category)
          .toList();
      emit(ProductsSuccess());
    } else {
      filterdProducts = productsList;
      emit(ProductsSuccess());
    }
  }

  Future<void> loadProducts() async {
    String user = FirebaseAuth.instance.currentUser!.uid;

    emit(ProductsLoading());
    try {
      var snapshot =
          await productsCollection.collection('favorites').doc(user).get();
      Map<String, dynamic> favoriteItems =
          snapshot.data() as Map<String, dynamic>;

      productsCollection.collection('products').snapshots().listen((event) {
        emit(ProductsLoading());
        productsList.clear();
        for (var doc in event.docs) {
          productsList.add(Product.fromJson(
              doc.data(), favoriteItems[doc.data()['id']] ?? false));
        }
        filterdProducts = productsList;
        favoritesList =
            productsList.where((item) => item.isFavorite == true).toList();

        emit(ProductsSuccess());
      });
    } on FirebaseException catch (e) {
      if (e.message != null) {
        emit(ProductsFailure(errMessage: e.toString()));
      } else {
        emit(ProductsFailure(errMessage: 'Some thing went wrong!'));
      }
    } catch (e) {
      emit(ProductsFailure(errMessage: e.toString()));
    }
  }
}
