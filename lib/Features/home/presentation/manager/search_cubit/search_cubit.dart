import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/products_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit() : super(SearchCubitInitial());
  List<Product> productsList = [];
  List<Product> searchedList = [];
  void searchProducts(String searchText) {
    searchText == ''
        ? searchedList = []
        : searchedList = productsList.where((element) {
            if (element.category.contains(searchText) ||
                element.title.contains(searchText)) {
              return true;
            } else {
              return false;
            }
          }).toList();
    searchedList.isEmpty || productsList.isEmpty
        ? emit(SearchListEmpty())
        : emit(SearchList(searchedList: searchedList));
  }

  void clearSearch() {
    searchedList = [];
    emit(SearchListEmpty());
  }
}
