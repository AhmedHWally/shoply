class CartItem {
  final String title;
  final num price;
  final String? imageUrl;
  int quantity;
  CartItem(
      {required this.title,
      required this.price,
      this.imageUrl,
      this.quantity = 1});
}
