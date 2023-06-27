part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class AddToCart extends CartState {}

class RemoveFromCart extends CartState {}

class ItemInCart extends CartState {}

class CartItemUpdate extends CartState {}

class RemoveSpecificItemFromCart extends CartState {
  final String productId;
  RemoveSpecificItemFromCart({required this.productId});
}

class ConfirmRemove extends CartState {
  final String productId;
  ConfirmRemove({required this.productId});
}
