import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shoply/Features/order/data/order_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  final firestore = FirebaseFirestore.instance;
  List<OrderModel> userOrders = [];
  Future<void> placeOrder(OrderModel order) async {
    final user = FirebaseAuth.instance;
    emit(OrderStart());
    try {
      await firestore
          .collection('orders')
          .doc(user.currentUser!.email)
          .collection('userOrders')
          .add(order.tojson(order));
      emit(OrderSuccess());
    } catch (e) {
      emit(OrderFailed());
    }
  }

  Future<void> getUserOrders() async {
    final user = FirebaseAuth.instance;
    emit(GetUserOrdersStarted());
    try {
      userOrders.clear();
      var snapshot = await firestore
          .collection('orders')
          .doc(user.currentUser!.email)
          .collection('userOrders')
          .orderBy('dateOfOrder')
          .get();
      for (var item in snapshot.docs) {
        userOrders.add(OrderModel.fromjson(item.data()));
      }
      if (userOrders.isEmpty) {
        emit(UserOrdersEmpty());
      } else {
        emit(GetUserOrdersSuccessed(userOrders: userOrders));
      }
    } on FirebaseException catch (e) {
      if (e.message != null) {
        emit(GetUserOrdersFailed(errMessage: e.toString()));
      } else {
        emit(GetUserOrdersFailed(errMessage: 'Some thing went wrong!'));
      }
    } catch (e) {
      emit(GetUserOrdersFailed(errMessage: e.toString()));
    }
  }
}
