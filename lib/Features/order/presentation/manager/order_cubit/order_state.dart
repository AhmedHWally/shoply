part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderStart extends OrderState {}

class OrderSuccess extends OrderState {}

class OrderFailed extends OrderState {}

class GetUserOrdersStarted extends OrderState {}

class UserOrdersEmpty extends OrderState {}

class GetUserOrdersFailed extends OrderState {
  final String errMessage;
  GetUserOrdersFailed({required this.errMessage});
}

class GetUserOrdersSuccessed extends OrderState {
  final List<OrderModel> userOrders;
  GetUserOrdersSuccessed({required this.userOrders});
}
