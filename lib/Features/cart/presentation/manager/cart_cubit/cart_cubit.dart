import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  Map<String, CartItem> _cartItems = {};
  Map<String, CartItem> get cartItems => {..._cartItems};
  double total = 0.0;
  void addToCart(String productId, String title, num price, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      emit(ItemInCart());
      return;
    }
    _cartItems.putIfAbsent(productId,
        () => CartItem(title: title, price: price, imageUrl: imageUrl));
    total += price;
    emit(AddToCart());
  }

  void emptyCart() {
    _cartItems = {};
    total = 0.0;
    emit(RemoveFromCart());
  }

  void removeFromCart(String productId) {
    total -= _cartItems[productId]!.price;
    _cartItems.remove(productId);
    emit(RemoveFromCart());
  }

  void confirmRemove(String productId) {
    emit(ConfirmRemove(productId: productId));
  }

  void removeSpecificItem(String productId) {
    total -= _cartItems[productId]!.price * _cartItems[productId]!.quantity;
    _cartItems.remove(productId);
    emit(RemoveFromCart());
  }

  void increaseQuantityAndPrice(String productId) {
    _cartItems.update(
        productId,
        (existingCartItem) => CartItem(
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity + 1,
            imageUrl: existingCartItem.imageUrl));
    total += _cartItems[productId]!.price;
    emit(CartItemUpdate());
  }

  void decreaseQuantityAndPrice(String productId) {
    if (_cartItems[productId]!.quantity == 1) {
      emit(RemoveSpecificItemFromCart(productId: productId));
    } else {
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1,
              imageUrl: existingCartItem.imageUrl));
      total -= _cartItems[productId]!.price;
    }
    emit(CartItemUpdate());
  }
}
