import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply/Features/home/data/models/products_model.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  final productsCollection = FirebaseFirestore.instance;
  final List<Product> _productsList = [];
  List<Product> _filterdProducts = [];
  List<Product> _favoritesList = [];
  Set<String> _categories = {'all'};
  List<Product> get productsList => [..._productsList];
  List<Product> get favoritesList => [..._favoritesList];
  List<Product> get filterdProducts => [..._filterdProducts];
  Set<String> get categories => {..._categories};
  void filterProducts(String category) {
    if (category == 'all') {
      _filterdProducts = _productsList.reversed.toList();
      emit(FilterProducts());
    } else if (_productsList
        .where((product) => product.category == category)
        .toList()
        .isNotEmpty) {
      _filterdProducts = _productsList
          .where((product) => product.category == category)
          .toList()
          .reversed
          .toList();
      emit(FilterProducts());
    } else {
      emit(FilterProducts());
    }
  }

  Future<void> loadProducts() async {
    String user = FirebaseAuth.instance.currentUser!.uid;
    emit(ProductsLoading());
    try {
      productsCollection
          .collection('products')
          .orderBy('dateOfUpload')
          .snapshots()
          .listen((event) async {
        _productsList.clear();
        _favoritesList.clear();

        _categories = {'all'};
        var snapshot =
            await productsCollection.collection('favorites').doc(user).get();
        Map<String, dynamic> favoriteItems =
            snapshot.data() as Map<String, dynamic>;
        for (var doc in event.docs) {
          _productsList.add(Product.fromJson(
              doc.data(), favoriteItems[doc.data()['id']] ?? false));
          _categories.add(doc.data()['category']);
        }
        _filterdProducts = _productsList.reversed.toList();
        _favoritesList =
            _productsList.where((item) => item.isFavorite == true).toList();
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
