import 'package:shoply/Features/cart/data/models/cart_model.dart';

class OrderModel {
  final String userName;
  final String userAddress;
  final String userPhoneNumber;
  final String total;
  final DateTime? dateOfOrder;
  final List<CartItem> orderItems;
  final String? orderState;
  OrderModel(
      {required this.userName,
      required this.userAddress,
      required this.userPhoneNumber,
      required this.total,
      required this.orderItems,
      this.dateOfOrder,
      this.orderState});

  Map<String, dynamic> tojson(OrderModel orderModel) => {
        'userName': userName,
        'userAddress': userAddress,
        'userPhoneNumber': userPhoneNumber,
        'total': total,
        'orderItems': orderItems
            .map((e) =>
                {'title': e.title, 'quantity': e.quantity, 'price': e.price})
            .toList(),
        'dateOfOrder': dateOfOrder,
        'orderstate': 'order under review'
      };

  factory OrderModel.fromjson(Map<String, dynamic> json) => OrderModel(
      userName: json['userName'],
      userAddress: json['userAddress'],
      userPhoneNumber: json['userPhoneNumber'],
      total: json['total'],
      orderItems: (json['orderItems'] as List<dynamic>)
          .map((item) => CartItem(
              title: item['title'],
              price: item['price'],
              quantity: item['quantity']))
          .toList(),
      orderState: json['orderstate']);
}
