class Product {
  final String title;
  final num price;
  final String id;
  final List<dynamic> imageUrl;
  final String description;
  final String category;
  bool? isFavorite;
  Product(
      {required this.title,
      required this.id,
      required this.category,
      required this.price,
      required this.imageUrl,
      required this.description,
      this.isFavorite = false});

  factory Product.fromJson(json, bool isFavorite) => Product(
      title: json['title'],
      id: json['id'],
      category: json['category'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      description: json['about'],
      isFavorite: isFavorite);

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'category': category,
        'imageUrl': imageUrl,
        'description': description,
        'price': price
      };
}
