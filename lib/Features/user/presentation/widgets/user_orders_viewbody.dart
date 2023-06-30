import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constans.dart';
import '../../../order/data/order_model.dart';
import '../../../order/presentation/manager/order_cubit/order_cubit.dart';

class UserOrdersViewBody extends StatelessWidget {
  UserOrdersViewBody({super.key});
  List<OrderModel> userOrders = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is GetUserOrdersSuccessed) {
          userOrders =
              BlocProvider.of<OrderCubit>(context).userOrders.reversed.toList();
        }
      },
      builder: (context, state) {
        if (state is GetUserOrdersStarted) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        } else if (state is UserOrdersEmpty) {
          return Center(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 26,
                          )),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: const DecorationImage(
                              image: AssetImage(kemptyOrderPage),
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'You don\'t have any orders',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 26,
                        )),
                    const Expanded(
                      child: Text(
                        'My Orders',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Items:'),
                                    Expanded(
                                        child: SingleChildScrollView(
                                      child: Column(
                                          children:
                                              userOrders[index].orderItems.map(
                                        (item) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(child: Text(item.title)),
                                              Expanded(
                                                child: Text(
                                                    'price: ${item.price * item.quantity}\$'),
                                              ),
                                              Text('x ${item.quantity}')
                                            ],
                                          );
                                        },
                                      ).toList()),
                                    )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Total price:'),
                                        Text('${userOrders[index].total} \$')
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Order state:'),
                                        Text(
                                          '${userOrders[index].orderState}',
                                          style: TextStyle(
                                              color: '${userOrders[index].orderState}' ==
                                                      'order under review'
                                                  ? Colors.red
                                                  : '${userOrders[index].orderState}' ==
                                                          'Product is being delivered'
                                                      ? Colors
                                                          .lightGreen.shade500
                                                      : Colors.green.shade800),
                                        )
                                      ],
                                    )
                                  ]),

                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(BlocProvider.of<OrderCubit>(context)
                              //         .userOrders[index]
                              //         .total),

                              // ],
                            ),
                          ),
                        ),
                    itemCount: userOrders.length),
              ),
            ],
          );
        }
      },
    ));
  }
}
