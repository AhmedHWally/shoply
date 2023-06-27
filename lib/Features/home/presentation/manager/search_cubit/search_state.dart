part of 'search_cubit.dart';

@immutable
abstract class SearchCubitState {}

class SearchCubitInitial extends SearchCubitState {}

class SearchListEmpty extends SearchCubitState {}

class SearchList extends SearchCubitState {
  final List<Product> searchedList;
  SearchList({required this.searchedList});
}
